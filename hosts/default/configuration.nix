{ config, inputs, pkgs, lib, ... }:

{

	imports = [
		../../modules/nixos/nixpkgs.nix
		../../modules/nixos/bootloader.nix
		../../modules/nixos/hardware.nix
		../../modules/nixos/nvidia.nix
		../../modules/nixos/i18n.nix
		../../modules/nixos/main-user.nix
		../../modules/nixos/network.nix
		../../modules/nixos/programs.nix
		../../modules/home-manager/main.nix
		./packages.nix
		# ../../modules/home-manager/hyprpanel.nix
		./other/activate.nix
		# ./apps/ancs.nix	
		inputs.nvf.nixosModules.default	
	];

	programs.nvf = {
		enable = true;
		defaultEditor = true;
		# withLua = true;

		settings.vim = {
			viAlias = true;
			vimAlias = true;
			statusline.lualine.enable = true;
			languages = {
				enableLSP = true;
				enableTreesitter = true;

				nix.enable = true;
				ts.enable = true;
				# qml.enable = true;
			};
		};
	};

	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
		dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
		localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
	};

	# services.ancs.enable = true;

	services.flatpak.enable = true;
	services.flatpak.remotes = [
		{
			name = "flathub";
			location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
		}
	];
	services.flatpak.packages = [
		{
			appId = "com.modrinth.ModrinthApp";
			origin = "flathub";
		}
	];

	services.printing = {
		enable = true;
		drivers = with pkgs; [
			gutenprint
			gutenprintBin
			splix
			hplip
		];
		webInterface = true;
		listenAddresses = [ "*:631" ];
		allowFrom = [ "all" ];
		browsing = true;
		defaultShared = true;
		openFirewall = true;
	};

	programs.virt-manager.enable = true;
	# user.groups.libvirtd.members = [ "ocbwoy3" ];
	virtualisation.libvirtd.enable = true;
	# virtualisation.waydroid.enable = true;
	virtualisation.spiceUSBRedirection.enable = true;

	networking.extraHosts = ''
		# dont worry, i still don't like the guy
		# but i need to community note roblox on how their moderation is still shit
		# at this point just hire the goober project to take them down for you
	'';

	powerManagement.enable = true;

	services.avahi = {
		enable = true;
		nssmdns4 = true;
		openFirewall = true;
		publish = {
 			enable = true;
 			userServices = true;
		};
	};

	# Sadly, I don't know how to install flatpaks like this.
	# services.flatpak.packages = [
		# "com.usebottles.bottles"
		# { flatpakref = "https://sober.vinegarhq.org/sober.flatpakref"; sha256 = "0"; }
	# ];

	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
		# package = (pkgs.callPackage ./packages/hyprland/package.nix {});
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
	};

	programs.zsh = {
		enable = true;
		autosuggestions.enable = true;
		zsh-autoenv.enable = true;
		syntaxHighlighting.enable = true;
		ohMyZsh = {
			enable = true;
			plugins = [ "git" "direnv" ];
			theme = "robbyrussell";
		};
		shellAliases = {
			nixrebuild = "sudo nixos-rebuild switch --flake .#default --impure --cores 4 -L --upgrade";
			neofetch = "fastfetch";
		};
	};

	virtualisation.docker.enable = true;

	main-user.packages = with pkgs; [
		# warp-terminal
		(prismlauncher.override {
			jdks = [
				pkgs.jdk21
			];
		})
		# vesktop
		# legcord
		equibop
		code-cursor
		libsForQt5.kdenlive
		libsForQt5.qt5ct
		catppuccin-qt5ct
		lightly-qt
		kdePackages.qt6ct
		lightly-qt
		hyfetch
		kitty
		inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.ghostty
	];

	qt.enable = true;
	qt.platformTheme = "qt5ct";

	xdg.terminal-exec.enable = true;
    xdg.portal = {
		enable = true;
		extraPortals = [
			pkgs.xdg-desktop-portal-gnome
			pkgs.xdg-desktop-portal-gtk
			inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
		];
	};

	# environment.variables.XDG_TERMINAL = "${inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.ghostty}/bin/ghostty";
    # environment.variables.XDG_SYSTEM_MONITOR = "${pkgs.htop}/bin/htop";
	
	environment.variables.XDG_TERMINAL = "ghostty";
	environment.variables.XDG_SYSTEM_MONITOR = "htop";

	environment.variables.GTK_USE_PORTAL = "1";
	environment.sessionVariables.GTK_USE_PORTAL = 1;

	fileSystems = {
		"/".options = [ "compress=zstd" ];
		"/home".options = [ "compress=zstd" ];
		"/nix".options = [ "compress=zstd" "noatime" ];
	};

	services.btrfs.autoScrub = {
		enable = true;
		interval = "monthly";
		fileSystems = [ "/" ];
	};

	# CHANGE YOUR NAME IN HOME MANAGER!
	# BETTER YET, DON'T TOUCH THIS. AT ALL.

	main-user.userName = "ocbwoy3";
	main-user.realName = "OCbwoy3";

	services.fstrim.enable = true;
	systemd.services.fstrim.enable = false;

	systemd.services."NetworkManager-wait-online".enable = false;

	systemd.services.docker.wantedBy = lib.mkForce [ ];

	programs.dconf.enable = true;
	services.gvfs.enable = true;

	# home-manager.services.mpris-proxy.enable = true;

	home-manager.backupFileExtension = "hmbackup";

	catppuccin = {
		enable = true;
		flavor = "mocha";
		accent = "blue";
	};

	home-manager.users.ocbwoy3 = { programs, config, pkgs, ... }: {

		imports = [
			inputs.catppuccin.homeModules.catppuccin
			inputs.zen-browser.homeModules.beta
		];

		catppuccin = {
			enable = true;
			flavor = "mocha";
			accent = "blue";
			gtk.enable = true;
		};

		programs.zen-browser = {
			enable = true;
			nativeMessagingHosts = [pkgs.firefoxpwa];
			policies = {
				DisableAppUpdate = true;
				DisableTelemetry = true;
			};
		};

		home.file.".config/fastfetch" = {
			source = config.lib.file.mkOutOfStoreSymlink "/home/ocbwoy3/config/config/fastfetch";
			recursive = true;
		};

		home.file.".config/dunst" = {
			source = config.lib.file.mkOutOfStoreSymlink "/home/ocbwoy3/config/config/dunst";
			recursive = true;
		};

		home.file.".config/gtk-3.0" = {
			source = config.lib.file.mkOutOfStoreSymlink "/home/ocbwoy3/config/config/gtk-3.0";
			recursive = true;
		};

		home.file.".config/hypr" = {
			source = config.lib.file.mkOutOfStoreSymlink "/home/ocbwoy3/config/config/hypr";
			recursive = true;
		};

		home.file.".config/xdg-desktop-portal" = {
			source = config.lib.file.mkOutOfStoreSymlink "/home/ocbwoy3/config/config/xdg-desktop-portal";
			recursive = true;
		};

		home.file.".local/share/themes" = {
			source = config.lib.file.mkOutOfStoreSymlink "/home/ocbwoy3/config/config/themes";
			recursive = true;
		};

		home.file.".themes" = {
			source = config.lib.file.mkOutOfStoreSymlink "/home/ocbwoy3/config/config/themes";
			recursive = true;
		};

		home.file.".local/share/fonts/DotfilesFont.otf" = {
			source = config.lib.file.mkOutOfStoreSymlink "/home/ocbwoy3/config/config/dotfile_deps/DotfilesFont.otf";
		};

		home.file.".config/ghostty" = {
			source = config.lib.file.mkOutOfStoreSymlink "/home/ocbwoy3/config/config/ghostty";
			recursive = true;
		};

		home.file.".config/wlogout" = {
			source = config.lib.file.mkOutOfStoreSymlink "/home/ocbwoy3/config/config/wlogout";
			recursive = true;
		};

		home.file.".config/qt5ct" = {
			source = config.lib.file.mkOutOfStoreSymlink "/home/ocbwoy3/config/config/qt5ct";
			recursive = true;
		};

		home.file.".config/wofi" = {
			source = config.lib.file.mkOutOfStoreSymlink "/home/ocbwoy3/config/config/wofi";
			recursive = true;
		};


		# xdg.configHome = "/home/ocbwoy3/config/config";

		services.mpris-proxy.enable = true;

		programs.chromium = {
			enable = true;
			package = pkgs.brave;
			extensions = [
				{ id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
				{ id = "enamippconapkdmgfgjchkhakpfinmaj"; } # DeArrow
				{ id = "clngdbkpkpeebahjckkjfobafhncgmne"; } # Sytlus
				{ id = "hnmpcagpplmpfojmgmnngilcnanddlhb"; } # Windscribe
				{ id = "hfjngafpndganmdggnapblamgbfjhnof"; } # RoSeal
				{ id = "aflpfginfpjhanhkmdpohpggpolfopmb"; } # SkyLink
				{ id = "agjnjboanicjcpenljmaaigopkgdnihi"; } # PreMiD
				{ id = "ijcpiojgefnkmcadacmacogglhjdjphj"; } # Shinigami Eyes
				{ id = "hbkpclpemjeibhioopcebchdmohaieln"; } # BTRoblox
				{ id = "lnjaiaapbakfhlbjenjkhffcdpoompki"; } # Catppuccin gh file explorer icons
				{ id = "ejcfepkfckglbgocfkanmcdngdijcgld"; } # ChatGPT
				{ id = "jifpbeccnghkjeaalbbjmodiffmgedin"; } # CRX Viewer
				{ id = "hplhmahilccgjccaanlagdidofgaanfe"; } # Gamefam Blocker
				{ id = "adbacgifemdbhdkfppmeilbgppmhaobf"; } # RoPro
				{ id = "cbghhgpcnddeihccjmnadmkaejncjndb"; } # Vencord
				{ id = "jinjaccalgkegednnccohejagnlnfdag"; } # Violentmonkey
				{ id = "lahhiofdgnbcgmemekkmjnpifojdaelb"; } # Vercel
				{ id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # Sponsorblock
				{ id = "pncfbmialoiaghdehhbnbhkkgmjanfhe"; } # uBlacklist	
			];
		};

		programs.git = {
			enable = true;
			userName  = "OCbwoy3";
			userEmail = "ocbwoy3@ocbwoy3.dev";
		};

		programs.obs-studio = {
			enable = true;
			package = (pkgs.obs-studio.override {
				cudaSupport = true;
			});
			plugins = with pkgs.obs-studio-plugins; [
				wlrobs
				obs-backgroundremoval
				obs-pipewire-audio-capture
			];
		};

		home.stateVersion = "24.11";

	};

}
