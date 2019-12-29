FROM nixorg/nix
ENV NIX_PATH="/nix/var/nix/profiles/per-user/root/channels:nixpkgs-overlays=/data/overlays"
WORKDIR /data
COPY . .
COPY ./files/xonsh/ /root/.config/xonsh/
COPY ./files/coc-settings.json /root/.config/nvim/coc-settings.json
RUN \
	nix-channel --add https://nixos.org/channels/nixpkgs-unstable && \
	nix-channel --update && \
	nix-env -i env-container && \
	nix-collect-garbage -d && \
	nix optimise-store && \
	nvim -c 'CocInstall -sync \
			coc-marketplace \
			coc-css\
			coc-html \
			coc-json \
			coc-python \
			coc-yaml \
			| quit'
ENTRYPOINT ["/bin/xonsh"]
