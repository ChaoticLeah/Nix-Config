{ stdenv, fetchFromGitHub, python310 }:

stdenv.mkDerivation rec {
  pname = "phomemo-tools";
  version = "2.0";

  src = fetchFromGitHub {
    owner = "pavel-demin";
    repo = "phomemo-tools";
    rev = "v2.0";
    sha256 = "sha256-E7eOnUlOwjvKoEX91//VLFB/3lk1qQW8b0iqYaW5l9A=";
  };

  nativeBuildInputs = [ python310 ];

  installPhase = ''
    mkdir -p $out/bin
    cp tools/phomemo-filter.py $out/bin/
    chmod +x $out/bin/phomemo-filter.py
  '';

  meta = {
    description = "Phomemo printer CLI tools";
    license = stdenv.lib.licenses.mit;
    homepage = "https://github.com/vivier/phomemo-tools";
  };
}

