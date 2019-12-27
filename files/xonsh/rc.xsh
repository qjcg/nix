xontrib load bashisms coreutils

$XONSH_COLOR_STYLE = 'paraiso-dark'

# PROMPT
$PROMPT = '{env_name}{BOLD_GREEN}{user}@{hostname}{BOLD_BLUE} {cwd}{NO_COLOR} {BOLD_YELLOW}{prompt_end}{NO_COLOR} '
$RIGHT_PROMPT = '{gitstatus}'

$BROWSER = 'firefox'
$PAGER = 'less'
$EDITOR = 'nvim'
$VISUAL = 'nvim'
$MAILRC = p'~/.config/s-nail/mailrc'.as_posix()

# Modular configuration.
for f in pg`~/.config/xonsh/rc.d/**xsh`:
	source @(f.absolute())


aliases['drw_winvm'] = 'rdesktop -u jgosset -p - -g 1680x1050 -K mt1n-jgosset'
aliases['grep'] = 'grep -E'
aliases['ls'] = 'ls --color --human-readable --group-directories-first'
aliases['tree'] = 'tree -A -C'
aliases['vi'] = 'nvim'
aliases['vim'] = 'nvim'
