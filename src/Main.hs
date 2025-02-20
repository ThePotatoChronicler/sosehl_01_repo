module Main (main) where
import Network.HTTP.Types
import Network.Wai
import Network.Wai.Handler.Warp
import Network.Wai.Middleware.Static

main :: IO ()
main = do
  let port = 8080
  putStrLn $ "Serving on port " ++ show port
  run port app

app :: Application
app = staticPolicy appStaticPolicy rawApp

appStaticPolicy :: Policy
appStaticPolicy = policy mapRootToIndex

mapRootToIndex :: String -> Maybe String
mapRootToIndex x
  | x == "" = Just "index.html"
  | otherwise = Just x

rawApp :: Application
rawApp _ response = do
  response $ responseLBS notFound404 [("Content-Type", "text/plain")] "Not found"

