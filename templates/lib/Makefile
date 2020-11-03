LIB := ./lib/default.nix

.PHONY: repl
repl:
	nix repl $(LIB)

.PHONY: repl-with-args
repl-with-args:
	nix repl --arg userNames '[ "Oprah" "Jerry" "Phil" ]' $(LIB)
