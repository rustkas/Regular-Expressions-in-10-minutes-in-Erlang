% For research For research mode, activate the RESEARCH constant.
-module(preventing_over_matching_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_file_content() ->
    String = read_local_file("data" ++ [$/] ++ "html with b.txt"),
    String.

get_file_ru_content() ->
    String = read_local_file("data" ++ [$/] ++ "html with b ru.txt"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_file_content(),
    Regex = "(?U)<[Bb]>.*</[Bb]>",
    {ok, MP} = re:compile(Regex, []),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),

    ?debugFmt("Result = ~p~n", [Captured]).

-else.

research_01_test() ->
    Expected = "<b>AK</b> and <b>HI</b>",
    Text = get_file_content(),
    Regex = "<[Bb]>.*</[Bb]>",
    {match, [Captured]} = re:run(Text, get_mp(Regex), [{capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

research_01_ru_test() ->
    Expected = "<b>AK</b> and <b>HI</b>",
    Text = get_file_ru_content(),
    Regex = "<[Bb]>.*</[Bb]>",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, [Captured]} = re:run(Text, MP, [{capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

lazy_01_test() ->
    Expected = [["<b>AK</b>"], ["<b>HI</b>"]],
    Text = get_file_content(),
    Regex = "<[Bb]>.*?</[Bb]>",
    {match, Captured} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

lazy_01_ru_test() ->
    Expected = [["<b>AK</b>"], ["<b>HI</b>"]],
    Text = get_file_ru_content(),
    Regex = "<[Bb]>.*?</[Bb]>",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, [Captured]} = re:run(Text, MP, [{capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

lazy_02_test() ->
    Expected = [["<b>AK</b>"], ["<b>HI</b>"]],
    Text = get_file_content(),
    Regex = "<[Bb]>.*</[Bb]>",
    {ok, MP} = re:compile(Regex, [ungreedy]),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

lazy_02_ru_test() ->
    Expected = [["<b>AK</b>"], ["<b>HI</b>"]],
    Text = get_file_ru_content(),
    Regex = "<[Bb]>.*</[Bb]>",
    {ok, MP} = re:compile(Regex, [ungreedy, unicode]),
    {match, [Captured]} = re:run(Text, MP, [{capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

lazy_03_test() ->
    Expected = [["<b>AK</b>"], ["<b>HI</b>"]],
    Text = get_file_content(),
    Regex = "(?U)<[Bb]>.*</[Bb]>",
    {match, Captured} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

lazy_03_ru_test() ->
    Expected = [["<b>AK</b>"], ["<b>HI</b>"]],
    Text = get_file_ru_content(),
    Regex = "(?U)<[Bb]>.*</[Bb]>",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, [Captured]} = re:run(Text, MP, [{capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

-endif.
-endif.
