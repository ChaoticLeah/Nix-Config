{ config, globals, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git-credential-manager
    pass
    gnupg
    cloc
  ];

  services.gnome.gnome-keyring.enable = true;

  security.pam.services.login.enableGnomeKeyring = true;

  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    config = {
      credential.helper = "libsecret";
      push = {
        autoSetupRemote = true;
      };
      alias = {
        tree = "log --oneline --graph --decorate --all";
      };
    };
  };

  home-manager.users.${globals.user} = {
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

        gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";

      };

      ignores = [
        ".direnv"
        "__pycache__"
        "node_modules"
        "*.log"
        ".DS_Store"
      ];


      signing = {
        key = "~/.ssh/id_ed25519.pub";
        format = "ssh";
      };
    };
  };
}
