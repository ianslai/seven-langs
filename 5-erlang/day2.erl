-module(day2).
-export([get_value/2]).
-export([tally_subtotals/1]).
-export([tictactoe/1]).
-export([run/0]).

% ------------------------------------------------------------------------
get_value([{Keyword, Value}|_], Keyword) -> Value;
get_value([_|Tail], Keyword) -> get_value(Tail, Keyword).

% ------------------------------------------------------------------------
tally_subtotals(List) ->
    [{Item, Quantity * Price} || {Item, Quantity, Price} <- List].

% ------------------------------------------------------------------------
tictactoe({A, B, C, D, E, F, G, H, I}) ->
    Winners = t_tally([
        t_winner({A, B, C}),
        t_winner({D, E, F}),
        t_winner({G, H, I}),
        t_winner({A, D, G}),
        t_winner({B, E, H}),
        t_winner({C, F, I}),
        t_winner({A, E, I}),
        t_winner({C, E, G})
    ]),
    io:format("~p~n", [Winners]),
    AnyOWinners = maps:get(o, Winners) > 0,
    AnyXWinners = maps:get(x, Winners) > 0,
    AnyEmpties = maps:get(empty, Winners) > 0,
    if
        AnyOWinners ->
            if
                not AnyXWinners -> o;
                true -> undetermined
            end;
        AnyXWinners ->
            if
                not AnyOWinners -> x;
                true -> undetermined
            end;
        AnyEmpties -> no_winner;
        true -> cat
    end.

t_winner({x, x, x}) -> x;
t_winner({o, o, o}) -> o;
t_winner({A, B, C}) ->
    if
        (A == e) or (B == e) or (C == e) -> empty;
        true -> cat
    end.

t_tally(Winners) ->
    t_tally(Winners, #{empty => 0, cat => 0, x => 0, o => 0}).

t_tally([], Map) -> Map;
t_tally([Head|Tail], Map) ->
    NewMap = maps:put(Head, maps:get(Head, Map) + 1, Map),
    t_tally(Tail, NewMap).

% ------------------------------------------------------------------------
run() ->
    Languages = [{erlang, "a functional language"}, {ruby, "an OO language"}],
    io:format("erlang = ~s~n", [get_value(Languages, erlang)]),
    io:format("ruby = ~s~n", [get_value(Languages, ruby)]),

    tally_subtotals([{orange, 3, 5.00}, {apple, 2, 2.50}]).
