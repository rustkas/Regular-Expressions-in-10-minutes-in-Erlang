introdusing_regex
=====

## Create new project

----	
	
	# all commands in one string
	$ rebar3 new lib introdusing_regex && cd ..
	
## Get dependencies
	$ rebar3 deps	
## Format
	$ rebar3 format
	
## EUnit
-----
	$ rebar3 eunit
	$ rebar3 eunit -m text_sequence_search_tests
	$ rebar3 eunit -m word_replace_tests
	$ rebar3 eunit -m replace_url_tests
	