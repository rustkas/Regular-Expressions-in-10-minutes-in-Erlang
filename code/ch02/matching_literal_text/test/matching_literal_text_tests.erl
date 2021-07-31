% For research For research mode, activate the RESEARCH constant.
%
% Active code page: 65001 - UTF-8 Encoding
% chcp 65001

-module(matching_literal_text_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

en() ->
    "Hello, my name is Ben. Please visit\n"
    "my website at http://www.forta.com/.".

ru() ->
    "Привет, меня зовут Бен, а это мой сайт. Пожалуйста, \n"
    "посетите мой сайт http://www.forta.com/.".

-ifdef(RESEARCH).

reasearch_test() ->
    Text = en(),
    Regex = "my",

    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),

    ?debugFmt("Captured = ~p~n", [Captured]).

-else.

en_name_test() ->
    Expected = "Ben",
    Text = en(),
    Regex = Expected,

    {ok, MP} = re:compile(Regex),
    {match, [[Captured]]} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).
	
en_two_words_test() ->
    Expected = 2,
    Text = en(),
    Regex = "my",

    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = length(Captured),
    ?assertEqual(Expected, Result).	

en_caseless_test() ->
    Expected = "Ben",
    Text = en(),
    Regex = "beN",

    {ok, MP} = re:compile(Regex,[caseless]),
    {match, [[Captured]]} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

ru_name_test() ->
    Expected = "Бен",
    Text = ru(),
    Regex = Expected,

    {ok, MP} = re:compile(Regex, [unicode]),
    {match, [[Captured]]} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

ru_two_words_test() ->
    Expected = 2,
    Text = ru(),
    Regex = "мой",

    {ok, MP} = re:compile(Regex, [unicode]),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = length(Captured),
    ?assertEqual(Expected, Result).

ru_caseless_test() ->
    Expected = "Бен",
    Text = ru(),
    Regex = "бЕн",

    {ok, MP} = re:compile(Regex, [caseless,unicode]),
    {match, [[Captured]]} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

-endif.
-endif.
