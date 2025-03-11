{
	disko.devices = {
		disk = {
			main = {
				type = "disk";
				device = "/dev/disk/by-diskseq/1";
				content = {
					type = "gpt";
					partitions = {
						ESP = {
							priority = 1;
							name = "ESP";
							start = "1M";
							end = "1G";
							type = "EF00";
							content = {
								type = "filesystem";
								format = "vfat";
								mountpoint = "/boot";
								mountOptions = [ "umask=0077" ];
							};
						};
						root = {
							size = "100%";
							content = {
								type = "btrfs";
								extraArgs = [ "-f" ]; # Override existing partition
								# Subvolumes must set a mountpoint in order to be mounted,
								# unless their parent is mounted
								subvolumes = {
									# Subvolume name is different from mountpoint
									"/root" = {
										mountpoint = "/";
									};
									# Subvolume name is the same as the mountpoint
									"/home" = {
										mountOptions = [ "compress=zstd" ];
										mountpoint = "/home";
									};
									"/nix" = {
										mountOptions = [
											"compress=zstd"
											"noatime"
										];
										mountpoint = "/nix";
									};
									"/swap" = {
										mountpoint = "/swap";
										swap = {
											swapfile.size = "20M";
											swapfile2.size = "20M";
											swapfile2.path = "rel-path";
										};
									};
								};

								mountpoint = "/partition-root";
								swap = {
									swapfile = {
										size = "20M";
									};
									swapfile1 = {
										size = "20M";
									};
								};
							};
						};
					};
				};
			};
		};
	};
}