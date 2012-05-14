module Main where
import XKCD
import IO
import System.Environment (getArgs)
import Directory (getCurrentDirectory)
import System.Exit (exitSuccess)

main :: IO ()
main = getPath >>= downloadXKCD

-- |Gets the into which it should download the comic
getPath :: IO FilePath
getPath = do
  path <- processArgs
  case path of 
    Just path -> return path 
    Nothing -> fmap (++ "/strip.jpg") $ getCurrentDirectory

-- |Checks if the arguments contain a path, or help flag. If they do, prints the USAGE message
processArgs :: IO (Maybe FilePath)
processArgs = do
  args <- getArgs
  case args of
    [] -> return Nothing
    ("-h":_) -> printHelp
    ("--help":_) -> printHelp
    path -> return $ Just . head $ path
  where printHelp = do
    putStrLn help
    exitSuccess

-- |USAGE string
help :: String
help = "USAGE: xkcd [path|-h|-help]\nDownloads current xkcd strip to path or to current directory (with name xkcd.jpg)"