% For research For research mode, activate the RESEARCH constant.
%
% Active code page: 65001 - UTF-8 Encoding
% chcp 65001
-module(lookaround_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_head_content() ->
    String = read_local_file("data" ++ [$/] ++ "head.txt"),
    String.

get_head_ru_content() ->
    String = read_local_file("data" ++ [$/] ++ "head ru.txt"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_head_content(),
    Regex = "<[tT][iI][tT][lL][eE]>.*</[tT][iI][tT][lL][eE]>",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?debugFmt("Result = ~p~n", [Result]).

reasearch_ru_test() ->
    Text = get_head_ru_content(),
    Regex = "<[tT][iI][tT][lL][eE]>.*</[tT][iI][tT][lL][eE]>",
    FullResult =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, first, list}]),
    {match, Result} = FullResult,
    ?debugFmt("Result = ~ts~n", [Result]).

-else.

reasearch_test_() ->
    {foreach,
     local,
     fun get_head_content/0,
     [fun head_01/1, fun head_02/1, fun head_03/1]}.

reasearch_ru_test_() ->
    {foreach,
     local,
     fun get_head_ru_content/0,
     [fun head_ru_01/1, fun head_ru_02/1, fun head_ru_03/1]}.

head_01(Text) ->
    Expected = [["<title>Ben Forta's Homepage</title>"]],
    Regex = "<[tT][iI][tT][lL][eE]>.*</[tT][iI][tT][lL][eE]>",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

head_ru_01(Text) ->
    Expected = [["<title>Домашняя страница Бена Форта</title>"]],
    Regex = "<[tT][iI][tT][lL][eE]>.*</[tT][iI][tT][lL][eE]>",
    {match, Result} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

head_02(Text) ->
    Expected = [["<title>Ben Forta's Homepage</title>"]],
    Regex = "(?i)<title>.*</title>",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

head_ru_02(Text) ->
    Expected = [["<title>Домашняя страница Бена Форта</title>"]],
    Regex = "(?i)<title>.*</title>",
    {match, Result} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

head_03(Text) ->
    Expected = [["<title>Ben Forta's Homepage</title>"]],
    Regex = "<title>.*</title>",
    {match, Result} =
        re:run(Text, get_mp(Regex, [caseless]), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

head_ru_03(Text) ->
    Expected = [["<title>Домашняя страница Бена Форта</title>"]],
    Regex = "<title>.*</title>",
    {match, Result} =
        re:run(Text,
               get_mp(Regex, [unicode, caseless]),
               [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

-endif.
-endif.
