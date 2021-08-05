% For research For research mode, activate the RESEARCH constant.
%
% Active code page: 65001 - UTF-8 Encoding
% chcp 65001
-module(using_backreferences_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_hello_content() ->
    String = read_local_file("data" ++ [$/] ++ "hello.txt"),
    String.

get_hello_ru_content() ->
    String = read_local_file("data" ++ [$/] ++ "hello ru.txt"),
    String.

get_wrong_tag_content() ->
    String = read_local_file("data" ++ [$/] ++ "hello2.txt"),
    String.

get_wrong_tag_ru_content() ->
    String = read_local_file("data" ++ [$/] ++ "hello2 ru.txt"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_wrong_tag_content(),
    Regex = "<[hH][1-6]>.*?</[hH][1-6]>",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?debugFmt("Result = ~p~n", [Result]).

reasearch_ru_test() ->
    Text = get_wrong_tag_ru_content(),
    Regex = "<[hH][1-6]>.*?</[hH][1-6]>",
    FullResult =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, all, list}]),
    {match, Result} = FullResult,
    ?debugFmt("Result = ~ts~n", [Result]).

-else.

reasearch_hello_test_() ->
    {foreach,
     local,
     fun get_hello_content/0,
     [fun hello_01/1,
      fun hello_02/1,
      fun hello_03/1,
      fun hello_any_header_01/1,
      fun hello_any_header_02/1,
      fun hello_any_header_03/1]}.

reasearch_hello_ru_test_() ->
    {foreach,
     local,
     fun get_hello_ru_content/0,
     [fun hello_ru_01/1,
      fun hello_ru_02/1,
      fun hello_ru_03/1,
      fun hello_any_header_ru_01/1,
      fun hello_any_header_ru_02/1,
      fun hello_any_header_ru_03/1]}.

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

hello_01(Text) ->
    Expected = "<h1>Welcome to my Homepage</h1>",
    Regex = "<[hH]1>.*</[hH]1>",
    {match, [[Result]]} =
        re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

hello_ru_01(Text) ->
    Expected = "<h1>Добро пожаловать на мою домашнюю страницу</h1>",
    Regex = "<[hH]1>.*</[hH]1>",
    {match, [[Result]]} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

hello_02(Text) ->
    Expected = "<h1>Welcome to my Homepage</h1>",
    Regex = "(?i)<h1>.*</h1>",
    {match, [[Result]]} =
        re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

hello_ru_02(Text) ->
    Expected = "<h1>Добро пожаловать на мою домашнюю страницу</h1>",
    Regex = "(?i)<h1>.*</h1>",
    {match, [[Result]]} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

hello_03(Text) ->
    Expected = "<h1>Welcome to my Homepage</h1>",
    Regex = "<h1>.*</h1>",
    {match, [[Result]]} =
        re:run(Text, get_mp(Regex, [caseless]), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

hello_ru_03(Text) ->
    Expected = "<h1>Добро пожаловать на мою домашнюю страницу</h1>",
    Regex = "<h1>.*</h1>",
    {match, [[Result]]} =
        re:run(Text,
               get_mp(Regex, [unicode, caseless]),
               [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

hello_any_header_01(Text) ->
    Expected =
        [["<h1>Welcome to my Homepage</h1>"], ["<h2>SQL</h2>"], ["<h2>RegEx</h2>"]],
    Regex = "<[hH][1-6]>.*?</[hH][1-6]>",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

hello_any_header_ru_01(Text) ->
    Expected =
        [["<h1>Добро пожаловать на мою домашнюю страницу</h1>"],
         ["<h2>SQL</h2>"],
         ["<h2>RegEx</h2>"]],
    Regex = "<[hH][1-6]>.*?</[hH][1-6]>",
    {match, Result} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

hello_any_header_02(Text) ->
    Expected =
        [["<h1>Welcome to my Homepage</h1>"], ["<h2>SQL</h2>"], ["<h2>RegEx</h2>"]],
    Regex = "(?i)<h[1-6]>.*?</h[1-6]>",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

hello_any_header_ru_02(Text) ->
    Expected =
        [["<h1>Добро пожаловать на мою домашнюю страницу</h1>"],
         ["<h2>SQL</h2>"],
         ["<h2>RegEx</h2>"]],
    Regex = "(?i)<h[1-6]>.*?</h[1-6]>",
    {match, Result} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

hello_any_header_03(Text) ->
    Expected =
        [["<h1>Welcome to my Homepage</h1>"], ["<h2>SQL</h2>"], ["<h2>RegEx</h2>"]],
    Regex = "<h[1-6]>.*?</h[1-6]>",
    {match, Result} =
        re:run(Text, get_mp(Regex, [caseless]), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

hello_any_header_ru_03(Text) ->
    Expected =
        [["<h1>Добро пожаловать на мою домашнюю страницу</h1>"],
         ["<h2>SQL</h2>"],
         ["<h2>RegEx</h2>"]],
    Regex = "<h[1-6]>.*?</h[1-6]>",
    {match, Result} =
        re:run(Text,
               get_mp(Regex, [unicode, caseless]),
               [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

wrong_01(Text) ->
    Expected =
        [["<h1>Welcome to my Homepage</h1>"],
         ["<h2>ColdFusion</h2>"],
         ["<h2>Wireless</h2>"],
         ["<h2>This is not valid HTML</h3>"]],
    Regex = "<[hH][1-6]>.*?</[hH][1-6]>",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

wrong_ru_01(Text) ->
    Expected =
        [["<h1>Добро пожаловать на мою домашнюю страницу</h1>"],
         ["<h2>ColdFusion</h2>"],
         ["<h2>Радио</h2>"],
         ["<h2>Это неправильный (недопустимый) HTML-тег</h3>"]],
    Regex = "<[hH][1-6]>.*?</[hH][1-6]>",
    {match, Result} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

wrong_02(Text) ->
    Expected =
        [["<h1>Welcome to my Homepage</h1>"],
         ["<h2>ColdFusion</h2>"],
         ["<h2>Wireless</h2>"],
         ["<h2>This is not valid HTML</h3>"]],
    Regex = "(?i)<h[1-6]>.*?</h[1-6]>",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

wrong_ru_02(Text) ->
    Expected =
        [["<h1>Добро пожаловать на мою домашнюю страницу</h1>"],
         ["<h2>ColdFusion</h2>"],
         ["<h2>Радио</h2>"],
         ["<h2>Это неправильный (недопустимый) HTML-тег</h3>"]],
    Regex = "(?i)<h[1-6]>.*?</h[1-6]>",
    {match, Result} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

wrong_03(Text) ->
    Expected =
        [["<h1>Welcome to my Homepage</h1>"],
         ["<h2>ColdFusion</h2>"],
         ["<h2>Wireless</h2>"],
         ["<h2>This is not valid HTML</h3>"]],
    Regex = "<h[1-6]>.*?</h[1-6]>",
    {match, Result} =
        re:run(Text, get_mp(Regex, [caseless]), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

wrong_ru_03(Text) ->
    Expected =
        [["<h1>Добро пожаловать на мою домашнюю страницу</h1>"],
         ["<h2>ColdFusion</h2>"],
         ["<h2>Радио</h2>"],
         ["<h2>Это неправильный (недопустимый) HTML-тег</h3>"]],
    Regex = "<h[1-6]>.*?</h[1-6]>",
    {match, Result} =
        re:run(Text,
               get_mp(Regex, [unicode, caseless]),
               [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

-endif.
-endif.
