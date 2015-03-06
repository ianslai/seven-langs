min(List, A) :- List = [H|_], min(List, H, A).
min([], A, A).
min([Head|Tail], Acc, Min) :- Head < Acc, min(Tail, Head, Min).
min([Head|Tail], Acc, Min) :- Head >= Acc, min(Tail, Acc, Min).
