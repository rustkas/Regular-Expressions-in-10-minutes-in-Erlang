% For research For research mode, activate the RESEARCH constant.
-module(matching_whitespace_characters_tests).

-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_csv_content() ->
    String = read_local_file("data" ++ [$/] ++ "data.csv"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_csv_content(),
    ?debugFmt("Text = ~p~n", [Text]),
    Regex = "[\\r]?\\n[\\r]?\\n",

    Result =
        re:replace(Text, Regex, "", [extended, multiline, global, {return, list}]),

    {ok, Dir} = file:get_cwd(),
    FullFileName = Dir ++ [$/] ++ "data" ++ [$/] ++ "new data.csv",

    file:write_file(FullFileName, Result).

-else.

explore_filenames_test_() ->
    {foreach, local, fun get_csv_content/0, [fun research_01/1]}.

research_01(Text) ->
    Expected =
        "\"101\",\"Ben\",\"Forta\"\n\"102\",\"Jim\",\"James\"\n\"103\",\"Roberta\",\"Robertson\"\n\"104\",\"Bob\",\"Bobson\"",
    Regex = "^\\s+|\\s+$",
    TunedRegex = re_tuner:replace(Regex),
    Result =
        re:replace(Text, TunedRegex, "", [extended, multiline, global, {return, list}]),
    ?_assertEqual(Expected, Result).

-endif.
-endif.
