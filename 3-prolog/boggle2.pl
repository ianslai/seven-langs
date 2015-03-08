
board((1, 1), 'A').
board((1, 2), 'B').
board((1, 3), 'C').
board((1, 4), 'D').
board((2, 1), 'A').
board((2, 2), 'B').
board((2, 3), 'A').
board((2, 4), 'Z').
board((3, 1), 'A').
board((3, 2), 'O').
board((3, 3), 'G').
board((3, 4), 'G').
board((4, 1), 'A').
board((4, 2), 'A').
board((4, 3), 'E').
board((4, 4), 'L').

valid_cube(R, C) :- fd_domain(R, 1, 4), fd_domain(C, 1, 4).

neighbor((R, C), (R1, C)) :- R1 is R + 1, valid_cube(R1, C).
neighbor((R, C), (R, C1)) :- C1 is C + 1, valid_cube(R, C1).
neighbor((R, C), (R1, C)) :- R1 is R - 1, valid_cube(R1, C).
neighbor((R, C), (R, C1)) :- C1 is C - 1, valid_cube(R, C1).

% Diagonals, for fun
neighbor((R, C), (R1, C1)) :- R1 is R - 1, C1 is C - 1, valid_cube(R1, C1).
neighbor((R, C), (R1, C1)) :- R1 is R - 1, C1 is C + 1, valid_cube(R1, C1).
neighbor((R, C), (R1, C1)) :- R1 is R + 1, C1 is C - 1, valid_cube(R1, C1).
neighbor((R, C), (R1, C1)) :- R1 is R + 1, C1 is C + 1, valid_cube(R1, C1).

% Prune paths that reuse a cube
path_as_ints([], IntPath, IntPath).
path_as_ints([PathHead|PathTail], Acc, IntPath) :-
    PathHead = (R, C),
    PathInt is R * 4 + C,
    path_as_ints(PathTail, [PathInt|Acc], IntPath).
valid_path(Path) :-
    path_as_ints(Path, [], IntPath),
    fd_all_different(IntPath).

% Base case of single letter
path([Letter], Path, Path) :-
    valid_path(Path),
    Path = [PathHead|_],
    board(PathHead, Letter).

path([WordHead|WordTail], [PathHead|PathTail], Path) :-
    board(PathHead, WordHead),
    neighbor(PathHead, Next),
    path(WordTail, [Next|[PathHead|PathTail]], Path).

boggle_word(Word, Path) :-
    atom_chars(Word, Chars),
    valid_cube(R, C),
    path(Chars, [(R, C)], Path).

% boggle_word('BOGGLE', Path).
