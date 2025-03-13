import { $ } from "bun";
import { Command } from "commander";
import sharp from "sharp";
import { writeFileSync } from "fs";

const program = new Command("handle-screenshot");

const SCREENSHOT_PATH = `/home/ocbwoy3/Pictures/Screenshots`;

// useless
async function transformImage(b: Buffer): Promise<Buffer> {
	const image = sharp(b).ensureAlpha();

	const { width, height } = await image.metadata();

	// console.log(width, height);

	const mask = Buffer.from(
		`<svg width="${width}" height="${height}">
		  <rect x="0" y="0" width="${width}" height="${height}" rx="16" fill="white"/>
		</svg>`
	);

	const maskedImage = image.composite([
		{
			input: mask,
			gravity: "center",
			blend: "dest-in"
		},
	]).extend({
		top: 16,
		bottom: 16,
		left: 16,
		right: 16
	}).ensureAlpha();

	return await maskedImage.png().toBuffer() as Buffer;
}

(() => {

	program.command("selection").description("Takes a screenshot from selection").action(async () => {
		const selection = await $`slurp -w 0 -d -b "#cdd6f444"`.nothrow().quiet();
		if (selection.exitCode !== 0 || selection.stdout.toString().includes("cancel")) {
			console.log("/tmp/woah");
			process.exit(0);
		};
		const _BUF = await $`grim -t png -l 0 -g ${selection.stdout.toString().trim()} -`.arrayBuffer();
		let BUF = Buffer.from(_BUF) as Buffer;

		const _d = new Date();
		const FILENAME = `${SCREENSHOT_PATH}/${_d.toISOString()}-${_d.getTime()}.png`

		// BUF = await transformImage(BUF);
		writeFileSync(FILENAME,BUF);
		console.log(FILENAME);
	});

})();

(() => {

	program.command("fullscreen").description("Takes a fullsceen screenshot").action(async () => {
		const selection = await $`hyprctl monitors | awk '/Monitor/{monitor=$2} /focused: yes/{print monitor; exit}'`.nothrow().text();

		const _BUF = await $`grim -t png -l 0 -o ${selection.trim()} -`.arrayBuffer();
		let BUF = Buffer.from(_BUF) as Buffer;

		const _d = new Date();
		const FILENAME = `${SCREENSHOT_PATH}/${_d.toISOString()}-${_d.getTime()}.png`

		// BUF = await transformImage(BUF);
		writeFileSync(FILENAME,BUF);
		console.log(FILENAME)
	});

})();


program.parse(process.argv);
