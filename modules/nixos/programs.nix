{ config, pkgs, ... }:

{

	services.displayManager.sddm = {
		enable = true;
		package = pkgs.kdePackages.sddm;
	};

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
		banner = "What the fuck do you think you're doing here?\n";
	};

}
