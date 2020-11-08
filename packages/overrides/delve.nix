final: prev:

{
  delve = prev.delve.overrideAttrs (oldAttrs: rec {
    version = "1.5.0";
    src = prev.fetchFromGitHub {
      owner = "go-delve";
      repo = "delve";
      rev = "v${version}";
      sha256 = "0m7fryclrj0qzqzcjn0xc9vl43srijyfahfkqdbm59xgpws67anp";
    };
  });
}
