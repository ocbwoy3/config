{ config, inputs, pkgs, ... }:

{
	
	# TODO:
	# Upload PDS backup to /var/lib/pds
	# and specify secrets in /private/atproto-pds.env

	services.pds = {
		enable = true;
		pdsadmin.enable = true;
		environmentFiles = [ "/private/atproto-pds.env" ];
		settings = {
			PDS_CRAWLERS = "https://bsky.network";
			LOG_ENABLED = "true";
			PDS_HOSTNAME = "pds.darktru.win";
			PDS_VERSION = "i use nix btw";
			PDS_DID_PLC_URL = "https://plc.directory";
			PDS_CONTACT_EMAIL_ADDRESS = "ocbwoy3@ocbwoy3.dev";
			PDS_PRIVACY_POLICY_URL = "https://ocbwoy3.dev";
			PDS_TERMS_OF_SERVICE_URL = "https://ocbwoy3.dev";
			PDS_ACCEPTING_REPO_IMPORTS = "true";
		};

	};

}
