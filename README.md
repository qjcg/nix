# nix-config

My personal [nix] configuration.


# Features

- Uses [home-manager] to manage user settings
- Per-machine configurations with common core
- Templating via the [nix expression language](https://nixos.org/nix/manual/#ch-expression-language)
- Secure secret storage via [GPG](https://gnupg.org) (TODO: elaborate on this!)
- Multi-platform (NixOS, Ubuntu, macOS)


# Use

```sh
# Install the nix package manager.
curl https://nixos.org/nix/install | sh

# Clone this repo.
mkdir -p ~/.config
git clone https://github.com/qjcg/nix-home ~/.config/nixpkgs

# Install the mac environment.
nix-env -i env-mac
```


# Layout

```
.
├── README.md   - this README file
├── config.nix  - nix configuration
├── files/      - application files and templates
├── home.nix    - home-manager configuration
├── machines/   - per-machine configuration
├── nixops/     - nixops configurations
├── overlays/   - overlay packages and environments
└── secrets.nix - secrets file (to add locally, not stored in repo)
```


# TODO

- [ ] Add NixOS system configuration(s)
- [ ] Consider adding custom [NixOS modules](https://nixos.org/nixos/manual/index.html#sec-writing-modules)
- [ ] Consider using [nix-darwin] on macOS


# References

- [A Gentle Introduction to the Nix Family](https://ebzzry.io/en/nix/)
- [(neo)vim overlay configuration example](https://nixos.wiki/wiki/Vim#Custom_setup_without_using_Home_Manager)
	- [Example of adding new custom (neo)vim plugin](https://nixos.wiki/wiki/Vim#Add_a_new_custom_plugin_to_the_users_packages)

## Manuals

- [NixOS manual](https://nixos.org/nixos/manual/)
- [nixpkgs manual](https://nixos.org/nixpkgs/manual/)
- [nix manual](https://nixos.org/nix/manual/)
- [NixOps manual](https://nixos.org/nixops/manual/)
- [Home Manager manual](https://rycee.gitlab.io/home-manager/index.html)

## Config Examples

- [j0xaf (with i3 config)](https://github.com/j0xaf/dotfiles/blob/master/.config/nixpkgs/home.nix)
- [rummik (with system configurations, custom NixOS modules, nix-darwin, and home-manager)](https://github.com/rummik/nixos-config)

## News

- [NixOS Weekly](https://weekly.nixos.org/)



[nix]: https://nixos.org/nix/
[home-manager]: https://github.com/rycee/home-manager
[nix-darwin]: https://github.com/LnL7/nix-darwin
