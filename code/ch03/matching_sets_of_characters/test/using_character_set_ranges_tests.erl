% For research For research mode, activate the RESEARCH constant.
%
% Active code page: 65001 - UTF-8 Encoding
% chcp 65001

-module(using_character_set_ranges_tests).

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

-ifdef(RESEARCH).

reasearch_test() ->
    FileNameList = get_file_with_sam_names(),
    Regex = "[ns]a[0123456789]\.xls",
    {ok, MP} = re:compile(Regex),
    CapturedList = getCapturedList(MP, FileNameList),

    ?debugFmt("Captured = ~p~n", [CapturedList]),
    ?debugFmt("Length = ~p~n", [length(CapturedList)]).

        %?debugFmt("FileNameList = ~p~n", [FileNameList]).

-else.

explore_filenames_test_() ->
    {foreach,
     local,
     fun get_file_with_sam_names/0,
     [fun research_01/1, fun research_02/1]}.

get_mp(Regex) ->
    re_tuner:mp(Regex).

research_01(FileNameList) ->
    Expected = ["na1.xls", "na2.xls", "sa1.xls"],

    Regex = "[ns]a[0123456789]\.xls",
    {ok, MP} = re:compile(Regex),
    CapturedList = getCapturedList(MP, FileNameList),
    Result = CapturedList,
    ?_assertEqual(Expected, Result).

research_02(FileNameList) ->
    Expected = ["na1.xls", "na2.xls", "sa1.xls"],

    Regex = "[ns]a[0-9]\.xls",
    {ok, MP} = re:compile(Regex),
    CapturedList = getCapturedList(MP, FileNameList),
    Result = CapturedList,
    ?_assertEqual(Expected, Result).

% 0-9
research_numbers_test() ->
    List = lists:seq(0, 9),
    true =
        lists:all(fun(Elem) ->
                     ?assertException(error,
                                      badarg,
                                      re:run([Elem], get_mp("[9-0]"), [{capture, first, list}])),
                     true
                  end,
                  lists:reverse(List)).

% a-z
research_lower_letters_test() ->
    List = lists:seq($a, $z),
    true =
        lists:all(fun(Elem) ->
                     ?assertException(error,
                                      badarg,
                                      re:run([Elem], get_mp("[z-a]"), [{capture, first, list}])),
                     true
                  end,
                  lists:reverse(List)).

% A-Z
research_upper_letters_test() ->
    List = lists:seq($A, $Z),
    true =
        lists:all(fun(Elem) ->
                     ?assertException(error,
                                      badarg,
                                      re:run([Elem], get_mp("[Z-A]"), [{capture, first, list}])),
                     true
                  end,
                  lists:reverse(List)).

-endif.
-endif.
