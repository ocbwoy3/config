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
			# install roblox manually from flathub 😍
			if [ ! -d "/home/ocbwoy3/.var/app/org.vinegarhq.Sober" ]; then
				echo "Please Install Roblox - https://flathub.org/apps/org.vinegarhq.Sober"
				echo "$ flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo"
				echo "$ flatpak install --user flathub org.vinegarhq.Sober"
			fi
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
