% For research For research mode, activate the RESEARCH constant.
%
% Active code page: 65001 - UTF-8 Encoding
% chcp 65001

-module(matching_sets_of_characters_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

get_file_names() ->
    get_file_names("files").

get_usa_file_names() ->
    get_file_names("files with usa").

get_file_names(Dir) ->
    case file:list_dir(Dir) of
        {ok, Filenames} ->
            Filenames;
        {error, Reson} ->
            ?debugFmt("Error: ~p~n", [Reson])
    end.

getCapturedList(MP, List) ->
    ResultList =
        lists:foldl(fun(Text, Acc) ->
                       case re:run(Text, MP, [{capture, first, list}]) of
                           {match, [CapturedFileName]} ->
                               [CapturedFileName | Acc];
                           nomatch ->
                               Acc
                       end
                    end,
                    [],
                    List),

    case ResultList of
        nomatch ->
            nomatch;
        ResultList ->
            lists:sort(ResultList)
    end.

en() ->
    "The phrase \"regular expression\" is often abbreviated as RegEx or regex.".

ru() ->
    "Фраза “regular expression” часто сокращается как RegEx или regex.".

-ifdef(RESEARCH).

reasearch_test() ->
    FileNameList = get_file_names(),
    ?debugFmt("FileNameList = ~p~n", [FileNameList]).

-else.

explore_filenames_test_() ->
    {foreach,
     local,
     fun get_file_names/0,
     [fun research_01/1, fun research_02/1, fun research_03/1, fun research_04/1]}.

explore_usa_filenames_test_() ->
    {foreach,
     local,
     fun get_usa_file_names/0,
     [fun research_usa_01/1, fun research_usa_02/1]}.

research_01(FileNameList) ->
    Expected = ["ca1.xls", "na1.xls", "na2.xls", "sa1.xls"],

    Regex = ".a.\.xls",
    {ok, MP} = re:compile(Regex),
    CapturedList = getCapturedList(MP, FileNameList),
    Result = CapturedList,
    ?_assertEqual(Expected, Result).

research_02(FileNameList) ->
    Expected = 4,

    Regex = ".a.\.xls",
    {ok, MP} = re:compile(Regex),
    CapturedList = getCapturedList(MP, FileNameList),
    Result = length(CapturedList),
    ?_assertEqual(Expected, Result).

research_03(FileNameList) ->
    Expected = ["na1.xls", "na2.xls", "sa1.xls"],

    Regex = "[ns]a.\.xls",
    {ok, MP} = re:compile(Regex),
    CapturedList = getCapturedList(MP, FileNameList),
    Result = CapturedList,
    ?_assertEqual(Expected, Result).

research_04(FileNameList) ->
    Expected = 3,

    Regex = "[ns]a.\.xls",
    {ok, MP} = re:compile(Regex),
    CapturedList = getCapturedList(MP, FileNameList),
    Result = length(CapturedList),
    ?_assertEqual(Expected, Result).

research_usa_01(FileNameList) ->
    Expected = ["na1.xls", "na2.xls", "sa1.xls", "sa1.xls"],

    Regex = "[ns]a.\.xls",
    {ok, MP} = re:compile(Regex),
    CapturedList = getCapturedList(MP, FileNameList),
    Result = CapturedList,
    ?_assertEqual(Expected, Result).

research_usa_02(FileNameList) ->
    Expected = 4,

    Regex = "[ns]a.\.xls",
    {ok, MP} = re:compile(Regex),
    CapturedList = getCapturedList(MP, FileNameList),
    Result = length(CapturedList),
    ?_assertEqual(Expected, Result).

en_prase_01_test() ->
    Expected = ["RegEx", "regex"],
    Regex = "[Rr]eg[Ee]x",
    {ok, MP} = re:compile(Regex),
    Text = en(),
    {match, Captured} = re:run(Text, MP, [{capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

ru_prase_01_test() ->
    Expected = ["RegEx", "regex"],
    Regex = "[Rr]eg[Ee]x",
    {ok, MP} = re:compile(Regex, [unicode]),
    Text = en(),
    {match, Captured} = re:run(Text, MP, [{capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

-endif.
-endif.
