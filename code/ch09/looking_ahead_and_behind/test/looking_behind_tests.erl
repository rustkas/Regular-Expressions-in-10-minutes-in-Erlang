% For research For research mode, activate the RESEARCH constant.
%
% Active code page: 65001 - UTF-8 Encoding
% chcp 65001
-module(looking_behind_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_products_content() ->
    String = read_local_file("data" ++ [$/] ++ "products.txt"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_products_content(),
    Regex = "\\$[0-9.]+",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?debugFmt("Result = ~p~n", [Result]).

-else.

reasearch_products_01_test() ->
    Expected = [["$23.45"], ["$5.31"], ["$899.00"], ["$69.96"]],
    Text = get_products_content(),
    Regex = "\\$[0-9.]+",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?assertEqual(Expected, Result).

reasearch_products_02_test() ->
    Expected =
        [["01"],
         ["23.45"],
         ["42"],
         ["5.31"],
         ["1"],
         ["899.00"],
         ["99"],
         ["69.96"],
         ["4"]],
    Text = get_products_content(),
    Regex = "[0-9.]+",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

reasearch_products_03_test() ->
    Expected = [["23.45"], ["5.31"], ["899.00"], ["69.96"]],
    Text = get_products_content(),
    Regex = "(?<=\\$)[0-9.]+",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?assertEqual(Expected, Result).

-endif.
-endif.
