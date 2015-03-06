min(List, A) :- min(List, [], A).
min([], A, A).
min([Head|Tail], [], Min) :- min(Tail, Head, Min).
min([Head|Tail], Acc, Min) :- Head < Acc, min(Tail, Head, Min).
min([Head|Tail], Acc, Min) :- Head >= Acc, min(Tail, Acc, Min).
