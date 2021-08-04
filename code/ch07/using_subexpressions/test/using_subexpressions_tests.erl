% For research For research mode, activate the RESEARCH constant.
-module(using_subexpressions_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_file_content() ->
    String = read_local_file("data" ++ [$/] ++ "nonbreaking spaces.txt"),
    String.

get_file_ru_content() ->
    String = read_local_file("data" ++ [$/] ++ "nonbreaking spaces ru.txt"),
    String.

get_ip_content() ->
    String = read_local_file("data" ++ [$/] ++ "ip.txt"),
    String.

get_ip_ru_content() ->
    String = read_local_file("data" ++ [$/] ++ "ip ru.txt"),
    String.

get_info_content() ->
    String = read_local_file("data" ++ [$/] ++ "info.txt"),
    String.

get_info_ru_content() ->
    String = read_local_file("data" ++ [$/] ++ "info ru.txt"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_info_content(),
    Regex = "(19|20)\\d{2}",
    FullResult = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?debugFmt("Result = ~p~n", [FullResult]).

reasearch_ru_test() ->
    Text = get_info_ru_content(),
    Regex = "(19|20)\\d{2}",
    FullResult =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, first, list}]),
    ?debugFmt("Result = ~p~n", [FullResult]).

-else.

reasearch_01_test() ->
    Expected = nomatch,
    Text = get_file_content(),
    Regex = "&nbsp;{2,}",
    Result = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?assertEqual(Expected, Result).

reasearch_02_test() ->
    Expected = [["&nbsp;&nbsp;"]],
    Text = get_file_content(),
    Regex = "(&nbsp;){2,}",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

reasearch_01_ru_test() ->
    Expected = nomatch,
    Text = get_file_ru_content(),
    Regex = "&nbsp;{2,}",
    Result = re:run(Text, get_mp(Regex, [unicode]), [global, {capture, all, list}]),
    ?assertEqual(Expected, Result).

reasearch_02_ru_test() ->
    Expected = [["&nbsp;&nbsp;"]],
    Text = get_file_ru_content(),
    Regex = "(&nbsp;){2,}",
    {match, Result} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

reasearch_ip_01_test() ->
    Expected = [["12.159.46.200"]],
    Text = get_ip_content(),
    Regex = "\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?assertEqual(Expected, Result).

reasearch_ip_ru_01_test() ->
    Expected = [["12.159.46.200"]],
    Text = get_ip_ru_content(),
    Regex = "\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}",
    {match, Result} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, all, list}]),
    ?assertEqual(Expected, Result).

reasearch_ip_02_test() ->
    Expected = [["12.159.46.200"]],
    Text = get_ip_content(),
    Regex = "(\\d{1,3}\\.){3}\\d{1,3}",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

reasearch_ip_ru_02_test() ->
    Expected = [["12.159.46.200"]],
    Text = get_ip_ru_content(),
    Regex = "(\\d{1,3}\\.){3}\\d{1,3}",
    {match, Result} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

reasearch_info_01_test() ->
    Expected = [["19"]],
    Text = get_info_content(),
    Regex = "19|20\\d{2}",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

reasearch_info_ru_01_test() ->
    Expected = [["19"]],
    Text = get_info_ru_content(),
    Regex = "19|20\\d{2}",
    {match, Result} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

reasearch_info_02_test() ->
    Expected = [["1967"]],
    Text = get_info_content(),
    Regex = "(19|20)\\d{2}",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

reasearch_info_ru_02_test() ->
    Expected = [["1967"]],
    Text = get_info_ru_content(),
    Regex = "(19|20)\\d{2}",
    {match, Result} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

-endif.
-endif.
