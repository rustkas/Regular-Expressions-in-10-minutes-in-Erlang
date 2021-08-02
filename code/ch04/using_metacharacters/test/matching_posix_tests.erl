% For research For research mode, activate the RESEARCH constant.
-module(matching_posix_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_file_content() ->
    String = read_local_file("data" ++ [$/] ++ "html_info.html"),
    String.
get_css_file_content() ->
    String = read_local_file("data" ++ [$/] ++ "colors.css"),
    String.

-ifdef(RESEARCH).



reasearch_test() ->
    Text = get_file_content(),
	Regex = "#[[:xdigit:]][[:xdigit:]][[:xdigit:]][[:xdigit:]][[:xdigit:]][[:xdigit:]]",
	%{ok, MP} = re:compile(Regex),
	%{match,Result} = re:run(Text, MP, [global, {capture, all, list}]),
	Result = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
	?debugFmt("Result = ~p~n", [Result]).
	

-else.

explore_html_test_() ->
    {foreach,
     local,
     fun get_file_content/0,
     [fun research_01/1]}.
	 
explore_css_test_() ->
    {foreach,
     local,
     fun get_css_file_content/0,
     [fun research_css_01/1]}.	 

research_01(Text) ->
    Expected =  [["#336633"],["#FFFFFF"]],
	Regex = "#[[:xdigit:]][[:xdigit:]][[:xdigit:]][[:xdigit:]][[:xdigit:]][[:xdigit:]]",
	{match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

research_css_01(Text) ->
    Expected =  [["#fefbd8"],["#0000ff"],["#d0f4e6"],["#f08970"]],
	Regex = "#[[:xdigit:]][[:xdigit:]][[:xdigit:]][[:xdigit:]][[:xdigit:]][[:xdigit:]]",
	{match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

	
-endif.
-endif.
