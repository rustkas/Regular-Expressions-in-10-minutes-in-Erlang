% For research For research mode, activate the RESEARCH constant.
-module(matching_alphanumeric_characters_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_file_content() ->
    String = read_local_file("data" ++ [$/] ++ "U.S. ZIP Canadian postal codes.txt"),
    String.


-ifdef(RESEARCH).



reasearch_test() ->
    Text = get_file_content(),
	Regex = "\\w\\d\\w\\d\\w\\d",
	Result = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
	?debugFmt("Result = ~p~n", [Result]).
	

-else.

explore_filenames_test_() ->
    {foreach,
     local,
     fun get_file_content/0,
     [fun research_01/1]}.

research_01(Text) ->
    Expected =  [["A1C2E3"],["M1B4F2"],["H1H2H2"]],
	Regex = "\\w\\d\\w\\d\\w\\d",
	{match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).


	
-endif.
-endif.
