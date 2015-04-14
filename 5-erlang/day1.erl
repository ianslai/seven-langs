-module(day1).
-export([count_words/1]).
-export([count_words2/1]).
-export([count_to/1]).
-export([match_success/1]).

% ------------------------------------------------------------------------
count_words(String) -> count_non_word_chars(String, 0).

is_word_char(Char) ->
  if
    (Char >= $A) and (Char =< $Z) -> true;
    (Char >= $a) and (Char =< $z) -> true;
    true -> false
  end.

count_non_word_chars("", Count) -> Count;
count_non_word_chars([Head|Tail], Count) ->
  IsWordChar = is_word_char(Head),
  if
    IsWordChar -> count_word_chars(Tail, Count + 1);
    true -> count_non_word_chars(Tail, Count)
  end.

count_word_chars("", Count) -> Count;
count_word_chars([Head|Tail], Count) ->
  IsWordChar = is_word_char(Head),
  if
    IsWordChar -> count_word_chars(Tail, Count);
    true -> count_non_word_chars(Tail, Count)
  end.

% ------------------------------------------------------------------------

count_words2(String) -> count_words2(String, 0, false).

count_words2("", Count, _) -> Count;
count_words2([Head|Tail], Count, LastCharIsWord) ->
  HeadIsWordChar = is_word_char(Head),
  StartNewWord = (not LastCharIsWord) and HeadIsWordChar,
  NewCount = case StartNewWord of
    true -> Count + 1;
    false -> Count
  end,
  count_words2(Tail, NewCount, HeadIsWordChar).  

% ------------------------------------------------------------------------

count_to(Num) -> count_to(Num, 1).

count_to(Num, Start) ->
  if 
    Num >= Start ->
      io:format("~p~n", [Start]),
      count_to(Num, Start + 1);
    true -> ok
  end.

% ------------------------------------------------------------------------

% match_success(Input) ->
%   case Input of
%     success -> io:format("success~n");
%     {error, Message} -> io:format("error: ~s~n", [Message])
%   end.

match_success(success) -> io:format("success~n");
match_success({error, Message}) -> io:format("error: ~s~n", [Message]).

% ------------------------------------------------------------------------
