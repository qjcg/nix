final: prev:

{
  st = prev.st.override { conf = builtins.readFile ./st-config.h; };
}
