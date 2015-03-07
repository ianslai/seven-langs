% Alternate form of min where we accumulate a list with the same elements
% as the original where the minimum is always at the head,
% instead of just finding the minimum value
min([], L, L).
min([Head|Tail], [Acc|AT], Min) :- Head < Acc, min(Tail, [Head|[Acc|AT]], Min).
min([Head|Tail], [Acc|AT], Min) :- Head >= Acc, min(Tail, [Acc|[Head|AT]], Min).
min([Head|Tail], [], Min) :- min(Tail, [Head], Min).

% So sorting is just merely figuring out what the minimum value is
% and keeping it at the front, while recursing on the rest of the list.
sort_([], []).
sort_(List, [Min|SortedTail]) :- min(List, [], [Min|MinTail]), sort_(MinTail, SortedTail).


% Alternate sort inspired by QuickSort.

concat([], List, List).
concat([Head|Tail1], List, [Head|Tail2]) :- concat(Tail1, List, Tail2).

partition(Pivot, List, Lower, Higher) :-
    partition(Pivot, List, [], Lower, [], Higher).

partition(_, [], Lower, Lower, Higher, Higher).

partition(Pivot, [Head|Tail], LowerAcc, Lower, HigherAcc, Higher) :-
    Head < Pivot,
    partition(Pivot, Tail, [Head|LowerAcc], Lower, HigherAcc, Higher).

partition(Pivot, [Head|Tail], LowerAcc, Lower, HigherAcc, Higher) :-
    Head >= Pivot,
    partition(Pivot, Tail, LowerAcc, Lower, [Head|HigherAcc], Higher).

qsort([], []).
qsort([Head|Tail], Sorted) :-
    Pivot = Head,
    partition(Pivot, Tail, Lower, Higher),
    qsort(Lower, SortedLower),
    qsort(Higher, SortedHigher),
    concat(SortedLower, [Pivot|SortedHigher], Sorted).
