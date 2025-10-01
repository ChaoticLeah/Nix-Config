{pkgs, ...}:

{
  environment.systemPackages = [ pkgs.vintagestory ];

  # nixpkgs.config.permittedInsecurePackages = [
  #   "dotnet-runtime-7.0.20"
  # ];
}

