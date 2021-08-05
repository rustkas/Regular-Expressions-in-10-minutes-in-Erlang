% For research For research mode, activate the RESEARCH constant.
%
% Active code page: 65001 - UTF-8 Encoding
% chcp 65001
-module(negating_lookaround_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_prices_content() ->
    String = read_local_file("data" ++ [$/] ++ "text with prices.txt"),
    String.

get_prices_ru_content() ->
    String = read_local_file("data" ++ [$/] ++ "text with prices ru.txt"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_prices_content(),
    Regex = "(?<=\\$)\\d+",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?debugFmt("Result = ~p~n", [Result]).

reasearch_ru_test() ->
    Text = get_prices_ru_content(),
    %?debugFmt("Text = ~ts~n", [Text]),
    Regex = "(?<=\\$)\\d+",
    FullResult =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, all, list}]),
    {match, Result} = FullResult,
    ?debugFmt("Result = ~ts~n", [Result]).

-else.

reasearch_test_() ->
    {foreach,
     local,
     fun get_prices_content/0,
     [fun prices_01/1, fun prices_02/1, fun prices_03/1]}.

reasearch_ru_test_() ->
    {foreach,
     local,
     fun get_prices_ru_content/0,
     [fun prices_ru_01/1, fun prices_ru_02/1, fun prices_ru_03/1]}.

prices_01(Text) ->
    Expected = [["30"], ["5"]],
    Regex = "(?<=\\$)\\d+",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

prices_ru_01(Text) ->
    Expected = [["30"], ["5"]],
    Regex = "(?<=\\$)\\d+",
    {match, Result} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

prices_02(Text) ->
    Expected = [["100"], ["50"], ["60"]],
    Regex = "\\b(?<!\\$)\\d+\\b",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

prices_ru_02(Text) ->
    Expected = [["100"], ["50"], ["60"]],
    Regex = "\\b(?<!\\$)\\d+\\b",
    {match, Result} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

prices_03(Text) ->
    Expected = [["0"], ["100"], ["50"], ["60"]],
    Regex = "(?<!\\$)\\d+",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

prices_ru_03(Text) ->
    Expected = [["0"], ["100"], ["50"], ["60"]],
    Regex = "(?<!\\$)\\d+",
    {match, Result} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

-endif.
-endif.
