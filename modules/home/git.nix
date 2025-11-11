{ ... }:
{
home.file.".ssh/allowed_signers".text =
  "* ${builtins.readFile ../../id_ed25519.pub}";

  programs.git = {
    enable = true;

    settings.user = {
      name = "Leah";
      email = "leah@leahdevs.xyz";
      
    };

    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };
}
