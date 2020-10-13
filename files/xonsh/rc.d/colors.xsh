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
