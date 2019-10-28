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

Interesting and useful links on a variety of nix-related topics.

## Manuals

- [NixOS manual](https://nixos.org/nixos/manual/)
- [nixpkgs manual](https://nixos.org/nixpkgs/manual/)
- [nix manual](https://nixos.org/nix/manual/)
- [NixOps manual](https://nixos.org/nixops/manual/)
- [Home Manager manual](https://rycee.gitlab.io/home-manager/index.html)

## Guides

- [nix-1p: A one page introduction to Nix, the language](https://github.com/tazjin/nix-1p)
- [A Gentle Introduction to the Nix Family](https://ebzzry.io/en/nix/)
- [(neo)vim overlay configuration example](https://nixos.wiki/wiki/Vim#Custom_setup_without_using_Home_Manager)
	- [Example of adding new custom (neo)vim plugin](https://nixos.wiki/wiki/Vim#Add_a_new_custom_plugin_to_the_users_packages)
- [Setting up a custom nix channel](https://savanni.luminescent-dreams.com/2019/09/13/nix-channel/)
- [How to put your /nix directory on a separate device](https://cs-syd.eu/posts/2019-09-14-nix-on-seperate-device)
- [Cheatsheet comparing Ubuntu & NixOS](https://nixos.wiki/wiki/Cheatsheet)
- [Flakes RFC / proposal](https://github.com/tweag/rfcs/blob/flakes/rfcs/0049-flakes.md)
	- [Flakes RFC GitHub PR (discussion)](https://github.com/NixOS/rfcs/pull/49)

### Containers

- [ociTools in NixOS](https://spacekookie.de/blog/ocitools-in-nixos/) (for building and running containers)
- [Tekton Pipelines - the Nix way](https://lewo.abesis.fr/posts/2019-09-30-tekton-pipelines-the-nix-way.html)
- [Deploying k8s apps with kubenix](https://zimbatm.com/deploying-k8s-apps-with-kubenix/)
- [Optimising Docker Layers for Better Caching with Nix](https://grahamc.com/blog/nix-and-layered-docker-images)

## Config Examples

- [j0xaf (with i3 config)](https://github.com/j0xaf/dotfiles/blob/master/.config/nixpkgs/home.nix)
- [rummik (with system configurations, custom NixOS modules, nix-darwin, and home-manager)](https://github.com/rummik/nixos-config)

## News

- [NixOS Weekly](https://weekly.nixos.org/)

## Tools & Services

- [nixery](https://nixery.dev/)
- [`nixfmt`](https://github.com/serokell/nixfmt)
- [mobile nixos](https://github.com/samueldr/mobile-nixos/)
- [nix-pre-commit-hooks](https://github.com/hercules-ci/nix-pre-commit-hooks)
- [cachix: Nix binary cache hosting](https://cachix.org/)
- [Cachix & Install Nix actions for GitHub](https://discourse.nixos.org/t/cachix-nix-install-actions-for-github/4242/2)
- [netboot.xyz (boot nix directly via network, no USB key)](https://github.com/antonym/netboot.xyz)



[nix]: https://nixos.org/nix/
[home-manager]: https://github.com/rycee/home-manager
[nix-darwin]: https://github.com/LnL7/nix-darwin
