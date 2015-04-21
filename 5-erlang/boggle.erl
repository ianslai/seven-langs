-module(boggle).
-export([search/3]).
-export([sample_board/0]).
-export([run/0]).

% ------------------------------------------------------------------------

board_element([{size, Size}, {board, Board}], {Row, Col}) ->
    string:substr(Board, Row * Size + Col + 1, 1).

valid_coord({Row, Col}, Size) ->
    (Row >= 0) and (Row < Size) and (Col >= 0) and (Col < Size).

search(BoardAsString, Size, String) ->
    Range = lists:seq(0, Size - 1),
    Starts = [{Row, Col} || Row <- Range, Col <- Range],
    search_starts([{size, Size}, {board, BoardAsString}], String, Starts).

search_starts(_, _, []) -> no_match;
search_starts(Board, String, [Start|Rest]) ->
    Answer = search_string(Board, String, [Start]),
    case Answer of
        no_match -> search_starts(Board, String, Rest);
        _ -> Answer
    end.

search_string(_, "", Path) -> Path;
search_string(Board, String, Path) ->
    Char = string:substr(String, 1, 1),
    StringRest = string:substr(String, 2),

    [PathHead|_] = Path,
    CharAtPathHead = board_element(Board, PathHead),
    if
        Char /= CharAtPathHead -> no_match;
        true ->
            case StringRest of
                "" -> Path;
                _ ->
                    Neighbors = neighbors(Board, PathHead, Path),
                    search_string(Board, StringRest, Path, Neighbors)
            end
    end.

search_string(_, _, _, []) -> no_match;
search_string(Board, String, Path, [Neighbor|NeighborRest]) ->
    Answer = search_string(Board, String, [Neighbor|Path]),
    case Answer of
        no_match -> search_string(Board, String, Path, NeighborRest);
        _ -> Answer
    end.

neighbors([{size, Size}, _], {Row, Col}, Avoid) ->
    Candidates = [
        {Row + 1, Col},
        {Row - 1, Col},
        {Row, Col + 1},
        {Row, Col - 1},
        {Row - 1, Col - 1},
        {Row + 1, Col - 1},
        {Row - 1, Col + 1},
        {Row + 1, Col + 1}
    ],
    [Coord || Coord <- Candidates,
        valid_coord(Coord, Size),
        not lists:any(fun(X) -> X == Coord end, Avoid)].


sample_board() -> "ABCDABAZAOGGAAEL".

run() ->
    search(sample_board(), 4, "BOGGLE").
