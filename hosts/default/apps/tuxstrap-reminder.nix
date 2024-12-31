{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation {
	name = "tuxstrap-cron-executable";
	src = pkgs.fetchFromGitHub {
		owner = "ocbwoy3";
		repo = "tuxstrap";
		rev = "v1.2.0";
		sha256 = "sha256-YZ+GD9hs8PAf45kFklrR3j1hUWovKWllr2iQuh3gRms="; # Replace with the actual sha256
	};

	buildInputs = [ pkgs.bun ];

	buildPhase = ''
		bun build ./daily-challenge-reminder-crontab.ts --compile --minify --outfile reminder-crontab-exec
	'';

	installPhase = ''
		mkdir -p $out/bin
		cp reminder-crontab-exec $out/bin/tuxstrap-cron
	'';
}
