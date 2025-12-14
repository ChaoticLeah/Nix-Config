{ ... }:
{
  #pre-commit-check = git-hooks.run {
  #  hooks = {
  #    nixfmt-rfc-style.enable = true;
  #  };
  #};
  #shell = pkgs.mkShellNoCC {
  #  packages = [ pre-commit-check.enabledPackages ];
  #  shellHook = ''
  #    ${pre-commit-check.shellHook}
  #  '';
  #};
}
