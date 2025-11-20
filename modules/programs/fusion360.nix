# Run fusion360 to open and fusion360-uninstall to uninstall
{
  pkgs ? import <nixpkgs> { },
}:

let
  fusionSetup = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/autodesk_fusion_installer_x86-64.sh";
    sha256 = "sha256-aio2HqAzM0PWtvXuHNztvUpRTSG+Y0oStl5aWqIPvoE=";
  };
in
pkgs.stdenv.mkDerivation {
  pname = "fusion360";
  version = "latest";

  buildInputs = [
    pkgs.wineWowPackages.stable
    pkgs.winetricks
    pkgs.curl
    pkgs.coreutils
  ];

  unpackPhase = "true";

  installPhase = ''
    mkdir -p $out/bin
    cat > $out/bin/fusion360 <<'EOF'
    #!${pkgs.bash}/bin/bash
    set -e

    PREFIX="$HOME/.fusion360"
    INSTALLER="${fusionSetup}"

    # Install if not yet installed
    if [ ! -d "$PREFIX" ]; then
      echo "Installing Fusion 360 into $PREFIX ..."
      mkdir -p "$PREFIX"
      cp "$INSTALLER" "$PREFIX/fusion360-installer.sh"
      chmod +x "$PREFIX/fusion360-installer.sh"
      cd "$PREFIX"
      ./fusion360-installer.sh
    fi

    echo "Launching Fusion 360..."
    if [ -x "$PREFIX/bin/fusion360" ]; then
      "$PREFIX/bin/fusion360"
    else
      echo "Error: Fusion 360 executable not found. Try reinstalling by deleting $PREFIX"
      exit 1
    fi
    EOF

    chmod +x $out/bin/fusion360

    # Uninstaller helper
    cat > $out/bin/fusion360-uninstall <<'EOF'
    #!${pkgs.bash}/bin/bash
    echo "This will remove your Fusion 360 installation from ~/.fusion360"
    read -p "Are you sure? [y/N] " answer
    if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
      rm -rf "$HOME/.fusion360"
      echo "Fusion 360 uninstalled."
    else
      echo "Cancelled."
    fi
    EOF
    chmod +x $out/bin/fusion360-uninstall
  '';

  meta = with pkgs.lib; {
    description = "Autodesk Fusion 360 installer and launcher for Linux via Wine";
    license = licenses.unfree;
    platforms = platforms.linux;
    maintainers = with maintainers; [ ];
  };
}
