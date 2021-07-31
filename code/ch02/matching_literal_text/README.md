matching_literal_text
=====

## Create new project

----	
	
	# all commands in one string
	$ rebar3 new lib matching_literal_text
	
## Get dependencies
	$ rebar3 deps	

## Format
	$ rebar3 format
	
## EUnit
-----
	$ rebar3 eunit
	$ rebar3 eunit -m matching_literal_text_tests
	$ rebar3 eunit -m match_any_character_tests
	$ rebar3 eunit -m match_special_character_tests
	