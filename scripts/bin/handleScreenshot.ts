import { $ } from "bun";
import { Command } from "commander";
// import sharp from "sharp";
import { writeFileSync } from "fs";
import { getRegretevatorState } from "../lib/RegretevatorUtil";

/*

	yeucc i swear to fucking god...

	{"text":"ý 999","tooltip":"Regretevator: Floor streak 999"}

	NOTE: ý turns into the regretevator icon when using DotfilesFont 

	====

	[BloxstrapRPC] {"command":"SetRichPresence","data":{"details":"REGRETEVATOR","smallImage":{"hoverText":"The Axolotl Sun","assetId":14648053922},"state":"","largeImage":{"hoverText":"THE REGRET ELEVATOR"}}}

	InGame | details === "REGRETEVATOR"; smallImage?.hoverText === "The Axolotl Sun";

	====

	[BloxstrapRPC] {"command":"SetRichPresence","data":{"state":"Lounging in the lobby","timeStart":0,"timeEnd":0}}

	InGame[Lobby] | state === "Lounging in the lobby";
	
	====

	[BloxstrapRPC] {"command":"SetRichPresence","data":{"state":"Currently spectating ELEVATOR_CAM"}}

	InGame[Spectating] | state matches regex /$Currently spectating (.*)$/, if so, SpectateName=$1;

	====

	[BloxstrapRPC] {"command":"SetRichPresence","data":{"details":"Going up!","state":"Floor streak 348","timeStart":1749325817,"timeEnd":1749325839}}

	InGame[GoingUp] | details === "Going up!"; state matches regex /^Floor streak ([0-9]+)$/, if so, FloorStreak=$1;

	====

	[BloxstrapRPC] {"command":"SetRichPresence","data":{"details":"At Funny Maze","state":"Floor streak 348","timeStart":0,"timeEnd":0}}

	InGame[AtFloor] | details match regex /^At (.+)$/, if so, FloorName=$1; state matches regex  /^Floor streak ([0-9]+)$/, if so, FloorStreak=$1;

	====

	TODO: Bring back `features/RegretevatorWaybar.ts` to TuxStrap

*/

async function getFilename(): Promise<string> {
	const _d = new Date();
	const windowClass = await $`hyprctl activewindow -j`.json();
	let ic = windowClass.initialClass || "Hyprland";
	const isRoblox = windowClass.initialClass === "org.vinegarhq.Sober";
	if (isRoblox) {ic = "Roblox"; };
	const regretevatorState = isRoblox ? getRegretevatorState() : null;
	if (!!regretevatorState) {ic = "Regretevator";};
	// console.log(isRoblox, regretevatorState)
	return `${ic}-${_d.getTime()}${
		!regretevatorState
			? ""
			: `-regretevator${
					regretevatorState.state === "INGAME"
						? `-${regretevatorState.floor}`
						: ""
			  }`
	}`;
}

const program = new Command("handle-screenshot");

const SCREENSHOT_PATH = `/home/ocbwoy3/Pictures/Screenshots`;

// useless
async function transformImage(b: Buffer): Promise<Buffer> {
	/*
	const image = sharp(b).ensureAlpha();

	const { width, height } = await image.metadata();

	// console.log(width, height);

	const mask = Buffer.from(
		`<svg width="${width}" height="${height}">
          <rect x="0" y="0" width="${width}" height="${height}" rx="16" fill="white"/>
        </svg>`
	);

	const maskedImage = image
		.composite([
			{
				input: mask,
				gravity: "center",
				blend: "dest-in",
			},
		])
		.extend({
			top: 16,
			bottom: 16,
			left: 16,
			right: 16,
		})
		.ensureAlpha();

	return (await maskedImage.png().toBuffer()) as Buffer;
	*/
	return b
}

(() => {
	program
		.command("selection")
		.description("Takes a screenshot from selection")
		.action(async () => {
			const selection = await $`slurp -w 0 -d -b "#cdd6f444"`
				.nothrow()
				.quiet();
			if (
				selection.exitCode !== 0 ||
				selection.stdout.toString().includes("cancel")
			) {
				console.log("/tmp/woah");
				process.exit(0);
			}
			const _BUF = await $`grim -t png -l 0 -g ${selection.stdout
				.toString()
				.trim()} -`.arrayBuffer();
			let BUF = Buffer.from(_BUF) as Buffer;

			const FILENAME = `${SCREENSHOT_PATH}/${await getFilename()}.png`;

			// BUF = await transformImage(BUF);
			writeFileSync(FILENAME, BUF);
			console.log(FILENAME);
		});
})();

(() => {
	program
		.command("fullscreen")
		.description("Takes a fullsceen screenshot")
		.action(async () => {
			const selection =
				await $`hyprctl monitors | awk '/Monitor/{monitor=$2} /focused: yes/{print monitor; exit}'`
					.nothrow()
					.text();

			const _BUF =
				await $`grim -t png -l 0 -o ${selection.trim()} -`.arrayBuffer();
			let BUF = Buffer.from(_BUF) as Buffer;

			const FILENAME = `${SCREENSHOT_PATH}/${await getFilename()}.png`;

			// BUF = await transformImage(BUF);
			writeFileSync(FILENAME, BUF);
			console.log(FILENAME);
		});
})();

program.parse(process.argv);
