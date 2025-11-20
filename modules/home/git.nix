{ ... }:
{
  home.file.".ssh/allowed_signers".text = "* ${builtins.readFile ../../id_ed25519.pub}";

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Leah";
        email = "leah@leahdevs.xyz";
      };
      gpg = {
        format = "ssh";
      };
      commit.gpgsign = true;
    };

    signing = {
      key = "~/.ssh/id_ed25519.pub";
      format = "ssh";
    };
    #settings = {
    #  commit.gpgsign = true;
    #  gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
    #};
  };
}
