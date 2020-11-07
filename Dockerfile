FROM nixpkgs/nix-flakes
COPY ./files/nix.conf /etc/nix/nix.conf
RUN \
	nix registry add qjcg github:qjcg/nix && \
	nix flake show qjcg
