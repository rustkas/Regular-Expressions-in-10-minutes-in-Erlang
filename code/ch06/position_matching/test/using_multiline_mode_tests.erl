% For research For research mode, activate the RESEARCH constant.
-module(using_multiline_mode_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_file_content() ->
    String = read_local_file("data" ++ [$/] ++ "doSpellCheck.js"),
    String.

get_js_content() ->
    String = read_local_file("data" ++ [$/] ++ "doSpellCheck.js"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_file_content(),
    %?debugFmt("Text = ~p~n", [Text]),
    Regex = "(?m)^\\s*//.*$",
    TunedRegex = re_tuner:replace(Regex),
    %?debugFmt("TunedRegex = ~p~n", [TunedRegex]),
    MatchResult = re:run(Text, get_mp(TunedRegex), [global, {capture, all, list}]),
    ?debugFmt("Result = ~p~n", [MatchResult]).

        %{match,Result} = re:run(Text, get_mp(TunedRegex,[multiline]), [global,{capture, all, list}]),
        %?debugFmt("Result = ~p~n", [Result]).

-else.

reasearch_01_test() ->
    Expected =
        [["// Make sure not empty\r"],
         ["\r\n// Init\r"],
         ["\r\n// ...\r"],
         ["\r\n// Done\r"]],
    Text = get_file_content(),
    Regex = "(?m)^\\s*//.*$",
    TunedRegex = re_tuner:replace(Regex),
    {match, Result} =
        re:run(Text, get_mp(TunedRegex), [global, {capture, all, list}]),
    ?assertEqual(Expected, Result).

reasearch_02_test() ->
    Expected =
        [["// Make sure not empty\r"],
         ["\r\n// Init\r"],
         ["\r\n// ...\r"],
         ["\r\n// Done\r"]],
    Text = get_file_content(),
    Regex = "^\\s*//.*$",
    TunedRegex = re_tuner:replace(Regex),
    {match, Result} =
        re:run(Text, get_mp(TunedRegex, [multiline]), [global, {capture, all, list}]),
    ?assertEqual(Expected, Result).

reasearch_03_test() ->
    Expected = [["</script>"]],
    Text = get_js_content(),
    Regex = "</script>\\Z",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?assertEqual(Expected, Result).

reasearch_04_test() ->
    Expected = [["<script>"]],
    Text = get_js_content(),
    Regex = "\\A<script>",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?assertEqual(Expected, Result).

-endif.
-endif.
