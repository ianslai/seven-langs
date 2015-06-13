module Main where

-- Write a sort

    partition :: Ord a => a -> [a] -> [a] -> [a] -> ([a], [a])
    partition _ [] before after = (before, after)
    partition pivot (head:tail) before after
        | head < pivot = partition pivot tail (head:before) after
        | otherwise    = partition pivot tail before (head:after)

    mysort :: Ord a => [a] -> [a]
    mysort [] = []
    mysort (pivot:tail) = (mysort before) ++ [pivot] ++ (mysort after)
        where (before, after) = partition pivot tail [] []

--- Write a sort with a comparator

    cmppartition :: Ord a => (a -> a -> Bool) -> a -> [a] -> [a] -> [a] -> ([a], [a])
    cmppartition cmp _ [] before after = (before, after)
    cmppartition cmp pivot (head:tail) before after
        | cmp head pivot = cmppartition cmp pivot tail (head:before) after
        | otherwise      = cmppartition cmp pivot tail before (head:after)

    cmpsort :: Ord a => (a -> a -> Bool) -> [a] -> [a]
    cmpsort cmp [] = []
    cmpsort cmp (pivot:tail) = (cmpsort cmp before) ++ [pivot] ++ (cmpsort cmp after)
        where (before, after) = cmppartition cmp pivot tail [] []

-- Convert string to number

    isDigit :: Char -> Bool
    isDigit val = val >= '0' && val <= '9'

    digitValue :: Char -> Rational
    digitValue digit = toRational ((fromEnum digit) - (fromEnum '0'))

    fractionalHelper :: [Char] -> Rational -> Rational -> Rational
    fractionalHelper [] acc _ = acc
    fractionalHelper (firstDigit:tail) acc tenths
        | isDigit firstDigit = fractionalHelper tail (acc + value / tenths) (tenths * 10)
        | otherwise = fractionalHelper tail acc tenths
        where value = digitValue firstDigit

    stringToNumHelper :: [Char] -> Rational -> Rational
    stringToNumHelper [] acc = acc
    stringToNumHelper ('.':tail) acc = fractionalHelper tail acc 10
    stringToNumHelper (firstDigit:tail) acc
        | isDigit firstDigit = stringToNumHelper tail (acc * 10 + value)
        | otherwise = stringToNumHelper tail acc
        where value = digitValue firstDigit

    stringToNum :: [Char] -> Rational
    stringToNum str = stringToNumHelper str 0

-- Lazy sequences

    everyNth n x = (x:everyNth n (x + n))

    everyThird = everyNth 3
    everyFifth = everyNth 5

    second = head . tail

    newFunc x y = (iterate (second . everyFifth . second . everyThird) (x + y))

-- Partially applied

    halfNum = (* 0.5)
    addNewline = (++ "\n")
