{-# LANGUAGE OverloadedStrings #-}

import qualified Data.Aeson as Aeson
import Data.Aeson ((.=))
import Web.Scotty

main :: IO ()
main = scotty 3000 $ do
  get "/hello/:word" $ do
    word <- param "word"
    json $ Aeson.object ["hello" .= (word :: String)]
