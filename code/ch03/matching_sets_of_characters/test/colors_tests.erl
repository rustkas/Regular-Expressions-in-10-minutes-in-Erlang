% For research For research mode, activate the RESEARCH constant.
%
% Active code page: 65001 - UTF-8 Encoding
% chcp 65001

-module(colors_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

file_path(FileName) ->
    {ok, Dir} = file:get_cwd(),
    FullFileName = Dir ++ [$/] ++ FileName,
    FullFileName.

read_local_file(FileName) ->
    FullFileName = file_path(FileName),
    {ok, Binary} = file:read_file(FullFileName),
    String = unicode:characters_to_list(Binary, utf8),
    String.

read_colors() ->
    String = read_local_file("colors.css"),
    String.

-ifdef(RESEARCH).

replace_double_quotes(Text) ->
    %\x22
    re:replace(Text, "\"", "\\\\x22", [multiline, global, {return, list}]).

reasearch_test() ->
    Text =
        "<body \n\tbgcolor=\\x22#336633\\x22\n    color =\\x22#FFFFFF\\x22\n\tmargin-top=\\x220\\x22\n\tmargin-left=\\x220\\x22\n\t>\n\t",

    NewText = replace_double_quotes(Text),

    ?debugFmt("NewText = ~p~n", [NewText]).

-else.

color_01_test() ->
    Expected = [["#336633"], ["#FFFFFF"]],
    Text =
        "<body \n\tbgcolor=\\x22#336633\\x22\n    color =\\x22#FFFFFF\\x22\n\tmargin-top=\\x220\\x22\n\tmargin-left=\\x220\\x22\n\t>\n\t",
    Regex = "#[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]",
    MP = re_tuner:mp(Regex),

    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

color_02_test() ->
    Expected = [["#fefbd8"], ["#0000ff"], ["#d0f4e6"], ["#f08970"]],

    Text = read_colors(),
    Regex = "#[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]",
    MP = re_tuner:mp(Regex),

    {match, Captured} = re:run(Text, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?assertEqual(Expected, Result).

-endif.
-endif.
