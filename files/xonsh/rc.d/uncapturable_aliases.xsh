# Uncapturable Aliases
# See https://xon.sh/tutorial.html#uncapturable-aliases

from xonsh.tools import unthreadable, uncapturable


@unthreadable
@uncapturable
def _nix(args, stdin=None):
	nix @(args)


@unthreadable
@uncapturable
def _tig(args, stdin=None):
	tig @(args)

aliases['nix'] = _nix
aliases['tig'] = _tig

