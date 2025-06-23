import { $ } from "bun";
import { configDotenv } from "dotenv";
import { homedir } from "os";
import { readdirSync, readFileSync, statSync } from "fs";
import { join } from "path";
import { setConsoleTitle } from "@ocbwoy3/libocbwoy3";
import { UploadToEZ } from "../lib/EZUploader";

setConsoleTitle("Screenshot Uploader");

try {
	const start = Date.now();
	$`notify-send -t 1000 "Screenshot" "Uploading.."`.nothrow().catch(a => { });
	configDotenv({
		path: `${homedir()}/.ocbwoy3-dotfiles-SECRET-DO-NOT-TOUCH.env`
	});

	const screenshotsDir = join(homedir(), "Pictures", "Screenshots");
	const files = readdirSync(screenshotsDir);

	let latestFile = files
		.map(file => ({
			file,
			time: statSync(join(screenshotsDir, file)).mtime.getTime()
		}))
		.sort((a, b) => b.time - a.time)[0].file;

	const filePath = join(screenshotsDir, latestFile);

	const url = await UploadToEZ(readFileSync(filePath));

	$`echo "${url}" | wl-copy -n`.nothrow().catch(a => { });
	$`notify-send "Ekrānuzņēmums" "Augšuplādēts e-z.host ${Date.now() - start}ms"`.nothrow().catch(a => { });
} catch (e_) {
	$`notify-send "Kļūda" "${`${e_}`}"`.nothrow().catch(a => { });
}

