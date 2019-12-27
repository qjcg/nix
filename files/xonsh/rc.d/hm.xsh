aliases['hm'] = 'home-manager'
aliases['hm_remove_all_but_3'] = '''home-manager generations | awk 'NR > 3 {print $5}' | xargs home-manager remove-generations && nix-collect-garbage'''
aliases['hms'] = 'home-manager switch -A eiffel'


def _hmus():
	nix-channel --update
	home-manager switch -A eiffel

aliases['hmus'] = _hmus
