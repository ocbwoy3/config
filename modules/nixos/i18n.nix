{ config, pkgs, ... }:

{

	time.timeZone = "Europe/Riga";

	# en_US.UTF-8
	i18n.defaultLocale = "lv_LV.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "lv_LV.UTF-8";
		LC_IDENTIFICATION = "lv_LV.UTF-8";
		LC_MEASUREMENT = "lv_LV.UTF-8";
		LC_MONETARY = "lv_LV.UTF-8";
		LC_NAME = "lv_LV.UTF-8";
		LC_NUMERIC = "lv_LV.UTF-8";
		LC_PAPER = "lv_LV.UTF-8";
		LC_TELEPHONE = "lv_LV.UTF-8";
		LC_TIME = "lv_LV.UTF-8";
	};

	i18n.supportedLocales = [
		"en_US.UTF-8/UTF-8"
		"lv_LV.UTF-8/UTF-8"
	];

	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};
	
}
