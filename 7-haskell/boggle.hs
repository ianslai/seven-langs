module Boggle where

    boardSize = 4

    type Coord = (Int, Int)
    type Board = [Char]
    type Word = [Char]
    type Path = [Coord]

    validCoord :: Coord -> Bool
    validCoord (x, y) = (x >= 0) && (y >= 0) && (x < boardSize) && (y < boardSize)

    neighbors :: Coord -> [Coord]
    neighbors (x, y) = filter validCoord adjacent
        where adjacent = [(x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1)]

    letterAt :: Board -> Coord -> Char
    letterAt board (x, y) = board !! (x + y * boardSize)

    findSubString :: Board -> Word -> Path -> [Path]
    findSubString board word path
        | (head word) /= (letterAt board (head path)) = []
        | (length word) == 1                          = [path]
        | otherwise                                   =
            concat (map (\n -> findSubString board (tail word) (n:path)) unusedNeighbors)
        where
            currNeighbors = neighbors (head path)
            unusedNeighbors = [x | x <- currNeighbors, notElem x path]

    findInBoard :: Board -> Word -> [Path]
    findInBoard board word = concat (map (\coord -> findSubString board word [coord]) starts)
        where starts = [(x - 1, y - 1) | x <- [1..boardSize], y <- [1..boardSize]]

-- *Boggle> findInBoard "ABCDABAZAOGGAAEL" "BOGGLE"
-- [[(2,3),(3,3),(3,2),(2,2),(1,2),(1,1)]]
