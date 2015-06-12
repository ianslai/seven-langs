module Main where

-- How many different ways can you find to write allEven?

    allEvenRef :: [Integer] -> [Integer]
    allEvenRef [] = []
    allEvenRef (h:t) = if even h then h:allEvenRef t else allEvenRef t

    allEven1 :: [Integer] -> [Integer]
    allEven1 list = [x | x <- list, even x]

    allEven2 :: [Integer] -> [Integer]
    allEven2 list = filter even list

-- Write a function that takes a list and returns the same list in reverse

    myReverseHelper :: [a] -> [a] -> [a]
    myReverseHelper a [] = a
    myReverseHelper a (h:t) = myReverseHelper (h:a) t

    myReverse :: [a] -> [a]
    myReverse a = myReverseHelper [] a

-- Write a function that builds two-tuples with all possible combos of
-- black, white, blue, yellow, and red.

    colorCombos :: [([Char], [Char])]
    colorCombos = [(x, y) | x <- colors, y <- colors, x < y]
        where colors = ["black", "white", "blue", "yellow", "red"]

-- Write a list comprehension to build a childhood multiplication table.

    multTable :: [(Integer, Integer, Integer)]
    multTable = [(x, y, x * y) | x <- ints, y <- ints]
        where ints = [1..12]

-- Solve the map-coloring problem using Haskell.

    type Color = [Char]
    type Location = [Char]

    diff :: Eq t => [t] -> [t] -> [t]
    diff a b = [x | x <- a, notElem x b]

    findNeighbors :: Location -> [(Location, Location)] -> [Location]
    findNeighbors loc constraints = [y | (x, y) <- constraints, x == loc]

    findUsableColors :: [Color] -> [(Location, Color)] -> [Color]
    findUsableColors colors usedMappings = diff colors usedColors
        where usedColors = [y | (x, y) <- usedMappings]

    coloringHelper :: [Location] -> [(Location, Color)] -> [Color] -> [(Location, Location)] -> [[(Location, Color)]]
    coloringHelper [] result colors constraints = [result]
    coloringHelper (h:remainder) used colors constraints = process (map recurse usableColors)
        where neighbors = findNeighbors h constraints
              usedNeighbors = [(n, c) | (n, c) <- used, elem n neighbors]
              usableColors = findUsableColors colors usedNeighbors
              recurse = (\c -> coloringHelper remainder ((h, c):used) colors constraints)
              process = (\results -> [x | [x] <- results, x /= []])

    coloring = coloringHelper states [] colors constraints
        where states = ["AL", "GA", "FL", "MS", "TN"]
              colors = ["red", "green", "blue"]
              pureConstraints = [("AL", "TN"), ("AL", "GA"), ("AL", "FL"), ("AL", "MS"),
                ("MS", "TN"), ("GA", "FL"), ("GA", "TN")]
              constraints = pureConstraints ++ [(x, y) | (y, x) <- pureConstraints]
