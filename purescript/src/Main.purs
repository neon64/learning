module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log, logShow)

foo :: Int -> Int
foo a = a*a

greet :: String -> String
greet name = "Hello " <> name <> ", world!"

main :: Effect Unit
main = do
  log $ greet "Fabian"
  logShow (foo 4)

