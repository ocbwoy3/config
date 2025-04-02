{ lib, stdenv, fetchgit, pkg-config, wayland, wayland-protocols, wlr-protocols, wayland-scanner, libspng, pkgs }:

stdenv.mkDerivation rec {
  pname = "wl_shimeji";
  version = "1.0.0"; # Change to the appropriate version

  src = fetchgit {
    url = "https://github.com/CluelessCatBurger/wl_shimeji.git";
    rev = "392a83d5658f283ace77b0c839d5a201cebc8784"; # Change to the appropriate commit
    sha256 = "sha256-T7sWuKOsc0vEfkcGbRXLHit24db97crEhYadOMq4MDM="; # Put the correct sha256 hash
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ pkg-config wayland wayland-protocols wlr-protocols libspng wayland-scanner ];

  buildInputs = [ ];

  installPhase = ''
    make install PREFIX=$out
    find $out -type f -exec sed -i 's|#!/bin/python3|#!${pkgs.python3}/bin/python3|' {} +
  '';

  meta = with lib; {
    description = "Shimeji reimplementation for Wayland in C";
    homepage = "https://github.com/CluelessCatBurger/wl_shimeji";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
  };
}
