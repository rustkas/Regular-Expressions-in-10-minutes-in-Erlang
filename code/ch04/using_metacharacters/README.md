using_metacharacters
=====

## Create new project

----	
	
	# all commands in one string
	$ rebar3 new lib matching_sets_of_characters && cd matching_sets_of_characters
	
## Get dependencies
	$ rebar3 deps	

## Format
	$ rebar3 format
	
## EUnit
-----
	$ rebar3 eunit
	$ rebar3 eunit -m using_metacharacters_tests
	$ rebar3 eunit -m matching_whitespace_characters_tests
	$ rebar3 eunit -m matching_digits_tests
	$ rebar3 eunit -m matching_alphanumeric_characters_tests
	$ rebar3 eunit -m matching_posix_tests