import { $ } from "bun";
import { configDotenv } from "dotenv";
import { homedir } from "os";
import { readdirSync, readFileSync, statSync } from "fs";
import { join } from "path";
import { setConsoleTitle } from "@ocbwoy3/libocbwoy3";
import { UploadToEZ } from "../lib/EZUploader";
import { execSync } from "child_process";

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

	execSync(`echo "${url}" | wl-copy -n`);
	execSync(`notify-send "Ekrānuzņēmums" "Augšuplādēts e-z.host ${Date.now() - start}ms"`);
} catch (e_) {
	execSync(`notify-send "Kļūda" "${`${e_}`}"`);
}

