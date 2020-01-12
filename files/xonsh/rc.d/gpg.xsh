# GPG

# gpg-agent setup to manage both GPG & SSH keys.
# Ref:
#  - gpg-agent(1)/EXAMPLES
#  - gpg-agent(1)/--enable-ssh-support
import shutil

# Only set these env vars if gpgconf exists to avoid a shell startup error.
if shutil.which('gpgconf'):
	$GPG_TTY = $(tty).rstrip()
	$SSH_AUTH_SOCK = $(gpgconf --list-dirs agent-ssh-socket).rstrip()
