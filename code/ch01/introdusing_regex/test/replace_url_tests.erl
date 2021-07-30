% For research For research mode, activate the RESEARCH constant.
-module(replace_url_tests).

-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

-ifdef(RESEARCH).



reasearch_test() ->
	Expected = "<a href=\"http://www.forta.com/\">http://www.forta.com/</a>",
    Text = "http://www.forta.com/",
	Regex = "http[s]?://[^;\s]*",
	TunedRegex = re_tuner:replace(Regex),
	{ok, MP} = re:compile(TunedRegex),
	
	Replacement =
        "<a href=\"&\">&</a>",

    Result = re:replace(Text, MP, Replacement, [{return, list}]),		
    
    %?debugFmt("Found! = ~ts~n", [Captured]).
	?assertEqual(Expected,Result).
	

-else.

reasearch_test() ->
    
	Expected = "<a href=\"http://www.forta.com/\">http://www.forta.com/</a>",
    Text = "http://www.forta.com/",
	Regex = "http[s]?://[^;\s]*",
	TunedRegex = re_tuner:replace(Regex),
	{ok, MP} = re:compile(TunedRegex),
	
	Replacement =
        "<a href=\"&\">&</a>",

    Result = re:replace(Text, MP, Replacement, [{return, list}]),		
	?assertEqual(Expected,Result).

-endif.
-endif.
