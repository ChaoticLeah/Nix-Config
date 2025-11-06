{ ... }:
{
# basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    settings.user = {
        name = "Leah";
        email = "leah@leahdevs.xyz";
    };
  };
}
