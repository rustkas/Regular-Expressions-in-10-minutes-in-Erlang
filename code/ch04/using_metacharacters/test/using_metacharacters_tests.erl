% For research For research mode, activate the RESEARCH constant.
-module(using_metacharacters_tests).

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

get_folder_path_content() ->
    String = read_local_file("data" ++ [$/] ++ "folder path.txt"),
    String.
	
-ifdef(RESEARCH).



reasearch_test() ->
    Text = get_folder_path_content(),
	?debugFmt("Text = ~p~n", [Text]),
	Regex = "\\\\",
	%Result = re:run(Text, get_mp(Regex), [ {capture, all, list}]),
	Result = re:replace(Text,Regex,"/",[global,{return,list}]),
	?debugFmt("Result = ~p~n", [Result]).
	

-else.

explore_filenames_test_() ->
    {foreach,
     local,
     fun get_file_content/0,
     [fun research_01/1, fun research_02/1, fun research_03/1]}.

research_01(Text) ->
    Expected = nomatch,
    Regex = "myArray[0]",
    MP = get_mp(Regex),
    Result = re:run(Text, MP, [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

research_02(Text) ->
    Expected = 15,
    Regex = "myArray",
	MP = get_mp(Regex),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Length = length(Captured),
    Result = Length,
    ?_assertEqual(Expected, Result).

research_03(Text) ->
    Regex = "myArray\\[0\\]",
    Expected = "myArray[0]",
    MP = get_mp(Regex),
    {match, [Captured]} = re:run(Text, MP, [{capture, first, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

research_04(Text) ->
    Regex = "myArray\\[[0-9]\\]",
    Expected = "myArray[0]",
    MP = get_mp(Regex),
    {match, [Captured]} = re:run(Text, MP, [{capture, first, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).
	
research_folder_path_01_test()->
    Expected = "/home/ben/sales/",
    Text = get_folder_path_content(),
	Regex = "\\\\",
	Result = re:replace(Text,Regex,"/",[global,{return,list}]),
	?assertEqual(Expected, Result).
	
	
-endif.
-endif.
