% For research For research mode, activate the RESEARCH constant.
-module(matching_zero_or_more_characters_tests).

-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_text_with_links_content() ->
    String = read_local_file("data" ++ [$/] ++ "text with links.txt"),
    String.

get_text_with_links_ru_content() ->
    String = read_local_file("data" ++ [$/] ++ "text with links ru.txt"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = "Hello .ben@forta.com is my email address.",
    Regex = "\\w+[\\w.]*@[\\w.]+\\.\\w+",
    RunString = re:run(Text, get_mp(Regex), [{capture, first, list}]),
    ?debugFmt("Result = ~p~n",
              [RunString]).        %{match, [[Captured]]} = RunString,

    %Result = Captured,
    %?debugFmt("Result = ~p~n", [Result]).

-else.

reasearch_01_test() ->
    Expected = "http://www.forta.com/",
    Text = get_text_with_links_content(),
    Regex = "http://[\\w./]+",
    RunString = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    {match, [[Captured]]} = RunString,
    Result = Captured,
    ?assertEqual(Expected, Result).

reasearch_01_ru_test() ->
    Expected = "http://www.forta.com/",
    Text = get_text_with_links_ru_content(),
    Regex = "http://[\\w./]+",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, [[Captured]]} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

reasearch_02_test() ->
    Expected = [["http://www.forta.com/"], ["https://www.forta.com/."]],
    Text = get_text_with_links_content(),
    Regex = "https?://[\\w./]+",
    RunString = re:run(Text, get_mp(Regex), [global, {capture, all, list}]),
    {match, Captured} = RunString,
    Result = Captured,
    ?assertEqual(Expected, Result).

reasearch_02_ru_test() ->
    Expected = [["http://www.forta.com/"], ["https://www.forta.com/."]],
    Text = get_text_with_links_ru_content(),
    Regex = "https?://[\\w./]+",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

research_03_test() ->
    Expected = "ben@forta.com is",
    Text = "Hello .ben@forta.com is my email address.",
    Regex = "\\w+[\\w.]*@[\\w.]+\\.\\w+",
    {match, Captured} = re:run(Text, get_mp(Regex), [{capture, first, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

-endif.
-endif.
