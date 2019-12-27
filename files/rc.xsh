$PROMPT = '{env_name}{BOLD_GREEN}{user}@{hostname}{BOLD_BLUE} {cwd}{branch_color}{curr_branch: {}}{NO_COLOR} {BOLD_YELLOW}{prompt_end}{NO_COLOR} '
$EDITOR = 'nvim'
$VISUAL = 'nvim'

# Workaround to allow "nix edit" to work properly, found here:
#   https://github.com/xonsh/xonsh/issues/3133#issuecomment-494384522
__xonsh__.commands_cache.threadable_predictors['nix'] = lambda args: False


aliases['drw_winvm'] = 'rdesktop -u jgosset -p - -g 1680x1050 -K mt1n-jgosset'
aliases['grep'] = 'grep -E'
aliases['hm'] = 'home-manager'
aliases['hm_remove_all_but_3'] = '''home-manager generations | awk 'NR > 3 {print $5}' | xargs home-manager remove-generations && nix-collect-garbage'''
aliases['hms'] = 'home-manager switch -A eiffel'
aliases['k'] = 'kubectl'
aliases['ls'] = 'ls --color --human-readable --group-directories-first'
aliases['tree'] = 'tree -A -C'
aliases['vi'] = 'nvim'
aliases['vim'] = 'nvim'


import re


def docker_pull_all(skip_regex='none|harbor.drw'):
	"""Pull latest versions of docker images in local cache.
	"""
	images = $(docker images | awk 'NR > 1 {print $1":"$2}').split()
	for i in images:
		if re.search(skip_regex, i):
			continue
		docker pull @(i)
	docker image prune -f
