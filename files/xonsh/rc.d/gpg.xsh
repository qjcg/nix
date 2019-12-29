# GPG

# gpg-agent setup to manage both GPG & SSH keys.
# Ref:
#  - gpg-agent(1)/EXAMPLES
#  - gpg-agent(1)/--enable-ssh-support
try:
	$GPG_TTY = $(tty).rstrip()
	$SSH_AUTH_SOCK = $(gpgconf --list-dirs agent-ssh-socket).rstrip()
except FileNotFoundError:
	pass
