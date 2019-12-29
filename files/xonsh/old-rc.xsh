from datetime import datetime
import logging
import os
import re
import sys
import urllib

from xonsh.tools import color_style_names
from xontrib.voxapi import events

# Add my personal xontrib dir.
my_xontribs = os.path.expanduser('~/.xonsh.d/xontrib')
sys.path.append(my_xontribs)

$PATH.extend([
    p'~/s/bin',
    p'~/.local/bin',
])

$EDITOR = '/usr/bin/nvim -u ~john/.config/nvim/init.vim'
$SYSTEMD_EDITOR = $EDITOR
$VISUAL = $EDITOR

# CONFIGURE LOGGING

logging.basicConfig(level=logging.INFO)

def toggle_debug_logging():
    """Toggle between INFO and DEBUG log levels.
    """
    l = logging.getLogger()
    if l.getEffectiveLevel() == logging.DEBUG:
        l.setLevel(logging.INFO)
        logging.info("Now logging at INFO level")
    else:
        l.setLevel(logging.DEBUG)
        logging.info("Now logging at DEBUG level")

def review_color_styles():
    """Interactively review xonsh color themes.

    The style can then be set via the environment variable $XONSH_COLOR_STYLE.

    Ref: https://xon.sh/customization.html#change-the-current-color-theme
    """
    for s in color_style_names():
        print(f"STYLE: {s}\n")
        xonfig colors @(s)
        input('\nPress ENTER to see next style\n\n')


# XONTRIB

xontrib vox


$VI_MODE = True


# PROMPTS

$PROMPT_FIELDS['timestamp'] = lambda: datetime.now().strftime('%-I:%M:%S')
$PROMPT = '{env_name:{} }{BOLD_GREEN}{user}@{hostname}{NO_COLOR}:{CYAN}{cwd_base} {prompt_end}{NO_COLOR} '
$RIGHT_PROMPT = "{#444}{timestamp}"
#$BOTTOM_TOOLBAR = '{user}@{hostname}{NO_COLOR}'

$PATH.append('~/.local/node_modules/bin')

$XONSH_COLOR_STYLE = 'paraiso-dark'


aliases['vim'] = '/usr/bin/nvim'

# PYTHON

@events.vox_on_activate
def _add_venv_packages_to_path(**kw):
    """Add virtualenv module path to sys.path.
    """
    venv_module_path = $VIRTUAL_ENV + '/lib/python3.7/site-packages'

    if venv_module_path not in sys.path:
        sys.path.append(venv_module_path)


@events.on_precommand
def gpg_update_tty(**kw):
    """ Updates TTY for gpg.
    """
    logging.debug("FIRED: events.on_precommand -> gpg_update_tty")
    gpg-connect-agent updatestartuptty /bye all>/dev/null

_RE_GPGCMD = re.compile(
              r"^\s*(fossil\s+(commit|ci|pull|push|sync)|"
              r"git\s+(clone|fetch|pull|push)|"
              r"gopass|gpg |mutt|pass |ssh |"
              r"ansible |ansible-playbook)"
            )

@gpg_update_tty.validator
def _validate_gpg_calling_cmd(cmd):
    """Determine whether gpg_update_tty should run.
    """
    return _RE_GPGCMD.match(cmd)


# TODO: Reimplement this as a xontrib!
# Ref: https://xon.sh/tutorial_xontrib.html
# DOCKER

def docker_images():
    """Get docker images.
    """
    return $(docker images).split('\n')[1:-1]



def docker_update():
    """Update docker images.
    """
    for i in docker_images():
        name, tag, id, *_ = i.split()
        if 'molecule_local' in name:
            continue
        docker pull @(f'{name}:{tag}')
        logging.info(f'UPDATED docker image: {name}:{tag} (ID: {id})')


def docker_remove_cruft():
    """Remove docker images with <none> tag.
    """
    for i in docker_images():
      name, tag, id, *_ = i.split()
      if 'none' in tag:
        try:
          docker rmi @(id)
          logging.debug(f'REMOVED docker image: {name}:{tag} (ID: {id})')
        except ValueError as e:
          logging.debug(f'NOT REMOVED docker image: {name}:{tag} (ID: {id}')


# PLAN9

$PATH.append('/usr/lib/plan9/bin')


# Ensure $PATH values are UNIQUE.
from collections import OrderedDict
myod = OrderedDict()
for p in $PATH:
    myod[p] = None
$PATH = list(myod.keys())
del myod


# Set default path for choosing wallpapers.
$WALLP_PATH = '~/Pictures/wallpapers/space'
