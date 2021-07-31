% For research For research mode, activate the RESEARCH constant.
%
% Active code page: 65001 - UTF-8 Encoding
% chcp 65001

-module(match_special_character_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

get_text() ->
"sales1.xls
orders3.xls
sales2.xls
sales3.xls
apac1.xls
europe2.xls
na1.xls
na2.xls
sa1.xls".


-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_text(),
    Regex = ".a.\.xls",

    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),

    ?debugFmt("Captured = ~p~n", [Captured]).

-else.

research_01_test() ->
    Expected =  [["na1.xls"],["na2.xls"],["sa1.xls"]],
    Text = get_text(),
    Regex = ".a.\.xls",

    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).
	
research_02_test() ->
    Expected =  3,
    Text = get_text(),
    Regex = ".a.\.xls",

    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Length = length(Captured),
	Result = Length,
    ?assertEqual(Expected, Result).
-endif.
-endif.
