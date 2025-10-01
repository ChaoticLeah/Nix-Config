{ pkgs, ... }:

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
}

