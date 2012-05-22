module Main where
import XKCD
import System.Environment (getArgs)
import System.Directory (getCurrentDirectory)
import System.Exit (exitSuccess)
import System.FilePath (pathSeparator)

main :: IO ()
main = getPath >>= downloadXKCD

-- |Gets the into which it should download the comic
getPath :: IO FilePath
getPath = do
  path <- processArgs
  case path of 
    Just path' -> return path' 
    Nothing -> fmap (++ fileName) getCurrentDirectory
    where fileName = pathSeparator:"strip.jpg"

-- |Checks whether the arguments contain a path, or help flag. If they do, prints the USAGE message
processArgs :: IO (Maybe FilePath)
processArgs = do
  args <- getArgs
  case args of
    [] -> return Nothing
    ("-h":_) -> printHelp
    ("--help":_) -> printHelp
    path -> return $ Just . head $ path
  where printHelp = putStrLn help >> exitSuccess

-- |USAGE string
help :: String
help = "USAGE: xkcd [path|-h|-help]\nDownloads current xkcd strip to path or to current directory (with name xkcd.jpg)"