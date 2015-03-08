% A board has eight queens.
% Each queen has a row from 1-8 and a column from 1-8.
% No two queens can share the same row.
% No two queens can share the same column.
% No two queens can share the same diagonal.
% -> NW to SE diagonal means differences between row and column numbers are the same.
% -> NE to SW diagonal means sums between row and colums numbers is are the same.

eight_queens(Queens) :-
    length(Queens, 8),
    eight_queens(Queens, [], [], [], []).

eight_queens([(HR, HC)|Tail], Rows, Cols, Backslashes, Fwdslashes) :-
    fd_domain(HR, 1, 8),
    fd_domain(HC, 1, 8),
    Backslash is HR - HC,
    Fwdslash is HR + HC,
    eight_queens(Tail, [HR|Rows], [HC|Cols], [Backslash|Backslashes], [Fwdslash|Fwdslashes]).

eight_queens([], Rows, Cols, Backslashes, Fwdslashes) :-
    fd_all_different(Rows),
    fd_all_different(Cols),
    fd_all_different(Backslashes),
    fd_all_different(Fwdslashes).
