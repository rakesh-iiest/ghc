module Settings.Builders.Make (makeBuilderArgs) where

import Base
import Predicate
import Settings.Paths

makeBuilderArgs :: Args
makeBuilderArgs = do
    threads <- shakeThreads <$> lift getShakeOptions
    let t = show $ max 4 (threads - 2) -- Don't use all Shake's threads
    mconcat
        [ builder (Make gmpBuildPath     ) ? append ["MAKEFLAGS=-j" ++ t]
        , builder (Make libffiBuildPath  ) ? append ["MAKEFLAGS=-j" ++ t, "install"]
        , builder (Make "testsuite/tests") ? append ["THREADS=" ++ t, "fast"] ]
