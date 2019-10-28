# nix-config

My personal [nix] configuration.


# Features

- Uses [home-manager] to manage user settings
- Per-machine configurations with common core
- Templating via [nix expression language](https://nixos.org/nix/manual/#ch-expression-language)
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


# References
- <https://ebzzry.io/en/nix/>
- <https://nixos.wiki/wiki/Vim#Custom_setup_without_using_Home_Manager>

## Other interesting configs

- <https://github.com/nocoolnametom/nix-configs>
- With i3 config: <https://github.com/j0xaf/dotfiles/blob/master/.config/nixpkgs/home.nix>


[nix]: https://nixos.org/nix/
[home-manager]: https://github.com/rycee/home-manager
