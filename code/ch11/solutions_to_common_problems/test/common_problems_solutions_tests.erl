% For research For research mode, activate the RESEARCH constant.
%
-module(common_problems_solutions_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

get_north_american_phone_numbers_content() ->
    String = read_local_file("data" ++ [$/] ++ "North American Phone Numbers.txt"),
    String.

get_north_american_phone_numbers2_content() ->
    String = read_local_file("data" ++ [$/] ++ "North American Phone Numbers2.txt"),
    String.

get_us_zip_codes_content() ->
    String = read_local_file("data" ++ [$/] ++ "U.S. ZIP Codes.txt"),
    String.

get_canadian_postal_codes_content() ->
    String = read_local_file("data" ++ [$/] ++ "Canadian Postal Codes.txt"),
    String.

get_uk_postcodes_content() ->
    String = read_local_file("data" ++ [$/] ++ "United Kingdom Postcodes.txt"),
    String.

get_ip_addresses_content() ->
    String = read_local_file("data" ++ [$/] ++ "IP Addresses.txt"),
    String.

get_us_ssn_content() ->
    String = read_local_file("data" ++ [$/] ++ "U.S. Social Security Numbers.txt"),
    String.

get_urls_content() ->
    String = read_local_file("data" ++ [$/] ++ "URLs.txt"),
    String.

get_complite_urls_content() ->
    String = read_local_file("data" ++ [$/] ++ "Complete URLs.txt"),
    String.

get_email_addresses_content() ->
    String = read_local_file("data" ++ [$/] ++ "Email Addresses.txt"),
    String.

get_html_comments_content() ->
    String = read_local_file("data" ++ [$/] ++ "HTML Comments.txt"),
    String.

get_javascript_comments_content() ->
    String = read_local_file("data" ++ [$/] ++ "JavaScript Comments.txt"),
    String.

get_creadit_card_numbers_content() ->
    String = read_local_file("data" ++ [$/] ++ "Credit Card Numbers.txt"),
    String.

-ifdef(RESEARCH).

reasearch_test() ->
    Text = get_creadit_card_numbers_content(),
    Regex =
        "5[1-5]\\d{14}|4\\d{12}(\\d{3})?|3[47]\\d{13}|6011\\d{14}|(30[0-5]|36\\d|38\\d)\\d{11}",
    TunedRegex = re_tuner:replace(Regex),
    {match, Result} =
        re:run(Text, get_mp(TunedRegex), [global, {capture, first, list}]),
    ?debugFmt("Result = ~p~n", [Result]).

-else.

north_american_phone_numbers_01_test() ->
    Expected = [["248-555-1234"], ["(313) 555-1234"], ["(810)555-1234"]],
    Text = get_north_american_phone_numbers_content(),
    Regex = "\\(?[2-9]\\d\\d\\)?[ -]?[2-9]\\d\\d-\\d{4}",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

north_american_phone_numbers_02_test() ->
    Expected =
        [["248-555-1234"], ["(313) 555-1234"], ["(810)555-1234"], ["734.555.9999"]],

    Text = get_north_american_phone_numbers2_content(),
    Regex = "[(]?[2-9]\\d\\d[).]?[ -]?[2-9]\\d\\d[-.]\\d{4}",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

us_zip_codes_test() ->
    Expected = [["11222"], ["48034-1234"]],

    Text = get_us_zip_codes_content(),
    Regex = "\\d{5}(-\\d{4})?",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

canadian_postal_codes_test() ->
    Expected = [["M1A 1A1"], ["H9Z 9Z9"]],

    Text = get_canadian_postal_codes_content(),
    Regex = "[ABCEGHJKLMNPRSTVXY]\\d[A-Z] \\d[A-Z]\\d",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

uk_postcodes_test() ->
    Expected = [["N16 6P"], ["P01 3A"], ["NW11 8A"]],

    Text = get_uk_postcodes_content(),
    Regex = "[A-Z]{1,2}\\d[A-Z\\d]? \\d[ABD-HJLNP-UW-Z]",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),

    ?assertEqual(Expected, Result).

us_ssn_test() ->
    Expected = [["123-45-6"]],

    Text = get_us_ssn_content(),
    Regex = "\\d{3}-\\d{2}-\\d",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

ip_addresses_test() ->
    Expected = [["127.0.0.1"]],

    Text = get_ip_addresses_content(),
    Regex =
        "(((25[0-5])|(2[0-4]\\d)|(1\\d{2})|(\\d{1,2}))\\.){3}(((25[0-5])|(2[0-4]\\d)|(1\\d{2})|(\\d{1,2})))",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

urls_test() ->
    Expected =
        [["http://www.forta.com/blog"],
         ["https://www.forta.com:80/blog/index.cfm"],
         ["http://www.forta.com"],
         ["http://ben"],
         ["http://localhost/index.php"],
         ["http://localhost:8500/"]],

    Text = get_urls_content(),
    Regex = "https?://[-\\w.]+(:\\d+)?(/([\\w/.]*)?)?",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

complite_urls_test() ->
    Expected =
        [["http://www.forta.com/blog"],
         ["https://www.forta.com:80/blog/index.cfm"],
         ["http://www.forta.com"],
         ["http://ben:password@www.forta.com/"],
         ["http://localhost/index.php?ab=1&c=2"],
         ["http://localhost:8500/"]],

    Text = get_complite_urls_content(),
    Regex = "https?://(\\w*:\\w*@)?[-\\w.]+(:\\d+)?(/([\\w/_.]*(\\?\\S+)?)?)?",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

html_comments_test() ->
    Expected =
        [["<!-- Start of page -->"],
         ["<!-- Start of head -->"],
         ["<!-- Page title -->"],
         ["<!-- Body -->"]],

    Text = get_html_comments_content(),
    Regex = "<!-{2,}.*?-{2,}>",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

javascript_comments_test() ->
    Expected =
        [["// Turn off fields used only by replace\r"],
         ["// Turn on fields used only by replace\r"]],

    Text = get_javascript_comments_content(),
    Regex = "//.*",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

credit_card_test_() ->
    {foreach,
     local,
     fun get_creadit_card_numbers_content/0,
     [fun credit_card_mastercard/1,
      fun credit_card_visa/1,
      fun credit_card_american_express/1,
      fun credit_card_discover/1,
      fun credit_diners_club/1,
      fun credit_cards/1]}.

% Mastercard
credit_card_mastercard(Text) ->
    Expected = [["5212345678901234"]],
    Regex = "5[1-5]\\d{14}",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

% Visa
credit_card_visa(Text) ->
    Expected = [["4123456789012"], ["4123456789012345"]],
    Regex = "4\\d{12}(\\d{3})?",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

% American Express
credit_card_american_express(Text) ->
    Expected = [["371234567890123"]],
    Regex = "3[47]\\d{13}",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

% Discover
credit_card_discover(Text) ->
    Expected = [["601112345678901234"]],
    Regex = "6011\\d{14}",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

% Diners Club
credit_diners_club(Text) ->
    Expected = [["38812345678901"]],
    Regex = "(30[0-5]|36\\d|38\\d)\\d{11}",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

% All card types
credit_cards(Text) ->
    Expected =
        [["5212345678901234"],
         ["4123456789012"],
         ["4123456789012345"],
         ["371234567890123"],
         ["601112345678901234"],
         ["38812345678901"]],
    Regex =
        "5[1-5]\\d{14}|4\\d{12}(\\d{3})?|3[47]\\d{13}|6011\\d{14}|(30[0-5]|36\\d|38\\d)\\d{11}",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?_assertEqual(Expected, Result).

-endif.
-endif.
