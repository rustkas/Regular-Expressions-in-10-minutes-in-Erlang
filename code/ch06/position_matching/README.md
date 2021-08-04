position_matching
=====

## Create new project

----	
	
	# all commands in one string
	$ rebar3 new lib position_matching && cd position_matching
	
## Get dependencies
	$ rebar3 deps	

## Format
	$ rebar3 format
	
## EUnit
-----
	$ rebar3 eunit
	$ rebar3 eunit -m position_matching_tests
	$ rebar3 eunit -m using_word_boundaries_tests
	$ rebar3 eunit -m string_boundaries_tests