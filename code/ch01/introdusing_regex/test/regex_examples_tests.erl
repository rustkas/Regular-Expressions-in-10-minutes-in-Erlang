% For research For research mode, activate the RESEARCH constant.
-module(regex_examples_tests).

-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

getRegexList() ->
    RegexList =
        ["Ben",
         ".",
         "www.forta.com",
         "[a-zA-Z0-9_.]",
         "<[Hh]1>.*</[Hh]1>",
         "\\r\\n\\r\\n",
         "\\d{3,3}-\\d{3,3}-\\d{4,4}"].

-ifdef(RESEARCH).

reasearch_test() ->
    Expected = true,
    RegexList = getRegexList(),

    Result =
        lists:all(fun(Elem) ->
                     Result = re:compile(Elem),
                     {ok, _} = Result,
                     true
                  end,
                  RegexList),

    %?debugFmt("Found! = ~p~n", [Result]).
    ?assertEqual(Expected, Result).

-else.

reasearch_test() ->
    Expected = true,
    RegexList = getRegexList(),

    Result =
        lists:all(fun(Elem) ->
                     Result = re:compile(Elem),
                     {ok, _} = Result,
                     true
                  end,
                  RegexList),

    ?assertEqual(Expected, Result).

-endif.
-endif.
