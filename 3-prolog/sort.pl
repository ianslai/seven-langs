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
