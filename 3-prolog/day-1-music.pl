plays('Bob Dylan', guitar).
plays('Stevie Wonder', piano).
plays('Mick Jagger', guitar).
plays('Ringo Starr', drums).
plays('Joshua Bell', violin).

genre('Bob Dylan', folk).
genre('Stevie Wonder', funk).
genre('Mick Jagger', rock).
genre('Ringo Starr', pop).
genre('Joshua Bell', classical).


% | ?- plays(Musician, guitar).
%
% Musician = 'Bob Dylan' ? a
%
% Musician = 'Mick Jagger'
%
% no
