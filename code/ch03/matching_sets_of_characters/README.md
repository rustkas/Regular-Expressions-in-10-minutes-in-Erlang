matching_sets_of_characters
=====

## Create new project

----	
	
	# all commands in one string
	$ rebar3 new lib matching_sets_of_characters
	
## Get dependencies
	$ rebar3 deps	

## Format
	$ rebar3 format
	
## EUnit
-----
	$ rebar3 eunit
	$ rebar3 eunit -m matching_sets_of_characters_tests
	$ rebar3 eunit -m using_character_set_ranges_tests
	$ rebar3 eunit -m colors_tests
	$ rebar3 eunit -m anything_but_matching_tests