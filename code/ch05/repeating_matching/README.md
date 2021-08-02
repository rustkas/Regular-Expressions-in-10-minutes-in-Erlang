repeating_matching
=====

## Create new project

----	
	
	# all commands in one string
	$ rebar3 new lib repeating_matching && cd repeating_matching
	
## Get dependencies
	$ rebar3 deps	

## Format
	$ rebar3 format
	
## EUnit
-----
	$ rebar3 eunit
	$ rebar3 eunit -m repeating_matching_tests
	$ rebar3 eunit -m matching_zero_or_more_characters_tests
	$ rebar3 eunit -m matching_whitespace_characters_tests
	$ rebar3 eunit -m exact_interval_matching_tests
	$ rebar3 eunit -m range_interval_matching_tests
	$ rebar3 eunit -m at_least_interval_matching_tests
	$ rebar3 eunit -m preventing_over_matching_tests