{ lib, stdenv, fetchFromGitHub, pkg-config, wayland, waylandProtocols, wlrProtocols, libspng }:

stdenv.mkDerivation rec {
  pname = "wl_shimeji";
  version = "1.0.0"; # Change to the appropriate version

  src = fetchFromGitHub {
    owner = "CluelessCatBurger";
    repo = "wl_shimeji";
    rev = "392a83d5658f283ace77b0c839d5a201cebc8784"; # Change to the appropriate commit
    sha256 = "sha256-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX="; # Put the correct sha256 hash
  };

  nativeBuildInputs = [ pkg-config wayland waylandProtocols wlrProtocols libspng ];

  buildInputs = [ ];

  installPhase = ''
    make install PREFIX=$out
  '';

  meta = with lib; {
    description = "Shimeji reimplementation for Wayland in C";
    homepage = "https://github.com/CluelessCatBurger/wl_shimeji";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
  };
}