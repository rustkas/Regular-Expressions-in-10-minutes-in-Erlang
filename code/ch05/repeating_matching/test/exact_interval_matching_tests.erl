% For research For research mode, activate the RESEARCH constant.
-module(exact_interval_matching_tests).

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
    Text = get_css_file_content(),
    Regex = "#[A-Fa-f0-9]{6}",
    RunString = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?debugFmt("Result = ~p~n", [RunString]).

-else.

reasearch_html_01_test() ->
    Expected = [["#336633"], ["#FFFFFF"]],
    Text = get_file_content(),
    Regex = "#[A-Fa-f0-9]{6}",
    {match, Captured} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

reasearch_html_02_test() ->
    Expected = [["#336633"], ["#FFFFFF"]],
    Text = get_file_content(),
    Regex = "#[[:xdigit:]]{6}",
    {match, Captured} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

reasearch_css_01_test() ->
    Expected = [["#fefbd8"], ["#0000ff"], ["#d0f4e6"], ["#f08970"]],
    Text = get_css_file_content(),
    Regex = "#[A-Fa-f0-9]{6}",
    {match, Captured} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

reasearch_css_02_test() ->
    Expected = [["#fefbd8"], ["#0000ff"], ["#d0f4e6"], ["#f08970"]],
    Text = get_css_file_content(),
    Regex = "#[[:xdigit:]]{6}",
    {match, Captured} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

-endif.
-endif.
