{ config, pkgs, ... }:

{

	# services.displayManager.lightdm = {
	# 	enable = true;
	# 	autoLogin = {
	# 		relogin = true;
	# 		minimumUid = 1000;
	# 	};
	# 	package = pkgs.kdePackages.sddm;
	# };

	services.displayManager.autoLogin = {
		enable = true;
		user = "ocbwoy3";
	};

	services.displayManager.defaultSession = "hyprland";

	programs.zsh.enable = true;

	programs.direnv = {
		enable = true;
		enableZshIntegration = true;
	};

	programs.gamemode.enable = true;
	programs.gamemode.settings.general.renice = 0;
	programs.gamemode.settings.general.ioprio = 0;
	programs.gamemode.settings.general.softrealtime = "on";
	services.usbmuxd.enable = true;

	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = with pkgs; [
		c-ares ffmpeg gtk3 http-parser libevent libvpx libxslt minizip nss re2 snappy libnotify libappindicator-gtk3
	];

	services.openssh = {
		enable = true;
		banner = "please fuck off\n";
	};

	services.dbus.packages = [ pkgs.gcr ];

	services.pcscd.enable = true;
	programs.gnupg = {
		# enable = true;
		agent = {
			enable = true;
			pinentryPackage = pkgs.pinentry-gnome3;
		};
	};

}
