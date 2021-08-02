% For research For research mode, activate the RESEARCH constant.
-module(matching_digits_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_file_content() ->
    String = read_local_file("data" ++ [$/] ++ "my_array.js"),
    String.


-ifdef(RESEARCH).



reasearch_test() ->
    Text = get_file_content(),
	Regex = "myArray\\[\\d\\]",
	Result = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
	?debugFmt("Result = ~p~n", [Result]).
	

-else.

explore_filenames_test_() ->
    {foreach,
     local,
     fun get_file_content/0,
     [fun research_01/1,fun research_02/1,fun research_03/1]}.

research_01(Text) ->
    Expected =  [["myArray[0]"],["myArray[0]"],["myArray[1]"],["myArray[1]"]],
	Regex = "myArray\\[\\d\\]",
	{match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).


research_02(Text) ->
    Expected =  [["myArray[0]"],["myArray[0]"],["myArray[1]"],["myArray[1]"]],
	Regex = "myArray\\[[0-9]\\]",
	{match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).
	
research_03(Text) ->
    Expected =  [["myArray[0]"],["myArray[0]"],["myArray[1]"],["myArray[1]"]],
	Regex = "myArray\\[[0123456789]\\]",
	{match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).
	
-endif.
-endif.
