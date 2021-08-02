% For research For research mode, activate the RESEARCH constant.
%
% Active code page: 65001 - UTF-8 Encoding
% chcp 65001

-module(anything_but_matching_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

get_file_with_sam_names() ->
    get_file_names("files with sam").

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

get_mp(Regex) ->
    re_tuner:mp(Regex).

-ifdef(RESEARCH).

reasearch_test() ->
    FileNameList = get_file_with_sam_names(),
    Regex = "[ns]a[^0-9]\.xls",
    MP = get_mp(Regex),
    CapturedList = getCapturedList(MP, FileNameList),

    ?debugFmt("Captured = ~p~n", [CapturedList]),
    ?debugFmt("Length = ~p~n", [length(CapturedList)]).

        %?debugFmt("FileNameList = ~p~n", [FileNameList]).

-else.

explore_filenames_test_() ->
    {foreach,
     local,
     fun get_file_with_sam_names/0,
     [fun research_01/1]}.



research_01(FileNameList) ->
    Expected = ["sam.xls"],

    Regex = "[ns]a[^0-9]\.xls",
    MP = get_mp(Regex),
    CapturedList = getCapturedList(MP, FileNameList),
    Result = CapturedList,
    ?_assertEqual(Expected, Result).




-endif.
-endif.
