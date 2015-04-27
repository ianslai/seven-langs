-module(newboggle).
-export([search/1]).
-export([setup_board/2]).
-export([run/0]).

% ------------------------------------------------------------------------

split_word(String) ->
    FirstLetter = string:substr(String, 1, 1),
    Rest = string:substr(String, 2),
    {FirstLetter, Rest}.

board_element(Size, Board, {Row, Col}) ->
    string:substr(Board, Row * Size + Col + 1, 1).

neighbors(Size, {Row, Col}) ->
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
        valid_coord(Coord, Size)].

valid_coord({Row, Col}, Size) ->
    (Row >= 0) and (Row < Size) and (Col >= 0) and (Col < Size).

cube_loop(Desc) ->
    {Id, Letter, Neighbors} = Desc,

    receive
        {[From|FromRest], Letter, "", Path} ->
            From ! {found, [Id|Path], FromRest},
            cube_loop(Desc);

        {FromList, Letter, String, Path} ->
            NewPath = [Id|Path],
            UnusedNeighbors = lists:subtract(Neighbors, Path),
            {NextLetter, NewString} = split_word(String),
            PingNeighbor = fun(Neighbor) -> Neighbor ! {[self()|FromList], NextLetter, NewString, NewPath} end,
            lists:foreach(PingNeighbor, UnusedNeighbors),
            cube_loop(Desc);

        {found, Path, [NotifyHead|NotifyRest]} ->
            NotifyHead ! {found, Path, NotifyRest},
            cube_loop(Desc)
end.

board_loop(Ids) ->
    receive
        {From, String} ->
            {FirstLetter, NewString} = split_word(String),
            lists:foreach(fun (Id) -> Id ! {[From], FirstLetter, NewString, []} end, Ids),
            board_loop(Ids)
end.

to_id({Row, Col}) ->
    String = string:join(["cube", integer_to_list(Row), integer_to_list(Col)], "_"),
    list_to_atom(String).

setup_cube(Coord, Size, Letter) ->
    Neighbors = [to_id(N) || N <- neighbors(Size, Coord)],
    Id = to_id(Coord),
    Loop = fun () -> cube_loop({Id, Letter, Neighbors}) end,
    Pid = spawn(Loop),
    register(Id, Pid),
    Id.

setup_board(BoardAsString, Size) ->
    Range = lists:seq(0, Size - 1),
    Coords = [{Row, Col} || Row <- Range, Col <- Range],
    CubeIds = lists:map(fun (Coord) ->
        Letter = board_element(Size, BoardAsString, Coord),
        setup_cube(Coord, Size, Letter)
    end, Coords),
    Pid = spawn(fun () -> board_loop(CubeIds) end),
    register(board, Pid).

search(String) ->
    board ! {self(), String},
    receive
        {found, Path, _} -> {found, Path}
end.

sample_board() -> "ABCDABAZAOGGAAEL".

run() ->
    setup_board(sample_board(), 4),
    search("BOGGLE").
