import { $, S3Client } from "bun";
import { configDotenv } from "dotenv";
import { homedir } from "os";
import { readdirSync, readFileSync, statSync } from "fs";
import { join } from "path";
import { setConsoleTitle } from "@ocbwoy3/libocbwoy3";

setConsoleTitle("R2 Uploader");

try {
	const start = Date.now();
	$`notify-send -t 1000 "Screenshot" "Uploading.."`.nothrow().catch(a => { });
	configDotenv({
		path: `${homedir()}/.ocbwoy3-dotfiles-SECRET-DO-NOT-TOUCH.env`
	});

	const bucket = new S3Client({
		accessKeyId: process.env.S3_ACCESS_KEY,
		secretAccessKey: process.env.S3_SECRET_KEY,
		bucket: process.env.S3_BUCKET_NAME,
		endpoint: process.env.S3_ENDPOINT_URL,
	});

	let urlParams = "";

	const screenshotsDir = join(homedir(), "Pictures", "Screenshots");
	const files = readdirSync(screenshotsDir);

	let latestFile = files
		.map(file => ({
			file,
			time: statSync(join(screenshotsDir, file)).mtime.getTime()
		}))
		.sort((a, b) => b.time - a.time)[0].file;

	const filePath = join(screenshotsDir, latestFile);

	let [ _, regretevator, floorNum ] = latestFile.match(/\-(regretevator)\-?([0-9]+)?\.png$/) || [];

	// the devs changed rich presence, what's the point of parsing the filename if tuxstrap doesn't update the state file anymore? 
	if (regretevator === "regretevator") {
		latestFile = latestFile.replace(`-regretevator${floorNum ? `-${floorNum}` : ""}.png`,".png")
		// OR i could keep the filename and have my worker parse the filename
		if (floorNum) {
			urlParams = `?floor=${floorNum}`
		}
	}

	const file = bucket.file(latestFile)
	await file.write(readFileSync(filePath), {
		type: "image/png"
	})
	$`echo "https://i.darktru.win/${encodeURIComponent(latestFile)}${urlParams}" | wl-copy -n`.nothrow().catch(a => { });
	$`notify-send "Screenshot" "Uploaded in ${Date.now() - start}ms<br/><small>${latestFile}</small>"`.nothrow().catch(a => { });
} catch (e_) {
	const cx = `${e_}`.toLowerCase();
	if (cx.includes("enable r2") && cx.includes("cloudflare dashboard")) {
		$`notify-send "Cloudflare" "You owe Cloudflare money!! >:(<br/><small>${`${e_}`}</small>"`.nothrow().catch(a => { });
		process.exit(0);
	}
	$`notify-send "Screenshot" "${`${e_}`}"`.nothrow().catch(a => { });
}

