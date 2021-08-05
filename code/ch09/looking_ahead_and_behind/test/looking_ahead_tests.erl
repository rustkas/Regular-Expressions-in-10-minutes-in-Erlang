% For research For research mode, activate the RESEARCH constant.
%
% Active code page: 65001 - UTF-8 Encoding
% chcp 65001
-module(looking_ahead_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_links_content() ->
    String = read_local_file("data" ++ [$/] ++ "links.txt"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_links_content(),
    Regex = ".+(?=:)",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?debugFmt("Result = ~p~n", [Result]).

-else.

reasearch_links_test() ->
    Expected = [["http"], ["https"], ["ftp"]],
    Text = get_links_content(),
    Regex = ".+(?=:)",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?assertEqual(Expected, Result).

reasearch_links2_test() ->
    Expected = [["http:"], ["https:"], ["ftp:"]],
    Text = get_links_content(),
    Regex = ".+(:)",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

-endif.
-endif.
