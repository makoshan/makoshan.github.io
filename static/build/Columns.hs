#!/usr/bin/env runhaskell
{-# LANGUAGE OverloadedStrings #-}
-- dependencies: libghc-pandoc-dev

-- usage: 'lost-columns.hs [file]'; reads a Pandoc Markdown (or Pandoc-generated-HTML) file and looks for 'skinny tall' lists which are better rendered
-- as multiple columns (supported on gwern.net by special CSS triggered by '<div class="columns"></div>' wrappers).
--
-- A skinny tall list is defined as a list which is at least 8 items long (so you get at least 2×4 columns—a 2×2 square or 2×3 rectangle looks dumb),
-- and where the individual lines are all <75 characters wide (>half the width of a gwern.net line at the utmost).
--
-- If a file already has the string '<div class="columns"' in it, it will be presumed to have been manually checked & all skinny lists correctly annotated, and skipped to avoid unnecessary reporting of false-positives.

module Columns (listsTooLong, main) where

import Text.Pandoc (def, queryWith, readerExtensions, readHtml, readMarkdown, runPure,
                    pandocExtensions, Block(BulletList, OrderedList), Pandoc(Pandoc))
import Data.List (isSuffixOf)
import qualified Data.Text as T (isInfixOf, length, unlines, Text)
import qualified Data.Text.IO as TIO (readFile, putStrLn)
import System.Environment (getArgs)
import Control.Monad (when, unless)

import Utils (simplified)

-- | Map over the filenames
main :: IO ()
main = do
  fs <- getArgs
  let printfilenamep = head fs == "--print-filenames"
  let fs' = if printfilenamep then Prelude.drop 1 fs else fs
  mapM_ (printLists printfilenamep) fs'

printLists :: Bool -> FilePath -> IO ()
printLists printfilenamep file = do
  input <- TIO.readFile file
  let preexisting = T.isInfixOf "<div class=\"columns" input
  unless preexisting $
    do let long = getLongLists (".html"`isSuffixOf`file) input
       unless (null long) $ do
         when printfilenamep $ putStrLn $ file ++ ":"
         TIO.putStrLn $ T.unlines $ map simplified long

listLengthMax, sublistsLengthMin :: Int
listLengthMax = 75
sublistsLengthMin = 8

getLongLists :: Bool -> T.Text -> [Block]
getLongLists htmlp txt = let parsedEither = if htmlp then runPure $ readHtml def{readerExtensions = pandocExtensions } txt else runPure $ readMarkdown def{readerExtensions = pandocExtensions } txt
                        -- if we don't explicitly enable footnotes, Pandoc interprets the footnotes as broken links, which throws many spurious warnings to stdout
                   in case parsedEither of
                              Left _ -> []
                              Right (Pandoc _ pnd) -> listsTooLong pnd

listsTooLong :: [Block] -> [Block]
listsTooLong ls = let lists = extractLists ls in
                                             filter (\x -> listLength x < listLengthMax) lists

extractLists :: [Block] -> [Block]
extractLists = queryWith extractList
 where
   extractList :: Block -> [Block]
   extractList l@(OrderedList _ _) = [l]
   extractList l@(BulletList _) = [l]
   extractList _ = []

-- > listLength $ BulletList [[Para [Str "test"]],[Para [Str "test2"],Para [Str "Continuation"]],[Para [Link ("",[],[]) [Str "WP"] ("https://en.wikipedia.org/wiki/Foo","")]],[Para [Str "Final",Space,Str "line"]]]
-- → 7
listLength :: Block -> Int
listLength (OrderedList _ list) = listLengthAvg list
listLength (BulletList    list) = listLengthAvg list
listLength _                    = maxBound
listLengthAvg :: [[Block]] -> Int
listLengthAvg list = if length list < sublistsLengthMin then maxBound else
                       let lengths = map listItemLength list in maximum lengths

-- > listItemLength $ [Para [Str "Foo", Link nullAttr [Str "bar"] ("https://en.wikipedia.org/wiki/Bar", "Wikipedia link")], Para [Str "Continued Line"]]
-- → 15
-- > listItemLength $ [Para [Str "Foo", Link nullAttr [Str "bar"] ("https://en.wikipedia.org/wiki/Bar", "Wikipedia link")]]
-- → 7
-- > listItemLength $ [Para [Str "Continued Line"]]
-- → 15
listItemLength :: [Block] -> Int
listItemLength is = let lengths = map listSubItemLength is in maximum lengths

-- > listSubItemLength $ Para [Str "Foo"]
-- → 4
-- > listSubItemLength $ Para [Str "Foo", Link nullAttr [Str "bar"] ("https://en.wikipedia.org/wiki/Bar", "Wikipedia link")]
-- → 7
listSubItemLength :: Block -> Int
listSubItemLength i = T.length $ simplified i
