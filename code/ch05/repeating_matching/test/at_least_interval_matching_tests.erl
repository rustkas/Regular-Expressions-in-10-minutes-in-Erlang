% For research For research mode, activate the RESEARCH constant.
-module(at_least_interval_matching_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_file_content() ->
    String = read_local_file("data" ++ [$/] ++ "orders_list.txt"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
	
    Text = get_file_content(),
    Regex = "\\d+: \\$\\d{3,}\\.\\d{2}",
    RunString = re:run(Text, get_mp(Regex), [global,{capture, all, list}]),
	?debugFmt("Result = ~p~n", [RunString]).
	
-else.

reasearch_test_() ->
    {foreach,
     local,
     fun get_file_content/0,
     [fun research_01/1, fun research_02/1]}.

research_01(Text) ->
    Expected = [["1001: $496.80"],
                 ["1002: $1290.69"],
                 ["1004: $613.42"],
                 ["1004: $613.42"],
                 ["1006: $414.90"]],
    Regex = "\\d+: \\$\\d{3,}\\.\\d{2}",
    {match, Captured} = re:run(Text, get_mp(Regex), [global,{capture, all, list}]),
    Result = Captured,
	?_assertEqual(Expected, Result).

research_02(Text) ->
    Expected = [["1001: $496.80"],
                 ["1002: $1290.69"],
                 ["1004: $613.42"],
                 ["1004: $613.42"],
                 ["1006: $414.90"]],
    Regex = "\\d{1,}: \\$\\d{3,}\\.\\d{2}",
    {match, Captured} = re:run(Text, get_mp(Regex), [global,{capture, all, list}]),
    Result = Captured,
	?_assertEqual(Expected, Result).

-endif.
-endif.

