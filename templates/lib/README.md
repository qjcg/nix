# lib

## Usage

```
$ nix repl

nix-repl> f = (builtins.getFlake (toString ./.))
nix-repl> :p f.lib.functions.users
```
