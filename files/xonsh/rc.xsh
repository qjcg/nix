xontrib load bashisms coreutils vox

$PATH.extend([
	p'~/.nix-profile/bin',
	p'/run/current-system/sw/bin',
	p'/usr/local/bin'
])

$XONSH_COLOR_STYLE = 'paraiso-dark'

$PROMPT = '{env_name}{BOLD_GREEN}{user}@{hostname}{NO_COLOR} {CYAN}{cwd_base}{NO_COLOR} {gitstatus} {BOLD_CYAN}{k8s}{NO_COLOR}\n{BOLD_YELLOW}❯{NO_COLOR} '
$BROWSER = 'firefox'
$PAGER = 'less'
$EDITOR = 'nvim'
$VISUAL = 'nvim'
$MAILRC = p'~/.config/s-nail/mailrc'.as_posix()

aliases['grep'] = 'grep -E'
aliases['ls'] = 'ls --color --human-readable --group-directories-first'
aliases['tree'] = 'tree -A -C'
aliases['vi'] = 'nvim'
aliases['vim'] = 'nvim'

# Source all modular xonsh config files in the rc.d directory.
for f in pg`~/.config/xonsh/rc.d/**xsh`:
	source @(f.absolute())
