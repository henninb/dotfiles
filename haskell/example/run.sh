#!/usr/bin/env stack
-- stack --resolver lts-14.16 runghc --package xmonad --package directory --package process

import           System.Directory (copyFile, setCurrentDirectory)
import           System.Info      (arch, os)
import           System.Process   (callProcess)
import           XMonad           (getXMonadDir)


main :: IO ()
main = do
    print "hello world"

