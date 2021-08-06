% For research For research mode, activate the RESEARCH constant.
%
% Active code page: 65001 - UTF-8 Encoding
% chcp 65001
-module(embedding_conditions_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_phone_numbers_content() ->
    String = read_local_file("data" ++ [$/] ++ "phone numbers.txt"),
    String.

get_nav_bar_content() ->
    String = read_local_file("data" ++ [$/] ++ "nav bar.txt"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_phone_numbers_content(),
    Regex = "(\\()?\\d{3}(?(1)\\)|-)\\d{3}-\\d",
    TunedRegex = re_tuner:replace(Regex),
    {match, Result} =
        re:run(Text, get_mp(TunedRegex), [global, {capture, first, list}]),
    ?debugFmt("Result = ~p~n", [Result]).

-else.

phone_numbers_test_() ->
    {foreach,
     local,
     fun get_phone_numbers_content/0,
     [fun phone_numbers_01/1, fun phone_numbers_02/1]}.

nav_bar_test_() ->
    {foreach,
     local,
     fun get_nav_bar_content/0,
     [fun nav_bar_01/1, fun nav_bar_02/1, fun nav_bar_03/1]}.

phone_numbers_01(Text) ->
    Expected =
        [["123-456-7890"], ["(123)456-7890"], ["(123)-456-7890"], ["(123-456-7890"]],

    Regex = "\\(?\\d{3}\\)?-?\\d{3}-\\d{4}",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

phone_numbers_02(Text) ->
    Expected =
        [["123-456-7"],["(123)456-7"],["123-456-7"]],

    Regex = "(\\()?\\d{3}(?(1)\\)|-)\\d{3}-\\d",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

nav_bar_01(Text) ->
    Expected =
        [["<a href=\"/home\"><img src=\"/images/home.gif\"></a>"],
         ["<img src=\"/images/spacer.gif\">"],
         ["<a href=\"/search\"><img src=\"/images/search.gif\"></a>"],
         ["<img src=\"/images/spacer.gif\">"],
         ["<a href=\"/help\"><img src=\"/images/help.gif\"></a>"]],
    Regex = "(<[Aa]\\s+[^>]+>\\s*)?<[Ii][Mm][Gg]\\s+[^>]+>(?(1)\\s*</[Aa]>)",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

nav_bar_02(Text) ->
    Expected =
        [["<a href=\"/home\"><img src=\"/images/home.gif\"></a>"],
         ["<img src=\"/images/spacer.gif\">"],
         ["<a href=\"/search\"><img src=\"/images/search.gif\"></a>"],
         ["<img src=\"/images/spacer.gif\">"],
         ["<a href=\"/help\"><img src=\"/images/help.gif\"></a>"]],
    Regex = "(?i)(<a\\s+[^>]+>\\s*)?<img\\s+[^>]+>(?(1)\\s*</a>)",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

nav_bar_03(Text) ->
    Expected =
        [["<a href=\"/home\"><img src=\"/images/home.gif\"></a>"],
         ["<img src=\"/images/spacer.gif\">"],
         ["<a href=\"/search\"><img src=\"/images/search.gif\"></a>"],
         ["<img src=\"/images/spacer.gif\">"],
         ["<a href=\"/help\"><img src=\"/images/help.gif\"></a>"]],
    Regex = "(<a\\s+[^>]+>\\s*)?<img\\s+[^>]+>(?(1)\\s*</a>)",
    {match, Result} =
        re:run(Text, get_mp(Regex, [caseless]), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

-endif.
-endif.
