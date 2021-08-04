% For research For research mode, activate the RESEARCH constant.
-module(range_interval_matching_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_file_content() ->
    String = read_local_file("data" ++ [$/] ++ "dates.txt"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_file_content(),
    Regex = "\\d{0,4}",
    RunString =
        re:run(Text, get_mp(Regex), [notempty, global, {capture, all, list}]),
    ?debugFmt("Result = ~p~n", [RunString]).

-else.

reasearch_test_() ->
    {foreach,
     local,
     fun get_file_content/0,
     [fun research_01/1, fun research_02/1]}.

research_01(Text) ->
    Expected = [["4/8/17"], ["10-6-2018"], ["01-01-01"]],
    Regex = "\\d{1,2}[-/]\\d{1,2}[-/]\\d{2,4}",
    {match, Captured} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

research_02(Text) ->
    Expected =
        [["4"],
         ["8"],
         ["17"],
         ["10"],
         ["6"],
         ["2018"],
         ["2"],
         ["2"],
         ["2"],
         ["01"],
         ["01"],
         ["01"]],
    Regex = "\\d{0,4}",
    {match, Captured} =
        re:run(Text, get_mp(Regex), [notempty, global, {capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

-endif.
-endif.
