% For research For research mode, activate the RESEARCH constant.
%
% Active code page: 65001 - UTF-8 Encoding
% chcp 65001
-module(performing_replace_operations_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_message_content() ->
    String = read_local_file("data" ++ [$/] ++ "message.txt"),
    String.

get_message_ru_content() ->
    String = read_local_file("data" ++ [$/] ++ "message ru.txt"),
    String.

get_phone_numbers_content() ->
    String = read_local_file("data" ++ [$/] ++ "phone numbers.txt"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_phone_numbers_content(),
    Regex = "(\\d{3})(-)(\\d{3})(-)(\\d{4})",
    Replacement = "(\\1) \\3-\\5",
    Result = re:replace(Text, get_mp(Regex), Replacement, [global, {return, list}]),
    ?debugFmt("Result = ~p~n", [Result]).

reasearch_ru_test0() ->
    Text = get_message_ru_content(),
    Regex = "(\\w+[\\w\\.]*@[\\w\\.]+\\.\\w+)",
    Replacement = "<a href=\"mailto:\\1\">\\1</a>",
    Result =
        re:replace(Text,
                   get_mp(Regex, [ucp, unicode]),
                   Replacement,
                   [global, {return, list}]),
    ?debugFmt("Result = ~ts~n", [Result]).

-else.

search_email_test() ->
    Expected = "ben@forta.com",
    Text = get_message_content(),
    Regex = "\\w+[\\w\\.]*@[\\w\\.]+\\.\\w+",
    {match, [[Result]]} =
        re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

search_email_ru_test() ->
    Expected = "ben@forta.com",
    Text = get_message_ru_content(),
    Regex = "\\w+[\\w\\.]*@[\\w\\.]+\\.\\w+",
    {match, [[Result]]} =
        re:run(Text, get_mp(Regex, [ucp, unicode]), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

make_a_tag_test() ->
    Expected =
        "Hello, <a href=\"mailto:ben@forta.com\">ben@forta.com</a> is my email address.",

    Text = get_message_content(),
    Regex = "(\\w+[\\w\\.]*@[\\w\\.]+\\.\\w+)",
    Replacement = "<a href=\"mailto:\\1\">\\1</a>",
    Result = re:replace(Text, Regex, Replacement, [global, {return, list}]),
    ?_assertEqual(Expected, Result).

make_a_tag_ru_test() ->
    Expected =
        "Привет, <a href=\"mailto:ben@forta.com\">ben@forta.com</a> - мой адрес электронной почты.",

    Text = get_message_content(),
    Regex = "(\\w+[\\w\\.]*@[\\w\\.]+\\.\\w+)",
    Replacement = "<a href=\"mailto:\\1\">\\1</a>",
    Result = re:replace(Text, Regex, Replacement, [global, {return, list}]),
    ?_assertEqual(Expected, Result).

phone_numbers_test() ->
    Expected = "(313) 555-1234\r\n(248) 555-9999\r\n(810) 555-9000",

    Text = get_phone_numbers_content(),
    Regex = "(\\d{3})(-)(\\d{3})(-)(\\d{4})",
    Replacement = "(\\1) \\3-\\5",
    Result = re:replace(Text, Regex, Replacement, [global, {return, list}]),
    ?_assertEqual(Expected, Result).

-endif.
-endif.
