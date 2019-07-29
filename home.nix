# home-manager configuration.
# See https://github.com/rycee/home-manager

# Below are machine-specific configurations.
# To choose a machine, run (for example):
#   home-manager -A luban switch
# Ref: home-manager(1)

{
  luban   = import ./machines/luban;
  eiffel  = import ./machines/eiffel;
}
