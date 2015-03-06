concat([], List, List).
concat([Head|Tail1], List, [Head|Tail2]) :- concat(Tail1, List, Tail2).

% Solution using concat
rev([], []).
rev([A], [A]).
rev([A|Tail], Reverse) :- concat(ReverseTail, [A], Reverse), rev(Tail, ReverseTail).

% Solution without, by using helper accumulator
rev2([], A, A).
rev2([A|Tail], Acc, Reverse) :- rev2(Tail, [A|Acc], Reverse).
rev2(Original, Result) :- rev2(Original, [] , Result).
