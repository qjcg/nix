NAME := nixos

container:
	$(shell sudo nixos-container create $(NAME) --flake '.#$(NAME)' || sudo nixos-container update $(NAME) --flake '.#$(NAME)')
	sudo nixos-container start $(NAME)
	sudo nixos-container root-login $(NAME)

clean:
	sudo nixos-container destroy $(NAME)
