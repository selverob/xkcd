module XKCD(downloadXKCD) where
import Network.HTTP
import Text.HTML.TagSoup
import Data.Maybe (fromJust)
import Network.URI (parseURI)
import qualified Data.ByteString as B

-- |Downloads the most recent strip into specified path
downloadXKCD :: FilePath -> IO ()
downloadXKCD path = getImageURL >>= downloadFile >>= B.writeFile path

-- |Gets the URL of the most recent xkcd comic strip
getImageURL :: IO String
getImageURL = do
	tags <- fmap parseTags $ openURL "http://xkcd.com"
	return $ fromJust (getImageString $ getImageTag tags)
	where
		getImageTag :: [Tag String] -> Tag String
		getImageTag tags = (dropWhile (/= TagOpen "div" [("id", "comic")]) tags) !! 2

-- |Searches for the first @img@ tag in a list and returns its @src@ attribute
getImageString :: Tag String -> Maybe String
getImageString (TagOpen "img" attrs) = foldl getAttr Nothing attrs
	where	
		getAttr Nothing ("src", src) = Just src
		getAttr (Just x) (_, _) = Just x
		getAttr Nothing (_, _) = Nothing
getImageString _ = Nothing

-- |Opens URL and gets the body of response
openURL :: String -> IO String
openURL x = getResponseBody =<< simpleHTTP (getRequest x)

-- |Downloads file from URL and returns its contents as a 'B.ByteString'
downloadFile :: String -> IO B.ByteString
downloadFile url = response >>= getResponseBody
	where 
		response = simpleHTTP ((mkRequest GET $ fromJust $ parseURI url) :: Request B.ByteString)

