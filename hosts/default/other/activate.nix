{ config, inputs, pkgs, lib, ... }:

{

	# system.nixos = {
	# 	distroName = "OCbwoy3";
	# 	extraOSReleaseArgs = {
	# 		HOME_URL="https://ocbwoy3.dev/";
	# 		VERSION_CODENAME="";
	# 		NAME="OCbwoy3";
	# 		PRETTY_NAME="OCbwoy3";
	# 	};
	# };

	system.activationScripts.installRoblox = {
		text = ''
			trap "${pkgs.flatpak}/bin/flatpak install -y https://sober.vinegarhq.org/sober.flatpakref" EXIT
		'';
	};

	system.activationScripts.xdgDesktopPortal = {
		text = ''
			echo "${pkgs.xdg-desktop-portal-gtk}/libexec/xdg-desktop-portal-gtk" > /.xdg.sh
		'';
	};

	# error code 126
	system.activationScripts.catppuccinGtk = {
		text = ''
			${pkgs.curl}/bin/curl "https://raw.githubusercontent.com/catppuccin/gtk/v1.0.3/install.py" > /tmp/install.py
			${pkgs.python3}/bin/python3 /tmp/install.py mocha blue
		'';
	};

}
