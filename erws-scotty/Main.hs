{-# LANGUAGE OverloadedStrings #-}

import qualified Data.Aeson as Aeson
import Data.Aeson ((.=))
import Network.Wai
import Network.Wai.Cli
import Web.Scotty


app :: IO Application
app = scottyApp $ do
    get "/hello/:word" $ do
        word <- param "word"
        json $ Aeson.object ["hello" .= (word :: String)]
    notFound $ do
        path <- rawPathInfo <$> request
        json $ Aeson.object ["error" .= ("The path does not exist: " ++ show path)]


main :: IO ()
main = app >>= defWaiMain
