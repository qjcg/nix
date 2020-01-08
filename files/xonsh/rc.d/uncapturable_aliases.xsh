# Uncapturable Aliases

# Workaround for programs that open an editor (or similar).
# See: https://github.com/xonsh/xonsh/issues/3133#issuecomment-494384522
# Solution here NOT working: https://xon.sh/tutorial.html#uncapturable-aliases

__xonsh__.commands_cache.threadable_predictors['git'] = lambda args: False
__xonsh__.commands_cache.threadable_predictors['nix'] = lambda args: False
__xonsh__.commands_cache.threadable_predictors['tig'] = lambda args: False
