self: super:

{
  st = super.st.override { conf = builtins.readFile ./st-config.h; };
}
