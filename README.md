# dotfiles

My personal dotfiles.


## Features

- only one command needed to bootstrap new machines
- per-machine configurations with common core
- secure secret storage via GPG (TODO: elaborate on this!)
- templating via [nix expression language](https://nixos.org/nix/manual/#ch-expression-language)


## Use

On a mac:

```sh
# Install the nix package manager.
curl https://nixos.org/nix/install | sh

# Clone this repo.
mkdir -p ~/.config
git clone https://github.com/qjcg/nix-home ~/.config/nixpkgs

# Install the mac environment (for details, see config.nix).
nix-env -iA nixpkgs.env-mac
```


## Stack

- [nix](https://nixos.org/nix/)
- [home-manager](https://github.com/rycee/home-manager)
- [GnuPG](https://gnupg.org/)


## Tested Platforms

- macOS
- Arch Linux
- Ubuntu 18.04


## References
- <https://ebzzry.io/en/nix/>
- <https://nixos.wiki/wiki/Vim#Custom_setup_without_using_Home_Manager>

### Other interesting configs

- <https://github.com/nocoolnametom/nix-configs>
- With i3 config: <https://github.com/j0xaf/dotfiles/blob/master/.config/nixpkgs/home.nix>
