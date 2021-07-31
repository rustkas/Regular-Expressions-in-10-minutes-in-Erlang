% For research For research mode, activate the RESEARCH constant.
%
% Active code page: 65001 - UTF-8 Encoding
% chcp 65001

-module(match_any_character_tests).

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

get_text2()->
"
sales.xls
sales1.xls
orders3.xls
sales2.xls
sales3.xls
apac1.xls
europe2.xls
na1.xls
na2.xls
sa1.xls
".

get_text3()->
"
sales1.xls
orders3.xls
sales2.xls
sales3.xls
apac1.xls
europe2.xls
na1.xls
na2.xls
sa1.xls
".

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_text3(),
    Regex = ".a..",

    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),

    ?debugFmt("Captured = ~p~n", [Captured]).

-else.

research_01_test() ->
    Expected = [["cat"],["cot"]],
    Text = "cat and cot",
    Regex = "c.t",

    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).
	
research_02_test() ->
    Expected = 2,
    Text = "cat and cot",
    Regex = "c.t",

    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Length = length(Captured),
	Result = Length,
    ?assertEqual(Expected, Result).	

research_03_test() ->
    Expected = [["sales1"],["sales2"],["sales3"]],
    Text = get_text(),
    Regex = "sales.",

    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).
	
research_04_test() ->
    Expected = 3,
    Text = get_text(),
    Regex = "sales.",

    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Length = length(Captured),
	Result = Length,
    ?assertEqual(Expected, Result).	

research_05_test() ->
    Expected = [["sales."],["sales1"],["sales2"],["sales3"]],
    Text = get_text2(),
    Regex = "sales.",

    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).
	
research_06_test() ->
    Expected = 4,
    Text = get_text2(),
    Regex = "sales.",

    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Length = length(Captured),
	Result = Length,
    ?assertEqual(Expected, Result).	
	
research_07_test() ->
    Expected = [["sal"],["sal"],["sal"],["pac"],["na1"],["na2"],["sa1"]],
    Text = get_text3(),
    Regex = ".a.",

    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).
	
research_08_test() ->
    Expected = 7,
    Text = get_text3(),
    Regex = ".a.",

    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Length = length(Captured),
	Result = Length,
    ?assertEqual(Expected, Result).		

research_09_test() ->
    Expected = [["sale"],["sale"],["sale"],["pac1"],["na1."],["na2."],["sa1."]],
    Text = get_text3(),
    Regex = ".a..",

    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).
	
research_10_test() ->
    Expected = 7,
    Text = get_text3(),
    Regex = ".a..",

    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Length = length(Captured),
	Result = Length,
    ?assertEqual(Expected, Result).		

-endif.
-endif.
