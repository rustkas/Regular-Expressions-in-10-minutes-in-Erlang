looking_ahead_and_behind
=====

## Create new project

----	
	
	# all commands in one string
	$ rebar3 new lib looking_ahead_and_behind && cd looking_ahead_and_behind
	
## Get dependencies
	$ rebar3 deps	

## Format
	$ rebar3 format
	
## EUnit
-----
	$ rebar3 eunit
	$ rebar3 eunit -m lookaround_tests
	$ rebar3 eunit -m looking_ahead_tests
	$ rebar3 eunit -m looking_behind_tests
	$ rebar3 eunit -m combining_lookahead_and_lookbehind_tests
	$ rebar3 eunit -m negating_lookaround_tests
