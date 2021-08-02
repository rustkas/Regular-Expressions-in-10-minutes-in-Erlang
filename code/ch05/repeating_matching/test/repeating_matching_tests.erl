% For research For research mode, activate the RESEARCH constant.
-module(repeating_matching_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_file_content() ->
    String = read_local_file("data" ++ [$/] ++ "emails.txt"),
    String.

get_text_wiht_emails() ->
    String = read_local_file("data" ++ [$/] ++ "text with emails.txt"),
    String.

get_text_wiht_emails_ru() ->
    String = read_local_file("data" ++ [$/] ++ "text with emails ru.txt"),
    String.

get_text_wiht_emails2() ->
    String = read_local_file("data" ++ [$/] ++ "text with emails2.txt"),
    String.

get_text_wiht_emails_ru2() ->
    String = read_local_file("data" ++ [$/] ++ "text with emails ru2.txt"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_text_wiht_emails2(),
    Regex = "\\w+@\\w+\\.\\w+",

    Result = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?debugFmt("Result = ~p~n", [Result]).

-else.

reasearch_01_test() ->
    Expected = nomatch,
    Text = "text@text.text",
    Regex = "\\w@\\w\\.\\w",
    Result = re:run(Text, get_mp(Regex), [{capture, first, list}]),
    ?assertEqual(Expected, Result).

reasearch_02_test() ->
    Expected = "a@b.c",
    Text = Expected,
    Regex = "\\w@\\w\\.\\w",
    {match, [Captured]} = re:run(Text, get_mp(Regex), [{capture, first, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

research_03_test() ->
    Expected = [["a"], ["aaaa"], ["aaa"], ["aa"]],
    Text = "a aaaa aaa aa",
    Regex = "a+",
    {match, Captured} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

research_04_test() ->
    Expected = [["ben@forta.com"], ["support@forta.com"], ["spam@forta.com"]],
    Text = get_text_wiht_emails(),
    Regex = "\\w+@\\w+\\.\\w+",
    {match, Captured} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

research_05_ru_test() ->
    Expected = [["ben@forta.com"], ["support@forta.com"], ["spam@forta.com"]],
    Text = get_text_wiht_emails(),
    Regex = "\\w+@\\w+\\.\\w+",
    {match, Captured} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

research_06_test() ->
    Expected =
        [["ben@forta.com"],
         ["forta@forta.com"],
         ["support@forta.com"],
         ["ben@urgent.forta"],
         ["spam@forta.com"]],
    Text = get_text_wiht_emails2(),
    Regex = "\\w+@\\w+\\.\\w+",
    {match, Captured} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

research_06_ru_test() ->
    Expected =
        [["ben@forta.com"],
         ["forta@forta.com"],
         ["support@forta.com"],
         ["ben@urgent.forta"],
         ["spam@forta.com"]],
    Text = get_text_wiht_emails_ru2(),
    Regex = "\\w+@\\w+\\.\\w+",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

research_07_test() ->
    Expected =
        [["ben@forta.com"],
         ["ben.forta@forta.com"],
         ["support@forta.com"],
         ["ben@urgent.forta.com"],
         ["spam@forta.com"]],
    Text = get_text_wiht_emails2(),
    Regex = "[\\w.]+@[\\w.]+\\.\\w+",
    {match, Captured} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

research_07_ru_test() ->
    Expected =
        [["ben@forta.com"],
         ["ben.forta@forta.com"],
         ["support@forta.com"],
         ["ben@urgent.forta.com"],
         ["spam@forta.com"]],
    Text = get_text_wiht_emails_ru2(),
    Regex = "[\\w.]+@[\\w.]+\\.\\w+",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

research_08_test() ->
    Expected =
        [["ben@forta.com"],
         ["ben.forta@forta.com"],
         ["support@forta.com"],
         ["ben@urgent.forta.com"],
         ["spam@forta.com"]],
    Text = get_text_wiht_emails2(),
    Regex = "[\\w\\.]+@[\\w\\.]+\\.\\w+",
    {match, Captured} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

research_08_ru_test() ->
    Expected =
        [["ben@forta.com"],
         ["ben.forta@forta.com"],
         ["support@forta.com"],
         ["ben@urgent.forta.com"],
         ["spam@forta.com"]],
    Text = get_text_wiht_emails_ru2(),
    Regex = "[\\w\\.]+@[\\w\\.]+\\.\\w+",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

-endif.
-endif.
