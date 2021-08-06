% For research For research mode, activate the RESEARCH constant.
%
% Active code page: 65001 - UTF-8 Encoding
% chcp 65001
-module(lookaround_conditions_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_zip_codes_content() ->
    String = read_local_file("data" ++ [$/] ++ "zip codes.txt"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_phone_numbers_content(),
    Regex = "\\d{5}(-\\d{4})?",
    TunedRegex = re_tuner:replace(Regex),
    {match, Result} =
        re:run(Text, get_mp(TunedRegex), [global, {capture, first, list}]),
    ?debugFmt("Result = ~p~n", [Result]).

-else.

zip_codes_test_() ->
    {foreach,
     local,
     fun get_zip_codes_content/0,
     [
	 fun zip_codes_01/1,
	 fun zip_codes_02/1
	 ]}.

zip_codes_01(Text) ->
    Expected =
        [["11111"],["22222"],["33333"],["44444-4444"]],

    Regex = "\\d{5}(-\\d{4})?",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

zip_codes_02(Text) ->
    Expected =
        [["11111"],["22222"],["44444-4444"]],

    Regex = "\\d{5}(?(?=-)-\\d{4})",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).
	
-endif.
-endif.
