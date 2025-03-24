import { $, S3Client } from "bun";
import { configDotenv } from "dotenv";
import { homedir } from "os";
import { readdirSync, readFileSync, statSync } from "fs";
import { join } from "path";

try {
	configDotenv({
		path: `${homedir()}/.ocbwoy3-dotfiles-SECRET-DO-NOT-TOUCH.env`
	});

	const bucket = new S3Client({
		accessKeyId: process.env.S3_ACCESS_KEY,
		secretAccessKey: process.env.S3_SECRET_KEY,
		bucket: process.env.S3_BUCKET_NAME,
		endpoint: process.env.S3_ENDPOINT_URL,
	});

	const screenshotsDir = join(homedir(), "Pictures", "Screenshots");
	const files = readdirSync(screenshotsDir);

	const latestFile = files
		.map(file => ({
			file,
			time: statSync(join(screenshotsDir, file)).mtime.getTime()
		}))
		.sort((a, b) => b.time - a.time)[0].file;

	const filePath = join(screenshotsDir, latestFile);

	const start = Date.now();
	const file = bucket.file(latestFile)
	await file.write(readFileSync(filePath), {
		type: "image/png"
	})
	$`echo "https://i.darktru.win/${latestFile}" | wl-copy -n`.nothrow().catch(a => { });
	$`notify-send "Screenshot" "Uploaded in ${Date.now() - start}ms"`.nothrow().catch(a => { });
} catch (e_) {
	$`notify-send "Screenshot" "${`${e_}`}"`.nothrow().catch(a => { });
}

