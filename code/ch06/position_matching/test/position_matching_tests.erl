% For research For research mode, activate the RESEARCH constant.
% Active code page: 65001 - UTF-8 Encoding
% chcp 65001
-module(position_matching_tests).

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

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_file_ru_content(),
    Regex = "кот",
    Replacement = "собака",
    {ok, MP} = re:compile(Regex, [unicode]),
    Result = re:replace(Text, MP, Replacement, [global, {return, list}]),
    %?debugFmt("Result = ~p~n", [Result]).
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
     [fun research_ru_01/1, fun research_ru_02/1]}.

research_01(Text) ->
    Expected = [["cat"], ["cat"]],
    Regex = "cat",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

research_ru_01(Text) ->
    Expected = [["кот"], ["кот"]],
    Regex = "кот",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, Result} = re:run(Text, MP, [global, {capture, all, list}]),

    ?_assertEqual(Expected, Result).

research_02(Text) ->
    Expected = "The dog sdogtered his food all over the room.",
    Regex = "cat",
    Replacement = "dog",
    Result = re:replace(Text, Regex, Replacement, [global, {return, list}]),
    ?_assertEqual(Expected, Result).

research_ru_02(Text) ->
    Expected = "Барсик, это собака, собакаорый спал на кресле.",
    Regex = "кот",
    Replacement = "собака",
    {ok, MP} = re:compile(Regex, [unicode]),
    Result = re:replace(Text, MP, Replacement, [global, {return, list}]),

    ?_assertEqual(Expected, Result).

-endif.
-endif.
