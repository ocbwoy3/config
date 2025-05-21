{ lib, stdenv, fetchgit, pkg-config, wayland, wayland-protocols, wlr-protocols, wayland-scanner, libspng, pkgs }:

stdenv.mkDerivation rec {
  pname = "ocbwoy3-system-icons";
  version = "1.0.0";
  src = ./.;

  nativeBuildInputs = [ ];

  buildInputs = [ ];

  installPhase = ''
	mkdir -p $out/share/icons/hicolor/{128x128,256x256,512x512}/apps
	for size in 128x128 256x256 512x512; do
	  cp ./logo.png $out/share/icons/hicolor/$size/apps/ocbwoy3-system.png
	done
  '';

  meta = with lib; {
    description = "OCbwoy3's custom icons for NixOS";
    homepage = "https://github.com/ocbwoy3/config";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
