{ pkgs, ... }:

{

  imports = builtins.filter (x: x != null) [
    ./steam.nix
    ./vintagestory.nix
    ./minecraft.nix
  ];
}
