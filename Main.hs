{-# LANGUAGE OverloadedStrings #-}
module Main where

import Network.Wai
import Network.HTTP.Types                 (status200)
import Network.Wai.Servlet
import Network.Wai.Servlet.Handler.Jetty
import Blaze.ByteString.Builder           (fromByteString)
import Blaze.ByteString.Builder.Char.Utf8 (fromShow,fromString)
import Data.Monoid                        ((<>))

appShowReq :: Application
appShowReq req respond = do
  body <- requestBody req
  resp <- respond $ responseBuilder status200
                    [("Content-Type", "text/plain")] $
                    fromShow req <> fromString "\n" <>
                    fromByteString body
  return resp

main :: IO ()
main = run 3000 appShowReq
