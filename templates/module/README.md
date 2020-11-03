# Usage

```
$ nix repl

nix-repl> f = (builtins.getFlake (toString ./.))
nix-repl> f.nixosModules.simple.options.roles.demo.enable
```
