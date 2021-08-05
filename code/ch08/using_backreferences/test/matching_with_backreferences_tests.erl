% For research For research mode, activate the RESEARCH constant.
%
% Active code page: 65001 - UTF-8 Encoding
% chcp 65001
-module(matching_with_backreferences_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_repeated_words_content() ->
    String = read_local_file("data" ++ [$/] ++ "repeated words.txt"),
    String.

get_repeated_words_ru_content() ->
    String = read_local_file("data" ++ [$/] ++ "repeated words ru.txt"),
    String.

get_wrong_tag_content() ->
    String = read_local_file("data" ++ [$/] ++ "hello2.txt"),
    String.

get_wrong_tag_ru_content() ->
    String = read_local_file("data" ++ [$/] ++ "hello2 ru.txt"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_repeated_words_content(),
    Regex = "[ ]+(\\w+)[ ]+\\1",
    TunedRegex = re_tuner:replace(Regex),
    FullResult = re:run(Text, get_mp(TunedRegex), [global, {capture, first, list}]),
    ?debugFmt("Result = ~p~n", [FullResult]).

reasearch_ru_test() ->
    Text = get_repeated_words_ru_content(),
    Regex = "[ ]+(\\w+)[ ]+\\1",
    %TunedRegex = re_tuner:replace(Regex),
    FullResult =
        re:run(Text, get_mp(Regex, [ucp, unicode]), [global, {capture, first, list}]),
    {match, Result} = FullResult,
    ?debugFmt("Result = ~ts~n", [Result]).

-else.

reasearch_hello_test_() ->
    {foreach, local, fun get_repeated_words_content/0, [fun repeated_words_01/1]}.

reasearch_hello_ru_test_() ->
    {foreach,
     local,
     fun get_repeated_words_ru_content/0,
     [fun repeated_words_ru_01/1]}.

reasearch_wrong_test_() ->
    {foreach,
     local,
     fun get_wrong_tag_content/0,
     [fun wrong_01/1, fun wrong_02/1, fun wrong_03/1]}.

reasearch_wrong_ru_test_() ->
    {foreach,
     local,
     fun get_wrong_tag_ru_content/0,
     [fun wrong_ru_01/1, fun wrong_ru_02/1, fun wrong_ru_03/1]}.

repeated_words_01(Text) ->
    Expected = [[" of of"], [" are are"], [" and and"]],
    Regex = "[ ]+(\\w+)[ ]+\\1",
    TunedRegex = re_tuner:replace(Regex),
    {match, Result} =
        re:run(Text, get_mp(TunedRegex), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

repeated_words_ru_01(Text) ->
    Expected =
        [[" текст текст"],
         [" в в"],
         [" повторяются повторяются"],
         [" и и"],
         [" не не"],
         [" должны должны"]],
    Regex = "[ ]+(\\w+)[ ]+\\1",
    {match, Result} =
        re:run(Text, get_mp(Regex, [ucp, unicode]), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

wrong_01(Text) ->
    Expected =
        [["<h1>Welcome to my Homepage</h1>"],
         ["<h2>ColdFusion</h2>"],
         ["<h2>Wireless</h2>"]],
    Regex = "<[hH]([1-6])>.*?</[hH]\\1>",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

wrong_ru_01(Text) ->
    Expected =
        [["<h1>Добро пожаловать на мою домашнюю страницу</h1>"],
         ["<h2>ColdFusion</h2>"],
         ["<h2>Радио</h2>"]],
    Regex = "<[hH]([1-6])>.*?</[hH]\\1>",
    {match, Result} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

wrong_02(Text) ->
    Expected =
        [["<h1>Welcome to my Homepage</h1>"],
         ["<h2>ColdFusion</h2>"],
         ["<h2>Wireless</h2>"]],
    Regex = "(?i)<h([1-6])>.*?</h\\1>",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

wrong_ru_02(Text) ->
    Expected =
        [["<h1>Добро пожаловать на мою домашнюю страницу</h1>"],
         ["<h2>ColdFusion</h2>"],
         ["<h2>Радио</h2>"]],
    Regex = "(?i)<h([1-6])>.*?</h\\1>",
    {match, Result} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

wrong_03(Text) ->
    Expected =
        [["<h1>Welcome to my Homepage</h1>"],
         ["<h2>ColdFusion</h2>"],
         ["<h2>Wireless</h2>"]],
    Regex = "<h([1-6])>.*?</h\\1>",
    {match, Result} =
        re:run(Text, get_mp(Regex, [caseless]), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

wrong_ru_03(Text) ->
    Expected =
        [["<h1>Добро пожаловать на мою домашнюю страницу</h1>"],
         ["<h2>ColdFusion</h2>"],
         ["<h2>Радио</h2>"]],
    Regex = "<h([1-6])>.*?</h\\1>",
    {match, Result} =
        re:run(Text,
               get_mp(Regex, [unicode, caseless]),
               [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

-endif.
-endif.
