$PROMPT = '{env_name}{BOLD_GREEN}{user}@{hostname}{BOLD_BLUE} {cwd}{branch_color}{curr_branch: {}}{NO_COLOR} {BOLD_YELLOW}{prompt_end}{NO_COLOR} '
$EDITOR = 'nvim'
$VISUAL = 'nvim'

# Modular configuration.
import os.path
$XDG_CONFIG_DIR = os.path.expanduser('~/.config')
source $XDG_CONFIG_DIR/xonsh/rc.d/docker.xsh
source $XDG_CONFIG_DIR/xonsh/rc.d/hm.xsh
source $XDG_CONFIG_DIR/xonsh/rc.d/uncapturable_aliases.xsh


aliases['drw_winvm'] = 'rdesktop -u jgosset -p - -g 1680x1050 -K mt1n-jgosset'
aliases['grep'] = 'grep -E'
aliases['ls'] = 'ls --color --human-readable --group-directories-first'
aliases['tree'] = 'tree -A -C'
aliases['vi'] = 'nvim'
aliases['vim'] = 'nvim'
