aliases['hm'] = 'home-manager'
aliases['hm_prune'] = '''home-manager generations | awk 'NR > 3 {print $5}' | xargs home-manager remove-generations && nix-collect-garbage'''
aliases['hms'] = 'home-manager switch -A eiffel'


def _hmus():
	"""Update nix channels, then run home-manager switch.
	"""
	nix-channel --update
	home-manager switch -A eiffel

aliases['hmus'] = _hmus
