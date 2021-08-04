% For research For research mode, activate the RESEARCH constant.
-module(string_boundaries_tests).

-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_file_content() ->
    String = read_local_file("data" ++ [$/] ++ "some.xml"),
    String.

get_xml_with_text_content() ->
    String = read_local_file("data" ++ [$/] ++ "some with text.xml"),
    String.

get_html5_content() ->
    String = read_local_file("data" ++ [$/] ++ "html5.html"),
    String.
	
get_empty_strings_content() ->
    String = read_local_file("data" ++ [$/] ++ "empty strings.txt"),
    String.	

get_empty_strings_content2() ->
    String = read_local_file("data" ++ [$/] ++ "empty strings2.txt"),
    String.		
	
-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_empty_strings_content(),
    Regex = "\\s*\\Z",
	TunedRegex =re_tuner:replace(Regex),
	%?debugFmt("TunedRegex = ~p~n", [TunedRegex]),
    {match,Result} = re:run(Text, get_mp(TunedRegex,[]), [notempty,global,{capture, all, list}]),
    ?debugFmt("Result = ~p~n", [Result]).
    


-else.

reasearch_01_test() ->
    Expected = [["<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"]],
	Text = get_file_content(),
    Regex = "<\\?xml.*\\?>",
    {match,Result} = re:run(Text, get_mp(Regex), [global,{capture, all, list}]),
	?assertEqual(Expected,Result).

reasearch_02_test() ->
    Expected = [["<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"]],
	Text = get_xml_with_text_content(),
    Regex = "<\\?xml.*\\?>",
    {match,Result} = re:run(Text, get_mp(Regex), [global,{capture, all, list}]),
	?assertEqual(Expected,Result).
	
reasearch_03_test() ->
    Expected = [["<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"]],
	Text = get_file_content(),
    Regex = "^\\s*<\\?xml.*\\?>",
    {match,Result} = re:run(Text, get_mp(Regex), [global,{capture, all, list}]),
	?assertEqual(Expected,Result).

reasearch_html_01_test() ->
    Expected = [["</html>"]],
	Text = get_html5_content(),
    Regex = "</[Hh][Tt][Mm][Ll]>\\s*$",
	TunedRegex =re_tuner:replace(Regex),
    {match,Result} = re:run(Text, get_mp(TunedRegex), [global,{capture, all, list}]),
	?assertEqual(Expected,Result).

reasearch_html_02_test() ->
    Expected = [["</html>"]],
	Text = get_html5_content(),
    Regex = "(?i)</html>\\s*$",
    TunedRegex =re_tuner:replace(Regex),
    {match,Result} = re:run(Text, get_mp(TunedRegex), [global,{capture, all, list}]),
	?assertEqual(Expected,Result).
	
reasearch_html_03_test() ->
    Expected = [["</html>"]],
	Text = get_html5_content(),
    Regex = "</html>\\s*$",
    TunedRegex =re_tuner:replace(Regex),
    {match,Result} = re:run(Text, get_mp(TunedRegex,[caseless]), [global,{capture, all, list}]),
	?assertEqual(Expected,Result).	
	
research_empty_string_01_test()->
    Expected = [["\r"]],
	Text = get_empty_strings_content(),
    Regex = "^\\s*$",
	TunedRegex =re_tuner:replace(Regex),
    {match,Result} = re:run(Text, get_mp(TunedRegex,[multiline]), [global,{capture, all, list}]),
	?assertEqual(Expected,Result).

research_empty_string_02_test()->
    Expected = [["\r"], ["\r\n"]],
	Text = get_empty_strings_content2(),
    Regex = "^\\s*$",
	TunedRegex =re_tuner:replace(Regex),
    {match,Result} = re:run(Text, get_mp(TunedRegex,[multiline]), [global,{capture, all, list}]),
	?assertEqual(Expected,Result).

research_dollar_only_01_test()->
reasearch_test() ->
    Expected = [["\r\n"]],
    Text = get_empty_strings_content(),
    Regex = "\\s*$",
	TunedRegex =re_tuner:replace(Regex),
    {match,Result} = re:run(Text, get_mp(TunedRegex,[dollar_endonly]), [notempty,global,{capture, all, list}]),
	?assertEqual(Expected,Result).
	
	
	
-endif.
-endif.
