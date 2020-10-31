NAME := mvp

container:
	sudo nixos-container create $(NAME)
	sudo nixos-container start $(NAME)
	sudo nixos-container root-login $(NAME)

clean:
	sudo nixos-container destroy $(NAME)
