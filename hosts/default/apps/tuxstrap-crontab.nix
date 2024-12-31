{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation {
	name = "tuxstrap-cron-executable";
	src = ./files/crontab-executable.ts;

	unpackPhase = ''
		mkdir -p $out
	'';

	buildPhase = ''
		mkdir -p $out
		mkdir -p $out/lib
		cp $src $out/lib/crontab-executable.ts
	'';

	installPhase = ''
		mkdir -p $out/bin
		echo "#!/bin/bash" > $out/bin/tuxstrap-crontab
		echo '${pkgs.bun}/bin/bun run $(dirname "$(realpath "$0")")/../lib/crontab-executable.ts' >> $out/bin/tuxstrap-crontab
		chmod +x $out/bin/tuxstrap-crontab
	'';
}
