# Leahs Nixos Config


My little config for my nix laptop, computer, and server(s).


## Structure
Its not everything but it explains the general structure
```
nixos/
├─ flake.nix               # Flake entrypoint: inputs (nixpkgs, home-manager, hyprland, etc.) and outputs (nixosConfigurations, common modules)
├─ pkgs/                   # Custom package expressions maintained in this repo
├─ modules/                # Reusable Nix modules (main configuration code)
│  ├─ home/                # Home Manager / per-user session modules (hyprland, waybar, rofi, wallpapers)
│  ├─ hardware/            # Hardware-specific modules (NVIDIA, offload apps)
│  ├─ services/            # Service modules (nginx vhosts, postgres, redis, jellyfin, etc.)
│  ├─ development/         # Developer tooling (git, git-hooks, docker helpers)
│  ├─ nixvim/              # Neovim/Home Manager editor + plugin/LSP configs
│  ├─ programs/            # Per-program wrappers (e.g. fusion360)
│  ├─ games/               # Game-related modules/packages
│  ├─ fonts.nix            # Fonts to install (nerd fonts, Fira Code, etc.)
│  └─ common.nix           # Configs shared between all installs. Super generic stuff.
└─ hosts/                  # Host-specific NixOS configurations
```