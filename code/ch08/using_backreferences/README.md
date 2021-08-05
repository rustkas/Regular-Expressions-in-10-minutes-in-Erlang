using_backreferences
=====

## Create new project

----	
	
	# all commands in one string
	$ rebar3 new lib using_backreferences && cd using_backreferences
	
## Get dependencies
	$ rebar3 deps	

## Format
	$ rebar3 format
	
## EUnit
-----
	$ rebar3 eunit
	$ rebar3 eunit -m using_backreferences_tests
	$ rebar3 eunit -m matching_with_backreferences_tests
	$ rebar3 eunit -m performing_replace_operations_tests