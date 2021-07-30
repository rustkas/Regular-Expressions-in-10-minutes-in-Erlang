% For research For research mode, activate the RESEARCH constant.
-module(text_sequence_search_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

get_text() ->
    Text = "car scar carry incarceratte",
    Text.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_text(),
    Regex = "\\b[^\\s]*[Cc][Aa][Rr][^\\s]*\\b",
    TunedRegex = re_tuner:replace(Regex),
    {ok, MP} = re:compile(TunedRegex),

    {match, Result} = re:run(Text, MP, [global, {capture, all, list}]),
    ?debugFmt("Found! = ~p~n", [Result]).

-else.

%  searching for a word containing the text car (regardless of case)
car_test_() ->
    {foreach, local, fun get_text/0, 
	[
	fun car_01/1,
	fun car_02/1,
	fun car_03/1
	]}.

car_01(Text) ->
    Expected = [["car"], ["scar"], ["carry"], ["incarceratte"]],
    Regex = "\\b[^\\s]*[Cc][Aa][Rr][^\\s]*\\b",
    TunedRegex = re_tuner:replace(Regex),
    {ok, MP} = re:compile(TunedRegex),

    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

car_02(Text) ->
    Expected = [["car"], ["scar"], ["carry"], ["incarceratte"]],
    Regex = "\\b[^\\s]*car[^\\s]*\\b",
    TunedRegex = re_tuner:replace(Regex),
    {ok, MP} = re:compile(TunedRegex,[caseless]),

    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

car_03(Text) ->
    Expected = [["car"], ["scar"], ["carry"], ["incarceratte"]],
    Regex = "(?i)\\b[^\\s]*car[^\\s]*\\b",
    TunedRegex = re_tuner:replace(Regex),
    {ok, MP} = re:compile(TunedRegex),

    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).
-endif.
-endif.
