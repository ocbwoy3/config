{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation {
	name = "tuxstrap-cron-executable";
	src = ./files/crontab-executable.ts;

	unpackPhase = ''
		mkdir -p $out
		cp $src tuxstrap-crontab.bin
	'';

	installPhase = ''
		mkdir -p $out/bin
		mkdir -p $out/lib
		echo '${"#"}!/bin/bash' > $out/bin/tuxstrap-crontab
        echo '${pkgs.bun}/bin/bun run $out/lib/crontab-executable.ts' >> $out/bin/tuxstrap-crontab
        chmod +x $out/bin/tuxstrap-crontab
		
		mv crontab-executable $out/lib/
	'';

	meta = with nixpkgs.lib; {
        description = "tuxstrap crontab executable";
	};
}
