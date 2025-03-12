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

	system.activationScripts.grantGlatpakOverrides = {
		text = ''
			${pkgs.flatpak}/bin/flatpak override --filesystem=$HOME/.themes
			${pkgs.flatpak}/bin/flatpak override --filesystem=$HOME/.icons
			USER=ocbwoy3 ${pkgs.flatpak}/bin/flatpak override --user --filesystem=xdg-config/gtk-4.0
			${pkgs.flatpak}/bin/flatpak override --filesystem=xdg-config/gtk-4.0
			USER=ocbwoy3 ${pkgs.flatpak}/bin/flatpak override --user --filesystem=xdg-config/gtk-3.0
			${pkgs.flatpak}/bin/flatpak override --filesystem=xdg-config/gtk-3.0
		'';
	};

	system.activationScripts.reloadFonts = {
		text = ''
			trap "${pkgs.fontconfig}/bin/fc-cache" EXIT
		'';
	};

	system.activationScripts.xdgDesktopPortal = {
		text = ''
			echo "${pkgs.xdg-desktop-portal-gtk}/libexec/xdg-desktop-portal-gtk" > /.xdg.sh
		'';
	};

}
