-module(day1).
-export([count_words/1]).
-export([count_to/1]).

count_words(String) -> count_non_word_chars(String, 0).

is_word_char(Char) ->
  if
    (Char >= $A) and (Char =< $Z) -> true;
    (Char >= $a) and (Char =< $z) -> true;
    true -> false
  end.

count_non_word_chars(String, Count) ->
  case String of
    "" -> Count;
    [Head|Tail] ->
      IsWordChar = is_word_char(Head),
      if
        IsWordChar -> count_word_chars(Tail, Count + 1);
        true -> count_non_word_chars(Tail, Count)
      end
  end.

count_word_chars(String, Count) ->
  case String of
    "" -> Count;
    [Head|Tail] ->
      IsWordChar = is_word_char(Head),
      if
        IsWordChar -> count_word_chars(Tail, Count);
        true -> count_non_word_chars(Tail, Count)
      end
  end.


count_to(Num) -> count_to(Num, 1).

count_to(Num, Start) ->
  if 
    Num /= Start ->
      io:format("~p~n", [Start]),
      count_to(Num, Start + 1);
    true -> Num
  end.
