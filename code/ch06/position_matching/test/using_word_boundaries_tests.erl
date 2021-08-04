% For research For research mode, activate the RESEARCH constant.
% Active code page: 65001 - UTF-8 Encoding
% chcp 65001
-module(using_word_boundaries_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_file_content() ->
    String = read_local_file("data" ++ [$/] ++ "cat text.txt"),
    String.

get_file_ru_content() ->
    String = read_local_file("data" ++ [$/] ++ "cat text ru.txt"),
    String.

get_captain_file_content() ->
    String = read_local_file("data" ++ [$/] ++ "captain.txt"),
    String.

get_info_file_content() ->
    String = read_local_file("data" ++ [$/] ++ "info text.txt"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_info_file_content(),
    Regex = "\\B-\\B",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?debugFmt("Result = ~p~n", [Result]).

reasearch_ru_test0() ->
    Text = get_file_ru_content(),
    Regex = "\\bкот\\b",
    {ok, MP} = re:compile(Regex, [unicode, ucp]),
    {match, Result} = re:run(Text, MP, [global, {capture, all, list}]),
    ?debugFmt("Result = ~ts~n", [Result]).

-else.

reasearch_test_() ->
    {foreach,
     local,
     fun get_file_content/0,
     [fun research_01/1, fun research_02/1]}.

reasearch_ru_test_() ->
    {foreach,
     local,
     fun get_file_ru_content/0,
     [fun research_ru_01/1,
      fun research_ru_02/1,
      fun research_ru_03/1,
      fun research_ru_04/1]}.

reasearch_captain_test_() ->
    {foreach,
     local,
     fun get_captain_file_content/0,
     [fun research_captain_01/1, fun research_captain_02/1]}.

research_01(Text) ->
    Expected = [["cat"]],
    Regex = "\\bcat\\b",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

research_ru_01(Text) ->
    Expected = [["кот"]],
    Regex = "\\bкот\\b",
    {ok, MP} = re:compile(Regex, [unicode, ucp]),
    {match, Result} = re:run(Text, MP, [global, {capture, all, list}]),

    ?_assertEqual(Expected, Result).

research_02(Text) ->
    Expected = "The dog sdogtered his food all over the room.",
    Regex = "cat",
    Replacement = "dog",
    Result = re:replace(Text, Regex, Replacement, [global, {return, list}]),
    ?_assertEqual(Expected, Result).

research_ru_02(Text) ->
    Expected =
        "Барсик, это собака, собакаорый спал на кресле. Он объявил бойсобака.",
    Regex = "кот",
    Replacement = "собака",
    {ok, MP} = re:compile(Regex, [unicode]),
    Result = re:replace(Text, MP, Replacement, [global, {return, list}]),
    ?_assertEqual(Expected, Result).

research_captain_01(Text) ->
    Expected = [["cap"], ["cap"], ["cap"], ["cap"]],
    Regex = "\\bcap",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

research_ru_03(Text) ->
    Expected = [["кот"], ["кот"]],
    Regex = "\\bкот",
    {ok, MP} = re:compile(Regex, [unicode, ucp]),
    {match, Result} = re:run(Text, MP, [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

research_captain_02(Text) ->
    Expected = [["cap"], ["cap"]],
    Regex = "cap\\b",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

research_ru_04(Text) ->
    Expected = [["кот"], ["кот"]],
    Regex = "кот\\b",
    {ok, MP} = re:compile(Regex, [unicode, ucp]),
    {match, Result} = re:run(Text, MP, [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

research_info_test() ->
    Text = get_info_file_content(),
    Expected = [["-"]],
    Regex = "\\B-\\B",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

-endif.
-endif.
