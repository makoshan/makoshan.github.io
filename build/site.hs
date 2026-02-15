#!/usr/bin/env runghc
{-# LANGUAGE OverloadedStrings, GeneralizedNewtypeDeriving #-}

{-
Hakyll file for building Gwern.net
Author: gwern
Date: 2010-10-01
When: Time-stamp: "2026-02-05 11:35:59 gwern"
License: CC-0

Debian dependencies:
$ sudo apt-get install libghc-hakyll-dev libghc-pandoc-dev libghc-filestore-dev libghc-tagsoup-dev imagemagick rsync git libghc-aeson-dev libghc-missingh-dev libghc-digest-dev tidy gridsite-clients

(GHC is needed for Haskell; Hakyll & Pandoc do the heavy lifting of compiling Markdown files to HTML; tag soup & ImageMagick are runtime dependencies used to help optimize images, and rsync for the server/git upload to hosting/Github respectively.)
Demo command (for the full script, with all static checks & generation & optimizations, see `sync.sh`):
-}

import Control.Monad (when, unless, forM, (<=<))
import Data.Char (toLower)
import Data.List (intercalate, isInfixOf, isPrefixOf, isSuffixOf, group, sort)
import qualified Data.Map.Strict as M (lookup)
import Data.Maybe (isNothing, fromMaybe)
import System.Environment (getArgs, withArgs, lookupEnv)
import Hakyll (compile, composeRoutes, constField, fromGlob, -- symlinkFileCompiler,
               copyFileCompiler, defaultContext, defaultHakyllReaderOptions, field, getMetadata, getMetadataField, lookupString,
               defaultHakyllWriterOptions, getRoute, gsubRoute, hakyll, idRoute, itemIdentifier,
               loadAndApplyTemplate, match, modificationTimeField, mapContext,
               pandocCompilerWithTransformM, route, setExtension, pathField, preprocess, boolField, toFilePath,
               templateCompiler, version, Compiler, Context, Item, unsafeCompiler, noResult, getUnderlying, escapeHtml, (.&&.), (.||.), complement, constRoute)
import qualified Hakyll (Metadata)
import Text.Pandoc (nullAttr, runPure, runWithDefaultPartials, compileTemplate,
                    def, pandocExtensions, readerExtensions, readMarkdown, writeHtml5String,
                    Block(..), HTMLMathMethod(MathJax), defaultMathJaxURL, Inline(..),
                    ObfuscationMethod(NoObfuscation), Pandoc(..), WriterOptions(..), nullMeta) -- unMeta
import Text.Pandoc.Shared (stringify)
import Text.Pandoc.Walk (walk, walkM, query)
import Network.HTTP (urlEncode)
import System.IO.Unsafe (unsafePerformIO)
import System.Directory (doesFileExist, createFileLink, listDirectory, doesDirectoryExist)
import System.FilePath ((</>), takeFileName, dropExtension, takeExtension)

import qualified Data.Text as T (append, filter, isInfixOf, pack, unpack, length, strip)

-- local custom modules:
import Image (imageMagickDimensions, addImgDimensions, imageLinkHeightWidthSet, isImageFilename)
import Inflation (nominalToRealInflationAdjuster)
import Interwiki (convertInterwikiLinks)
import LinkArchive (localizeLink, readArchiveMetadataAndCheck, ArchiveMetadata)
import LinkAuto (linkAuto)
import LinkBacklink (getBackLinkCheck, getLinkBibLinkCheck, getSimilarLinkCheck)
import LinkMetadata (addPageLinkWalk, readLinkMetadataSlow, writeAnnotationFragments, createAnnotations, hasAnnotation, addCanPrefetch, annotationSizeDB, addSizeToLinks)
import LinkMetadataTypes (Metadata, SizeDB)
import Tags (tagsToLinksDiv)
import Typography (linebreakingTransform, typographyTransformTemporary, titlecaseInline, completionProgressHTML, addDropCap)
import Utils (printGreen, replace, deleteMany, replaceChecked, safeHtmlWriterOptions, simplifiedHTMLString, inlinesToText, flattenLinksInInlines, delete, toHTML, getMostRecentlyModifiedDir)
import Test (testAll)
import qualified Config.Misc as C (cd, currentYear, todayDayStringUnsafe, isOlderThan, isNewWithinNDays, pageMetadataFieldsMandatory, pageTitleMaxWords, pageDescriptionMaxLength, pageDescriptionMinLength, yamlValidStatuses, yamlValidConfidences, yamlValidCssExtensions, root)
import Metadata.Date (dateRangeDuration, isDate, isDatePossibleGwernnet)
import LinkID ()
-- import Blog (writeOutBlogEntries)

-- imports just to write 'symlinkFileCompiler':
import Hakyll.Core.Writable (Writable(write))
import Hakyll.Core.Item (Item(Item))
import Hakyll.Core.Compiler (makeItem)
import Data.Binary (Binary (..))
import Data.Typeable (Typeable)
import Hakyll.Core.Compiler.Internal (compilerProvider, compilerAsk)
import Hakyll.Core.Provider (resourceFilePath)

main :: IO ()
main =
 do arg <- System.Environment.lookupEnv "SLOW" -- whether to do the more expensive stuff; Hakyll eats the CLI arguments, so we pass it in as an exported environment variable instead
    let slow = "true" == fromMaybe "" arg
    args <- getArgs
    let args' = filter (\a -> a /= "build" && a /= "rebuild" && a /= "clean" && a /= "watch" && a /= "preview" && a /= "server") args
    let annotationBuildAllForce = filter (=="--annotation-rebuild") args'
    let annotationOneShot       = filter (=="--annotation-missing-one-shot") args'
    annotationsEnabled <- lookupEnv "GWERN_ANNOTATIONS"
    let doAnnotations = fromMaybe "1" annotationsEnabled == "1"

    C.cd

    -- Ensure index.generated.md exists before Hakyll scans the filesystem.
    -- (Creating it inside `preprocess` is too late: the provider snapshot is already built.)
    writeOutHomepageIndexGenerated

    printGreen ("Local archives parsing…" :: String)
    am           <- readArchiveMetadataAndCheck

    printGreen ("Popup annotations parsing…" :: String)
    meta <- readLinkMetadataSlow

    sizes <- annotationSizeDB meta am :: IO SizeDB

    -- printGreen ("Writing blog entries…" :: String)
    -- writeOutBlogEntries meta

    -- NOTE: reset the `getArgs` to pass through just the first argument (ie. "build", converting it back to `hakyll build`), as `hakyll` internally calls `getArgs` and will fatally error out if we don't delete our own arguments:
    withArgs [head args] $ hakyll $ do
       let compileSite = do
             when slow $ preprocess testAll

             -- for '/ref/' cache updating & expiring:
             -- preprocess $ writeOutID2URLdb meta
             timestamp <- preprocess $ getMostRecentlyModifiedDir "metadata/annotation/id/"

             preprocess $ printGreen ("Begin site compilation…" :: String)

             -- Only compile a small, known set of Markdown sources. This repo has many
             -- non-page .md files without required YAML metadata.
             let targetsMd =
                  (fromGlob "*.md" .||. fromGlob "**/*.md")
                  .&&. complement "README.md"
                  .&&. complement "BUILD_INSTRUCTIONS.md"
                  .&&. complement "Evolutionary-License.md"
                  .&&. complement "docs/**" -- docs is mostly handled by explicit nested patterns below
                  .&&. complement "index.md"
                  .&&. complement "index.generated.md"
                  .&&. complement "doc/www/**"
                  .&&. complement "gwern.net/**"
                  .&&. complement "scripts/**"
                  .&&. complement "build/**"
                  .&&. complement "static/**"
                  .&&. complement "metadata/**"
             let targetsPage = (fromGlob "docs/**/*.md" .||. fromGlob "blockchain/**/*.md" .||. fromGlob "newsletter/**/*.md")
                                 .||. targetsMd
                                 .&&. complement "index.generated.md"
             let targetsSingle = fromGlob $ head args'

             unless (null args') $
               preprocess (printGreen "Essay targets specified, so compiling just: " >> print (head args'))
             let readerOptions = defaultHakyllReaderOptions
             let compileMarkdown = do
                            ident <- getUnderlying
                            _hakyllMeta <- getMetadata ident
                            indexpM <- getMetadataField ident "index"
                            let indexp = fromMaybe "" indexpM
                            -- Only the homepage uses a generated source (`index.generated.md`)
                            -- while routing to `/index`; force `$safe-url$` there so page-specific
                            -- CSS/JS conditions behave as if the page were named `index`.
                            -- Other index-like pages (eg. `/blog/index`) should not inherit this.
                            let indexSafeUrlCtx =
                                  if toFilePath ident == "index.generated.md"
                                  then constField "safe-url" "index"
                                  else mempty
                            compileExt <- getMetadataField ident "css-extension"
                            let cssExt = fromMaybe "" compileExt
                            inlinedHead <- unsafeCompiler $ readFile "static/include/inlined-head.html"
                            inlinedAssets <- unsafeCompiler $ readFile "static/include/inlined-asset-links.html"
                            navbarHtml <- unsafeCompiler $ readFile "static/include/navbar.html"
                            footerHtml <- unsafeCompiler $ readFile "static/include/footer.html"
                            -- unsafeCompiler $ validateYAMLMetadata hakyllMeta (toFilePath ident)
                            pandocCompilerWithTransformM readerOptions woptions (\p -> do
                                 p' <- unsafeCompiler $ pandocTransform meta am sizes indexp p
                                 return $ addDropCap cssExt p')
                              >>= loadAndApplyTemplate
                                    "static/template/default.html"
                                    ( constField "inlined-head" inlinedHead <>
                                      constField "inlined-asset-links" inlinedAssets <>
                                      constField "navbar" navbarHtml <>
                                      constField "footer" footerHtml <>
                                      indexSafeUrlCtx <>
                                      postCtx meta timestamp
                                    )
                              >>= imgUrls

             -- Homepage: compile /index and /index.html from the generated source.
             match "index.generated.md" $ do
                 route $ constRoute "index"
                 compile compileMarkdown
             version "html-index" $ match "index.generated.md" $ do
                 route $ constRoute "index.html"
                 compile compileMarkdown

             -- A few repo-local pages are referenced by the navbar/homepage using
             -- canonical, lowercase Gwern-style URLs. Provide those routes here
             -- without forcing a repo-wide URL renaming.
             match "gwern-net-design.md" $ do
                 route $ constRoute "design"
                 compile compileMarkdown
             version "html-design" $ match "gwern-net-design.md" $ do
                 route $ constRoute "design.html"
                 compile compileMarkdown

             version "alias-changelog" $ match "Changelog copy.md" $ do
                 route $ constRoute "changelog"
                 compile compileMarkdown
             version "alias-changelog-html" $ match "Changelog copy.md" $ do
                 route $ constRoute "changelog.html"
                 compile compileMarkdown

             let pageRoute =
                   gsubRoute "_posts/" (const "posts/") `composeRoutes`
                   gsubRoute "," (const "") `composeRoutes`
                   gsubRoute "'" (const "") `composeRoutes`
                   gsubRoute " " (const "-") `composeRoutes`
                   setExtension ""

             if null args'
                 then do
                 match targetsMd $ do
                   route pageRoute
                   compile compileMarkdown
                 match targetsPage $ do
                   route pageRoute
                   compile compileMarkdown
                 else do
                 match targetsSingle $ do
                   route pageRoute
                   compile compileMarkdown

             -- Static assets: always copy from ./static into _site/static so single-page builds
             -- still have CSS/JS. Avoid copying anything from ./gwern.net/**.
             let staticCopy = route idRoute >> compile copyFileCompiler
             version "static" $ match (fromGlob "static/**" .&&. complement "static/build/**") staticCopy
             version "static" $ match "metadata/**" staticCopy
             version "static" $ match "doc/**" staticCopy
             version "static" $ match "images/**" staticCopy
             version "static" $ match "assets/**" staticCopy
             version "static" $ match "atom.xml" staticCopy

       if doAnnotations then
         if not (null annotationBuildAllForce) then
           preprocess $ do printGreen ("Rewriting all annotations…" :: String)
                           writeAnnotationFragments am meta sizes False
         else do
           preprocess $ do printGreen ("Writing missing annotations…" :: String)
                           writeAnnotationFragments am meta sizes True
           if not (null annotationOneShot) then preprocess $ printGreen "Finished writing missing annotations, and one-shot mode specified, so exiting now."
           else compileSite
       else compileSite

       match "static/template/*.html" $ compile templateCompiler

woptions :: Text.Pandoc.WriterOptions
woptions = defaultHakyllWriterOptions{ writerSectionDivs = True,
                                       writerTableOfContents = True,
                                       writerColumns = 130,
                                       writerTemplate = Just tocTemplate,
                                       writerTOCDepth = 4,
                                       -- we use MathJax directly to bypass Texmath; this enables features like colored equations:
                                       -- https://docs.mathjax.org/en/latest/input/tex/extensions/color.html http://mirrors.ctan.org/macros/latex/required/graphics/color.pdf#page=4 eg. "Roses are $\color{red}{\text{beautiful red}}$, violets are $\color{blue}{\text{lovely blue}}$" or "${\color{red} x} + {\color{blue} y}$"
                                       writerHTMLMathMethod = MathJax defaultMathJaxURL,
                                       writerEmailObfuscation = NoObfuscation }
   where
    -- below copied from https://github.com/jaspervdj/hakyll/blob/e8ed369edaae1808dffcc22d1c8fb1df7880e065/web/site.hs#L73 because god knows I don't know what this type bullshit is either:
    -- "When did it get so hard to compile a string to a Pandoc template?"
    tocTemplate =
        either error id $ either (error . show) id $
        runPure $ runWithDefaultPartials $
        compileTemplate "" $ T.pack $ "<div id=\"TOC\" class=\"TOC\">$toc$</div> <div id=\"markdownBody\" class=\"markdownBody\">" ++
                              "$body$" -- we do the main $body$ substitution inside default.html so we can inject stuff inside the #markdownBody wrapper; the div is closed there

imgUrls :: Item String -> Compiler (Item String)
imgUrls item = do
    rte <- getRoute $ itemIdentifier item
    case rte of
        Nothing -> return item
        Just _  -> traverse (unsafeCompiler . addImgDimensions) item

postCtx :: Metadata -> String -> Context String
postCtx md rts =
    fieldsTagPlain md <>
    fieldsTagHTML  md <>
    titlePlainField "title-plain" <>
    descField True "title" "title-escaped" <>
    descField False "title" "title" <>
    fallbackTitleEscapedField <>
    fallbackTitleField <>
    descField True "description" "description-escaped" <>
    descField False "description" "description" <>
    constField "refMapTimestamp" rts <>
    -- NOTE: as a hack to implement conditional loading of JS/metadata in /index, in default.html, we switch on an 'index' variable; this variable *must* be left empty (and not set using `constField "index" ""`)! (It is defined in the YAML front-matter of /index.md as `index: True` to set it to a non-null value.) Likewise, "error404" for generating the 404.html page.
    -- similarly, 'author': default.html has a conditional to set 'Gwern' as the author in the HTML metadata if 'author' is not defined, but if it is, then the HTML metadata switches to the defined author & the non-default author is exposed in the visible page metadata as well for the human readers.
    defaultContext <>
    boolField "backlinks-yes" (check notNewsletterOrIndex getBackLinkCheck)    <>
    boolField "similars-yes"  (check notNewsletterOrIndex getSimilarLinkCheck) <>
    boolField "linkbib-yes"   (check (const True)         getLinkBibLinkCheck) <>
    dateRangeHTMLField "date-range-HTML" <>
    isNewField               <> -- CSS 'body.page-created-recently'
    rawMetadataField "created" <>
    -- constField "created" "N/A"  <> -- NOTE: we make 'created' a mandatory field by not setting a default, so template compilation will crash
    -- if no manually set last-modified time, fall back to checking file modification time:
    rawMetadataField "modified" <>
    modificationTimeField "modified" "%F" <>
    -- metadata:
    progressField "status" "status-plus-progress" <>
    statusPlusProgressField <>
    statusField <>
    progressField "confidence" "confidence-plus-progress" <>
    confidencePlusProgressField <>
    confidenceField <>
    constField "importance" "0" <>
    constField "css-extension" "dropcaps-de-zs" <>
    constField "thumbnail-css" "" <> -- constField "thumbnail-css" "outline-not" <> -- TODO: all uses of `thumbnail-css` should be migrated to GTX
    imageDimensionWidth "thumbnail-height" <>
    imageDimensionWidth "thumbnail-width" <>
    -- for use in templating, `<body class="page-$safe-url$">`, allowing page-specific CSS like `.page-sidenote` or `.page-slowing-moores-law`:
    escapedTitleField "safe-url" <>
    (mapContext (\p -> urlEncode $ concatMap (\t -> if t=='/'||t==':' then urlEncode [t] else [t]) ("/" ++ sourcePathToHtml p)) . pathField) "escaped-url" -- used by backlinks; supports both .md & .page

lookupTags :: Metadata -> Item a -> Compiler (Maybe [String])
lookupTags m item = do
  let path = "/" ++ stripSourceExt (toFilePath $ itemIdentifier item)
  case M.lookup path m of
    Nothing                 -> return Nothing
    Just (_,_,_,_,_,tags,_) -> return $ Just tags

fieldsTagHTML :: Metadata -> Context String
fieldsTagHTML m = field "tagsHTML" $ \item -> do
  maybeTags <- lookupTags m item
  case maybeTags of
    Nothing   -> return "" -- noResult "no tag field"
    Just []   -> return ""
    Just [""] -> return ""
    Just tags -> case runPure $ writeHtml5String safeHtmlWriterOptions (Pandoc nullMeta [tagsToLinksDiv $ map T.pack tags]) of
                   Left e -> error ("Failed to compile tags to HTML fragment: " ++ show item ++ show tags ++ show e)
                   Right html -> return (T.unpack html)

fieldsTagPlain :: Metadata -> Context String
fieldsTagPlain m = field "tags-plain" $ \item -> do
    maybeTags <- lookupTags m item
    case maybeTags of
      Nothing -> return "" -- noResult "no tag field"
      Just tags -> return $ intercalate ", " tags

rawMetadataField :: String -> Context String
rawMetadataField k = field k $ \item -> do
  v <- getMetadataField (itemIdentifier item) k
  case v of
    Nothing -> return ""
    Just s  -> return s

stripSourceExt :: FilePath -> FilePath
stripSourceExt p
  | ".md" `isSuffixOf` p   = delete ".md" p
  | otherwise              = p

sourcePathToHtml :: FilePath -> FilePath
sourcePathToHtml p
  | ".md" `isSuffixOf` p   = replaceChecked ".md" ".html" p
  | otherwise              = p

-- Generate index.generated.md from index.md, appending an index of all *.md files in the
-- repo (excluding build/output directories). This keeps the homepage
-- up to date without hardcoding links.
writeOutHomepageIndexGenerated :: IO ()
writeOutHomepageIndexGenerated = do
  src <- readFile "index.md"
  files <- listFilesRec "."
  let pages = sort $ filter isIndexablePage files
  let rendered = ensureIndexMeta src ++ "\n\n" ++ renderAutoIndex pages ++ "\n"
  writeFile "index.generated.md" rendered
  where
    isIndexablePage :: FilePath -> Bool
    isIndexablePage p =
      takeExtension p == ".md" &&
      p /= "./index.md" &&
      p /= "./index.generated.md" &&
      not ("./doc/www/" `isPrefixOf` p) &&
      takeFileName p /= "index.generated.md"

    skipDirName :: FilePath -> Bool
    skipDirName d = d `elem` ["_site", "_cache", "dist-newstyle", ".git", "build", "static", "metadata", "gwern.net", "scripts"]

    listFilesRec :: FilePath -> IO [FilePath]
    listFilesRec dir = do
      ents <- listDirectory dir
      fmap concat $ forM ents $ \e -> do
        let p = dir </> e
        isDir <- doesDirectoryExist p
        if isDir
          then if skipDirName (takeFileName p) then return [] else listFilesRec p
          else return [p]

    ensureIndexMeta :: String -> String
    ensureIndexMeta s
      | "\nindex:" `isInfixOf` s || "\nindex: " `isInfixOf` s = s
      | otherwise = insertBeforeYamlEnd "index: True" s

    insertBeforeYamlEnd :: String -> String -> String
    insertBeforeYamlEnd line s =
      case break (=="...") (lines s) of
        (pre, _dots:post) -> unlines (pre ++ [line, "..."] ++ post)
        _ -> s ++ "\n" ++ line ++ "\n"

    renderAutoIndex :: [FilePath] -> String
    renderAutoIndex _ = ""  -- Disabled: no longer generating site-wide index

-- should backlinks be in the metadata? We skip backlinks for newsletters & indexes (excluded from the backlink generation process as well) due to lack of any value of looking for backlinks to hose.
-- HACK: uses unsafePerformIO. Not sure how to check up front without IO... Read the backlinks DB and thread it all the way through `postCtx`, and `main`?
check :: (String -> Bool) -> (String -> IO (String, String)) -> Item a -> Bool
check filterfunc checkfunc i = unsafePerformIO $ do let p = pageIdentifierToPath i
                                                    (_,path) <- checkfunc p
                                                    return $ path /= "" && filterfunc p
notNewsletterOrIndex :: String -> Bool
notNewsletterOrIndex p = not ("newsletter/" `isInfixOf` p || "index" `isSuffixOf` p)

pageIdentifierToPath :: Item a -> String
pageIdentifierToPath i = "/" ++ (delete "." (stripSourceExt (toFilePath (itemIdentifier i))))

imageDimensionWidth :: String -> Context String
imageDimensionWidth d = field d $ \item ->
  do
   metadataMaybe <- getMetadataField (itemIdentifier item) "thumbnail"
   let (h,w) = case metadataMaybe of
         Nothing -> ("530","441")
         Just thumbnailPath ->
           -- Many legacy pages have missing/stale thumbnail paths. Don't abort the
           -- whole build; fall back to defaults if the file doesn't exist or
           -- ImageMagick fails.
           if null thumbnailPath || head thumbnailPath /= '/'
             then ("530","441")
             else
               let p = tail thumbnailPath
                   exists = unsafePerformIO $ doesFileExist p
                   x@(result,_) = unsafePerformIO $ imageMagickDimensions p
               in if exists && result /= "" then x else ("530","441")
   if d == "thumbnail-width" then return w else return h

escapedTitleField :: String -> Context String
escapedTitleField = mapContext (map toLower . replace "." "" . replace "/" "-" . stripSourceExt) . pathField

-- for 'title' metadata, they can have formatting like <em></em> italics; this would break when substituted into <title> or <meta> tags.
-- So we render a simplified ASCII version of every 'title' field, '$title-plain$', and use that in default.html when we need a non-display
-- title.
titlePlainField :: String -> Context String
titlePlainField d = field d $ \item -> do
                  metadataMaybe <- getMetadataField (itemIdentifier item) "title"
                  let t = fromMaybe (defaultTitleFromItem item) metadataMaybe
                  return (simplifiedHTMLString t)

-- Many legacy `.page` files are missing a YAML `title:`. Fall back to the filename
-- so templates don't fail to apply.
defaultTitleFromItem :: Item a -> String
defaultTitleFromItem item = dropExtension $ takeFileName $ toFilePath $ itemIdentifier item

fallbackTitleField :: Context String
fallbackTitleField = field "title" $ \item -> do
  metadataMaybe <- getMetadataField (itemIdentifier item) "title"
  return $ fromMaybe (defaultTitleFromItem item) metadataMaybe

fallbackTitleEscapedField :: Context String
fallbackTitleEscapedField = field "title-escaped" $ \item -> do
  metadataMaybe <- getMetadataField (itemIdentifier item) "title"
  return $ escapeHtml $ fromMaybe (defaultTitleFromItem item) metadataMaybe

progressField :: String -> String -> Context String
progressField d d' = field d' $ \item -> do
 metadataMaybe <- getMetadataField (itemIdentifier item) d
 case metadataMaybe of
   Nothing -> noResult ""
   Just progress -> return $ completionProgressHTML progress

-- Legacy `.page` files often use `belief:` instead of `confidence:`.
confidenceField :: Context String
confidenceField = field "confidence" $ \item -> do
  let ident = itemIdentifier item
  mc <- getMetadataField ident "confidence"
  mb <- getMetadataField ident "belief"
  return $ case mc of
    Just c  -> c
    Nothing -> fromMaybe "log" mb

confidencePlusProgressField :: Context String
confidencePlusProgressField = field "confidence-plus-progress" $ \item -> do
  let ident = itemIdentifier item
  mc <- getMetadataField ident "confidence"
  mb <- getMetadataField ident "belief"
  let c = case mc of
        Just x  -> x
        Nothing -> fromMaybe "log" mb
  return $ completionProgressHTML c

statusField :: Context String
statusField = field "status" $ \item -> do
  ms <- getMetadataField (itemIdentifier item) "status"
  return $ fromMaybe "notes" ms

statusPlusProgressField :: Context String
statusPlusProgressField = field "status-plus-progress" $ \item -> do
  ms <- getMetadataField (itemIdentifier item) "status"
  return $ completionProgressHTML $ fromMaybe "notes" ms

-- for 'page-created-recently' CSS body switch (eg. disable the recently-modified black-star link highlighting, which is a bad idea if many links on a page are 'new')
-- $page-created-recently$ → " page-created recently" when the page is ≤ 90 d old, else ""; we always insert this into `default.html`, we just return either a space-prefixed string (so it can be concatenated) or an empty string, and we skip trying to do a conditional at all.
isNewField :: Context String
isNewField = field "page-created-recently" $ \item -> do
    mCreated <- getMetadataField (itemIdentifier item) "created"
    case mCreated of
      Nothing -> pure ""
      Just created ->  let today   = C.todayDayStringUnsafe
                           recent  = if created == "N/A" || created == "\"N/A\"" || created == "'N/A'" then False else
                             maybe False (\c -> not (C.isOlderThan C.isNewWithinNDays c today)) mCreated
                       in pure $ if recent then " page-created-recently" else ""

dateRangeHTMLField :: String -> Context String
dateRangeHTMLField d = field d $ \item -> do
 metadataMaybe1 <- getMetadataField (itemIdentifier item) "created"
 metadataMaybe2 <- getMetadataField (itemIdentifier item) "modified"
 case (metadataMaybe1, metadataMaybe2) of
   (Just created, Just modified) -> let dateString = Str $ T.pack $ if created == modified then created else created ++ "–" ++ modified
                                        range = dateRangeDuration C.currentYear dateString
                                    in return (toHTML range)
   (_,_) -> noResult "missing created and/or modified field, so could not adjust the date range subscript."

descField :: Bool -> String -> String -> Context String
descField escape d d' = field d' $ \item -> do
                  metadata <- getMetadata (itemIdentifier item)
                  let descMaybe = lookupString d metadata
                  case descMaybe of
                    Nothing -> noResult "no description field"
                    Just desc ->
                     let cleanedDesc = runPure $ do
                              pandocDesc <- readMarkdown def{readerExtensions=pandocExtensions} (T.pack desc)
                              let pandocDesc' = convertInterwikiLinks $ linebreakingTransform pandocDesc
                              htmlDesc <- writeHtml5String safeHtmlWriterOptions pandocDesc' -- NOTE: we need 'safeHtmlWriterOptions' here because while descriptions are always very simple & will never have anything complex like tables, they *usually* are long enough to trigger line-wrapping, which causes problems for anyone parsing <meta> tags
                              return $ (\t -> if escape then escapeHtml t else t) $ T.unpack htmlDesc
                      in case cleanedDesc of
                         Left _          -> noResult "no description field"
                         Right finalDesc -> return $ deleteMany ["<p>", "</p>", "&lt;p&gt;", "&lt;/p&gt;"] finalDesc -- strip <p></p> wrappers (both forms)

pandocTransform :: Metadata -> ArchiveMetadata -> SizeDB -> String -> Pandoc -> IO Pandoc
pandocTransform md adb sizes indexp' p = -- linkAuto needs to run before `convertInterwikiLinks` so it can add in all of the WP links and then convertInterwikiLinks will add link-annotated as necessary; it also must run before `typographyTransformTemporary`, because that will decorate all the 'et al's into <span>s for styling, breaking the LinkAuto regexp matches for paper citations like 'Brock et al 2018'
                           -- tag-directories/link-bibliographies special-case: we don't need to run all the heavyweight passes, and LinkAuto has a regrettable tendency to screw up section headers, so we check to see if we are processing a document with 'index: True' set in the YAML metadata, and if we are, we slip several of the rewrite transformations:
  do
     linkAnnotationsEnabled <- lookupEnv "GWERN_LINK_ANNOTATIONS"
     linkSizesEnabled <- lookupEnv "GWERN_LINK_SIZES"
     let doLinkAnnotations = fromMaybe "1" linkAnnotationsEnabled == "1"
     let doLinkSizes = fromMaybe "0" linkSizesEnabled == "1"
     let duplicateHeaders = duplicateTopHeaders p in
       unless (null duplicateHeaders) $
       error "Warning: Duplicate top-level headers found: " >> print duplicateHeaders
     let indexp = indexp' == "True"
     let pw
           = if indexp then convertInterwikiLinks p else
               walk footnoteAnchorChecker $ convertInterwikiLinks $
                 walk linkAuto p
     unless indexp $ when doLinkAnnotations $ createAnnotations md pw
     let pb = addPageLinkWalk pw  -- we walk local link twice: we need to run it before 'hasAnnotation' so essays don't get overridden, and then we need to add it later after all of the archives have been rewritten, as they will then be local links
     let withSizes = if doLinkSizes then walk (addSizeToLinks sizes) else id
     pbt <- fmap typographyTransformTemporary . walkM (localizeLink adb) $ walk (hasAnnotation md)
              $ withSizes
              $ if indexp then pb else
                walk (map nominalToRealInflationAdjuster) pb
     let pbth = wrapInParagraphs $ addPageLinkWalk $ walk headerSelflinkAndSanitize pbt
     walkM (addCanPrefetch <=< imageLinkHeightWidthSet) pbth

-- | Validate YAML metadata for Gwern.net essays.
-- Checks: mandatory fields present, field value constraints, no unknown fields.
-- See <https://gwern.net/style-guide#page-metadata>
--
-- NOTE: We use Hakyll's Metadata (not Pandoc's Meta) because Hakyll strips YAML
-- before passing documents to Pandoc.
_validateYAMLMetadata :: Hakyll.Metadata -> FilePath -> IO ()
_validateYAMLMetadata hakyllMeta filepath = do
  let getString :: String -> Maybe String
      getString = flip lookupString hakyllMeta

      -- NOTE: unknown field checking not implemented; would require extracting keys from Hakyll.Metadata

      missingMandatory = filter (isNothing . getString) C.pageMetadataFieldsMandatory

  unless (null missingMandatory || "/index.md" `isSuffixOf` filepath || "/abstract.md" `isSuffixOf` filepath || "newsletter/20"`isPrefixOf`filepath) $
    error $ "hakyll.validateYAMLMetadata (" ++ filepath ++ "): missing mandatory fields: " ++ show missingMandatory ++ "; metadata was: " ++ show hakyllMeta

  case getString "title" of
    Nothing -> return ()
    Just title -> do
      let wordCount = length $ words $ simplifiedHTMLString title
      when (wordCount >= C.pageTitleMaxWords) $
        error $ "hakyll.validateYAMLMetadata (" ++ filepath ++ "): 'title' must be <"++ show C.pageTitleMaxWords++" words, got " ++ show wordCount ++ ": " ++ title

  -- description: length range limits
  case getString "description" of
    Nothing -> return ()
    -- /blog/ posts are deliberate exceptions to the description rule, because they exist to be 'lightweight' pages which skip polish like descriptions. It would be nice if all blog posts had descriptions, and maybe at some point I'll make a LLM pass for that, but they don't.
    Just desc -> unless ("blog/" `isPrefixOf` filepath || "newsletter/20"`isPrefixOf`filepath || "/index.md" `isSuffixOf` filepath || "/abstract.md" `isSuffixOf` filepath) $ do
      when (length desc > C.pageDescriptionMaxLength) $
        error $ "hakyll.validateYAMLMetadata (" ++ filepath ++ "): 'description' should be <"++show C.pageDescriptionMaxLength++" characters, was " ++ show (length desc) ++ " characters; string: " ++ show desc
      when (length desc < C.pageDescriptionMinLength) $
        error $ "hakyll.validateYAMLMetadata (" ++ filepath ++ "): 'description' should be >"++show C.pageDescriptionMinLength++" characters: " ++ show desc

  -- created: YYYY-MM-DD or N/A
  case getString "created" of
    Nothing -> return ()
    Just created -> unless ((isDate created && isDatePossibleGwernnet created) || created == "N/A") $
      error $ "hakyll.validateYAMLMetadata (" ++ filepath ++ "): 'created' must be a plausible YYYY-MM-DD, got: " ++ created

  -- modified: YYYY-MM-DD (optional field)
  case getString "modified" of
    Nothing -> return ()
    Just modified -> unless ((isDate modified && isDatePossibleGwernnet modified) || modified == "N/A") $
      error $ "hakyll.validateYAMLMetadata (" ++ filepath ++ "): 'modified' must be a plausible YYYY-MM-DD, got: " ++ modified

  -- status: enumerated
  case getString "status" of
    Nothing -> return ()
    Just status -> unless (status `elem` C.yamlValidStatuses) $
      error $ "hakyll.validateYAMLMetadata C.yamlValidStatuses (" ++ filepath ++ "): 'status' must be one of " ++ show C.yamlValidStatuses ++ ", got: " ++ status

  -- confidence: Kesselman estimative word
  case getString "confidence" of
    Nothing -> return ()
    Just conf -> unless (conf `elem` C.yamlValidConfidences) $
      error $ "hakyll.validateYAMLMetadata C.yamlValidConfidences (" ++ filepath ++ "): 'confidence' must be a Kesselman word from " ++ show C.yamlValidConfidences ++ ", got: " ++ conf

  -- importance: 0-10
  case getString "importance" of
    Nothing -> return ()
    Just imp -> case reads imp of
      [(n, "")] | n >= (0 :: Int) && n <= 10 -> return ()
      _ -> error $ "hakyll.validateYAMLMetadata (" ++ filepath ++ "): 'importance' must be 0-10, got: " ++ imp

  -- css-extension: known classes only
  case getString "css-extension" of
    Nothing -> return ()
    Just cssExt -> do
      let classes = words cssExt
          unknown = filter (`notElem` C.yamlValidCssExtensions) classes
      unless (null unknown) $
        error $ "hakyll.validateYAMLMetadata C.yamlValidCssExtensions (" ++ filepath ++ "): 'css-extension' has unknown classes: " ++ show unknown

  -- thumbnail: absolute path
  case getString "thumbnail" of
    Nothing -> return ()
    Just thumb -> do
      unless (not (null thumb) && head thumb == '/') $
        error $ "hakyll.validateYAMLMetadata (" ++ filepath ++ "): 'thumbnail' must start with /, got: " ++ thumb
      existsp <- System.Directory.doesFileExist (tail thumb)
      unless (existsp && Image.isImageFilename thumb) $
        error $ "hakyll.validateYAMLMetadata (" ++ filepath ++ "): 'thumbnail' filename either not an image filename or doesn't exist, got: " ++ thumb

-- | Make headers into links to themselves, so they can be clicked on or copy-pasted easily. Put the displayed text into title-case if not already.
--
-- While processing Headers, ensure that they have valid CSS IDs. (Pandoc will happily generate invalid HTML IDs, which contain CSS-forbidden characters like periods; this can cause fatal errors in JS/CSS without dangerous workarounds. So the author needs to manually add a period-less ID. This is an outstanding issue: <https://github.com/jgm/pandoc/issues/6553>.)
-- NOTE: We could instead require the author to manually assign an ID like `# Foo.bar {#foobar}`, which would be reliable & compatible with other Markdown systems, but this would not solve the problem on *generated* pages, like the tag-directories which put paper titles in headers & will routinely incur this problem. So we have to automate it as a Pandoc rewrite.
headerSelflinkAndSanitize :: Block -> Block
headerSelflinkAndSanitize x@(Header _ _ [Link{}]) = x
headerSelflinkAndSanitize x@(Header _ _ []) = error $ "hakyll.hs: headerSelflinkAndSanitize: Invalid header with no visible text‽ This should be impossible: " ++ show x
headerSelflinkAndSanitize x@(Header _ ("",_,_) _) = error $ "hakyll.hs: headerSelflinkAndSanitize: Invalid header with no specified ID‽ This should be impossible: " ++ show x
headerSelflinkAndSanitize x@(Header a (href,b,c) d) =
  let href' = T.filter (`notElem` ['.', '#', ':']) href in
    unsafePerformIO $ do
      if href' == "" then error $ "hakyll.hs: headerSelflinkAndSanitize: Invalid ID for header after filtering! The header text must be changed or a valid ID manually set: " ++ show x else
        return $ Header a (href',b,c) [Link nullAttr (walk titlecaseInline $ flattenLinksInInlines d)
                                       ("#"`T.append`href', "Link to section: § '" `T.append` inlinesToText d `T.append` "'")]
headerSelflinkAndSanitize x = x

-- Check for footnotes which may be broken and rendering wrong, with the content inside the body rather than as a footnote. (An example was present for an embarrassingly long time in /gpt-3…)
footnoteAnchorChecker :: Inline -> Inline
footnoteAnchorChecker n@(Note [Para [Str s]]) = if " " `T.isInfixOf` s || T.length s > 10 then n else n -- tolerate legacy content
footnoteAnchorChecker n = n

-- HACK: especially in list items, we wind up with odd situations like '<li>text</li>' instead of '<li><p>text</p></li>'. This *seems* to be due to the HTML/Markdown AST roundtripping resulting in 'loose' elements which Pandoc defaults to 'Plain'. I do not use 'Plain' anywhere wittingly, so it should be safe to blindly rewrite all instances of Plain to Para?
wrapInParagraphs :: Pandoc -> Pandoc
wrapInParagraphs = walk go
  where
    go :: Block -> Block
    go (Plain strs) = Para strs
    go x = x

-- Look for duplicated top-level headers, which are almost always an error.
--
-- Example:
-- > runIOorExplode (readMarkdown def ("# test\n\n# test\n\n# unique" :: T.Text)) >>= print . duplicateTopHeaders
-- ["test"]
duplicateTopHeaders :: Pandoc -> [String]
duplicateTopHeaders = duplicates . query topHeaderTexts
  where
    topHeaderTexts :: Block -> [String]
    topHeaderTexts (Header 1 _ inls) = [normalize inls]
    topHeaderTexts _                 = []

    normalize = T.unpack . T.strip . stringify

    duplicates :: Ord a => [a] -> [a]
    duplicates = map head . filter ((>1) . length) . group . sort

--------------------------------------------------------------------------------
-- Efficient symlink static file compilation
-- | This will not copy a file but create a symlink, which can save space & time for static sites with many large static files which would normally be handled by `copyFileCompiler`. (Note: the user will need to make sure their sync method handles symbolic links correctly!) <https://github.com/jaspervdj/hakyll/issues/786>
newtype SymlinkFile = SymlinkFile FilePath
    deriving (Binary, Eq, Ord, Show, Typeable)
instance Writable SymlinkFile where
    write dst (Item _ (SymlinkFile src)) = createFileLink (C.root ++ src) dst
_symlinkFileCompiler :: Compiler (Item SymlinkFile)
_symlinkFileCompiler = do
    identifier <- getUnderlying
    provider   <- compilerProvider <$> compilerAsk
    makeItem $ SymlinkFile $ resourceFilePath provider identifier
