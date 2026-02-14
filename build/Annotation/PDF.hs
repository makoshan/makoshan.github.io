{-# LANGUAGE DeriveGeneric, OverloadedStrings #-}
module Annotation.PDF where

import Control.Monad (unless)
import Data.Aeson (eitherDecode, FromJSON)
import Data.Maybe (fromMaybe)
import qualified Data.ByteString.Lazy as BL (concat, length)
import qualified Data.ByteString.Lazy.UTF8 as U (toString)
import Data.FileStore.Utils (runShellCommand)
import GHC.Generics (Generic)
import System.Directory (doesFileExist, findExecutable)

import LinkAuto (linkAutoHtml5String)
import LinkMetadataTypes (Failure (Permanent), Metadata, MetadataItem, Path)
import Metadata.Author (cleanAuthors)
import Metadata.Format (cleanAbstractsHTML, filterMeta, pageNumberParse, processDOI, trimTitle)
import Paragraph (processParagraphizer)
import Utils (printGreen, printRed, replace, trim)
import qualified Config.Misc as C (cd)

pdf :: Metadata -> Path -> IO (Either Failure (Path, MetadataItem))
pdf _ "" = error "Fatal error: `Annotation.PDF.pdf` called on empty string argument; this should never happen."
pdf md p = do
  C.cd

  -- Optional dependency: don't crash builds if exiftool isn't installed.
  mexif <- findExecutable "exiftool"
  case mexif of
    Nothing -> do
      printRed ("PDF annotation skipped: missing exiftool on PATH (needed to read PDF metadata): " ++ p)
      return (Left Permanent)
    Just _ -> do
      let p' = takeWhile (/= '#') $ if head p == '/' then tail p else p
      existsp <- doesFileExist p'
      unless existsp $ error $ "PDF file doesn't exist? Tried to query " ++ p

      let pageNumber = pageNumberParse p
      let pageNumber' = if pageNumber == p then "" else pageNumber

      (_, _, mbTitle) <- runShellCommand "./" Nothing "exiftool" ["-printFormat", "$Title", "-Title", p']
      (_, _, mbAuthor) <- runShellCommand "./" Nothing "exiftool" ["-printFormat", "$Author", "-Author", p']
      (_, _, mbCreator) <- runShellCommand "./" Nothing "exiftool" ["-printFormat", "$Creator", "-Creator", p']
      (_, _, mbDate) <- runShellCommand "./" Nothing "exiftool" ["-printFormat", "$Date", "-dateFormat", "%F", "-Date", p']
      (_, _, mbDoi) <- runShellCommand "./" Nothing "exiftool" ["-printFormat", "$DOI", "-DOI", p']

      if BL.length (BL.concat [mbTitle, mbAuthor, mbDate, mbDoi]) > 0
        then do
          printGreen (show [mbTitle, mbCreator, mbAuthor, mbDate, mbDoi])
          let titleBase = filterMeta (trimTitle $ cleanAbstractsHTML $ U.toString mbTitle)
          let title = titleBase ++ (if null pageNumber' || null titleBase then "" else " § pg" ++ pageNumber')

          let edoi = trim $ U.toString mbDoi
          let edoi' = if null edoi then "" else processDOI edoi
          let edoi'' = if null edoi' then [] else [("doi", edoi')]

          -- PDFs have both a 'Creator' and 'Author' metadata field sometimes.
          -- Heuristic: pick the longer of Author/Creator if one looks like the paper author list.
          let ecreator = filterMeta $ U.toString mbCreator
          let eauthor' = filterMeta $ U.toString mbAuthor
          let author = linkAutoHtml5String $ cleanAbstractsHTML $ cleanAuthors $ trim $ if length eauthor' > length ecreator then eauthor' else ecreator

          let ts = [] -- TODO: infer tags
          printGreen $ "PDF: " ++ p ++ " DOI: " ++ edoi'

          at <- fmap (fromMaybe "") $ doi2Abstract md edoi'

          if not (null (title ++ author ++ U.toString mbDate ++ edoi'))
            then return $ Right (p, (title, author, trim $ replace ":" "-" (U.toString mbDate), "", edoi'', ts, at))
            else return (Left Permanent)
        else do
          printRed "PDF annotation failed, insufficient data or unreadable file; exiftool returned: "
          putStrLn ("title/author/date: " ++ show mbTitle ++ " ; DOI: " ++ show mbDoi)
          return (Left Permanent)

-- nested JSON object: eg. 'jq .message.abstract'
newtype Crossref = Crossref { message :: Message } deriving (Show, Generic)
instance FromJSON Crossref

newtype Message = Message { abstract :: Maybe String } deriving (Show, Generic)
instance FromJSON Message

doi2Abstract :: Metadata -> String -> IO (Maybe String)
doi2Abstract md doi =
  if length doi < 7
    then return Nothing
    else do
      (_, _, bs) <- runShellCommand "./" Nothing "curl"
        [ "--location"
        , "--silent"
        , "https://api.crossref.org/works/" ++ doi
        , "--user-agent"
        , "gwern+crossrefscraping@gwern.net"
        ]
      if bs == "Resource not found."
        then return Nothing
        else case eitherDecode bs :: Either String Crossref of
          Left e -> printRed ("Error: Crossref request failed: " ++ doi ++ " " ++ e) >> return Nothing
          Right j -> case abstract (message j) of
            Nothing -> return Nothing
            Just a -> do
              trimmedAbstract <- fmap cleanAbstractsHTML $ processParagraphizer md doi $ linkAutoHtml5String $ cleanAbstractsHTML a
              return $ Just trimmedAbstract
