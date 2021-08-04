% For research For research mode, activate the RESEARCH constant.
-module(nesting_subexpressions_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_ip_content() ->
    String = read_local_file("data" ++ [$/] ++ "ip.txt"),
    String.

get_ip_ru_content() ->
    String = read_local_file("data" ++ [$/] ++ "ip ru.txt"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_ip_content(),
    Regex =
        "(((25[0-5])|(2[0-4]\\d)|(1\\d{2})|(\\d{1,2}))\\.){3}((25[0-5])|(2[0-4]\\d)|(1\\d{2})|(\\d{1,2}))",
    FullResult = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?debugFmt("Result = ~p~n", [FullResult]).

reasearch_ru_test() ->
    Text = get_ip_ru_content(),
    Regex =
        "(((\\d{1,2})|(1\\d{2})|(2[0-4]\\d)|(25[0-5]))\\.){3}((\\d{1,2})|(1\\d{2})|(2[0-4]\\d)|(25[0-5]))",
    FullResult =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, first, list}]),
    ?debugFmt("Result = ~p~n", [FullResult]).

-else.

reasearch_ip_01_test() ->
    Expected = [["12.159.46.200"]],
    Text = get_ip_content(),
    Regex =
        "(((25[0-5])|(2[0-4]\\d)|(1\\d{2})|(\\d{1,2}))\\.){3}((25[0-5])|(2[0-4]\\d)|(1\\d{2})|(\\d{1,2}))",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

reasearch_ip_ru_01_test() ->
    Expected = [["12.159.46.200"]],
    Text = get_ip_ru_content(),
    Regex =
        "(((25[0-5])|(2[0-4]\\d)|(1\\d{2})|(\\d{1,2}))\\.){3}((25[0-5])|(2[0-4]\\d)|(1\\d{2})|(\\d{1,2}))",
    {match, Result} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

-endif.
-endif.
