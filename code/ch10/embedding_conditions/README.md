embedding_conditions
=====

## Create new project

----	
	
	# all commands in one string
	$ rebar3 new lib embedding_conditions && cd embedding_conditions
	
## Get dependencies
	$ rebar3 deps	

## Format
	$ rebar3 format
	
## EUnit
-----
	$ rebar3 eunit
	$ rebar3 eunit -m embedding_conditions_tests
	$ rebar3 eunit -m lookaround_conditions_tests