{ config, pkgs, lib, ... }:

let
  imageToolStack = import ./docker-image-tool.nix {
    inherit pkgs lib config;
  };
in
{
  imports = [ imageToolStack ];

  virtualisation.oci-containers.backend = "podman"; # or "podman"
}

