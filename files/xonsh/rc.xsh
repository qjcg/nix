xontrib load bashisms coreutils vox

$PATH.extend([
	p'~/.nix-profile/bin',
	p'/run/current-system/sw/bin',
	p'/usr/local/bin'
])

$XONSH_COLOR_STYLE = 'paraiso-dark'

def k8s_status():
	"""Return current Kubernetes context and namespace.
	"""
	ctx = $(kubectl config view --minify --output 'jsonpath={.current-context}').rstrip()
	ns = $(kubectl config view --minify --output 'jsonpath={..namespace}').rstrip()

	if ctx and ns:
		status = f"{ctx} ({ns})"
	elif ctx and not ns:
		status = f"{ctx}"
	else:
		status = ""

	return status

# PROMPT
$PROMPT_FIELDS['k8s'] = k8s_status
$PROMPT = '{env_name}{BOLD_GREEN}{user}@{hostname}{NO_COLOR} {CYAN}{cwd_base}{NO_COLOR} {gitstatus} {BOLD_CYAN}{k8s}{NO_COLOR}\n{BOLD_YELLOW}❯{NO_COLOR} '
$ENABLE_ASYNC_PROMPT = True

$BROWSER = 'firefox'
$PAGER = 'less'
$EDITOR = 'nvim'
$VISUAL = 'nvim'
$MAILRC = p'~/.config/s-nail/mailrc'.as_posix()

# Source all modular xonsh config files in the rc.d directory.
for f in pg`~/.config/xonsh/rc.d/**xsh`:
	source @(f.absolute())


aliases['drw_winvm'] = 'rdesktop -u jgosset -p - -g 1680x1050 -K mt1n-jgosset'
aliases['grep'] = 'grep -E'
aliases['ls'] = 'ls --color --human-readable --group-directories-first'
aliases['tree'] = 'tree -A -C'
aliases['vi'] = 'nvim'
aliases['vim'] = 'nvim'


from xonsh.tools import color_style_names

def _review_color_styles():
    """Interactively review xonsh color themes.

    The style can then be set via the environment variable $XONSH_COLOR_STYLE.

    Ref: https://xon.sh/customization.html#change-the-current-color-theme
    """
    for s in color_style_names():
        print(f"STYLE: {s}\n")
        xonfig colors @(s)
        input('\nPress ENTER to see next style\n\n')

aliases['review_color_styles'] = _review_color_styles
