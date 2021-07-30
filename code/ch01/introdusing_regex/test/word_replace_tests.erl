% For research For research mode, activate the RESEARCH constant.
-module(word_replace_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

get_text() ->
    Text = "“Their size.” “Their size and weight.” “Their size, for sure.” “They are huge.” “Their size, and the fact that they have brains.” The Google results for “whale phobia” kept me busy for hours.",
	%Text ="size",
    Text.

-ifdef(RESEARCH).



reasearch_test() ->
    % Active code page: 65001 - UTF-8 Encoding
	% chcp 65001 
	
	BuildRegex = fun(Elem)-> "\\b"++ Elem ++"\\b" end,
    Text = get_text(),
    Regex = BuildRegex("size"),
    Replacement = "iSize",
    NewText = re:replace(Text, Regex, "iSize",[unicode, global, {return, list}]),
	
	%?debugFmt("NewText = ~ts~n", [NewText]),
	CheckRegex = BuildRegex(Replacement),
	{ok, MP} = re:compile(CheckRegex,[unicode]),
	{match, Captured} = re:run(NewText, MP, [ global, {capture, all, list}]),
	Length = length(Captured),
	Result = Length,
	Expected = 4,
    %?debugFmt("Found! = ~ts~n", [Captured]).
	?assertEqual(Expected,Result).
	

-else.

reasearch_test() ->
    
	BuildRegex = fun(Elem)-> "\\b"++ Elem ++"\\b" end,
    Text = get_text(),
    Regex = BuildRegex("size"),
    Replacement = "iSize",
    NewText = re:replace(Text, Regex, "iSize",[unicode, global, {return, list}]),
	
	CheckRegex = BuildRegex(Replacement),
	{ok, MP} = re:compile(CheckRegex,[unicode]),
	{match, Captured} = re:run(NewText, MP, [ global, {capture, all, list}]),
	Length = length(Captured),
	Result = Length,
	Expected = 4,
	?assertEqual(Expected,Result).

-endif.
-endif.
