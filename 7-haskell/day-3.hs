module Main where

    import Data.Maybe

-- Hashes and Monads

    data Hash a b = Data [(a, b)] deriving (Show)

    hashLookup x (Data []) = Nothing
    hashLookup x (Data ((a, b):tail))
        | x == a    = Just b
        | otherwise = hashLookup x (Data tail)

    -- *Main> hashLookup 5 (Data [(1, 2), (3, 4), (5, 6)])
    -- Just 6

    myhash = (Data [(1, Data [(9, Just 2)]),
                    (3, Data [(5, Just 6)])])

    -- val = do myhash
    --          val1 <- (hashLookup 1)
    --          val2 <- (hashLookup 9)
    --          return val2
