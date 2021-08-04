using_subexpressions
=====

## Create new project

----	
	
	# all commands in one string
	$ rebar3 new lib using_subexpressions && cd using_subexpressions
	
## Get dependencies
	$ rebar3 deps	

## Format
	$ rebar3 format
	
## EUnit
-----
	$ rebar3 eunit
	$ rebar3 eunit -m using_subexpressions_tests
	$ rebar3 eunit -m nesting_subexpressions_tests