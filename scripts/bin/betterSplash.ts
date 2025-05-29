#!/run/current-system/sw/bin/bun

import { $ } from "bun";

const birthday = new Date(2009, 7, 16);
const age = Math.floor(
	(Date.now() - birthday.getTime()) / (1000 * 60 * 60 * 24 * 365)
);

const isBirthday =
	birthday.getDate() === new Date().getDate() &&
	birthday.getMonth() === new Date().getMonth();

const isLatvian = Intl.DateTimeFormat()
	.resolvedOptions()
	.timeZone.startsWith("Europe/Riga");

function getOrdinalSuffix(day: number): string {
	const j = day % 10,
		k = day % 100;
	if (j === 1 && k !== 11) return "st";
	if (j === 2 && k !== 12) return "nd";
	if (j === 3 && k !== 13) return "rd";
	return "th";
}

// chatgpt
function chooseRandom(array: string[]): string {
	if (isBirthday)
		return `Is it your ${age}${getOrdinalSuffix(age)} birthday?`;

	if (array.length === 0) throw new Error("lol");
	const index =
		crypto.getRandomValues(new Uint32Array(4)).reduce((a, b) => a + b) %
		array.length;
	return array[index];
}

const splashes = [
	
	"Keep on ricing yo' Hyprland",
	"Let's make today even better!",

	"\"iUseNixBTW\" You literally... Roblox?",
	"is it just me or the arch/nix pipeline turned me into a closeted femboy?",
	"the nix pipeline is real",
	
	"Anti-OCbwoy3-ifier MV2 Premium.xpi",

	"Do crabs think fish are flying?",
	"Don't forget to water your thoughts.",
	"Fox detected. Please pet gently.",

	// Venting ones
	
	"mount /dev/boyfriend ~",
	isLatvian
		? "Latvia.. I hate it here, I wanna move." /* extremely accurate unbiased content coming from a latvian himself */
		: "NOT going back Latvia.",
	"rm -rf ~",

	// Minecraft (DEI ones)

	"Amplify and listen to BIPOC voices!",
	"Support the BIPOC community and creators!",
	"Contains infinite genders!",
	"Remember to use gender neutral pronouns!",
	"You are valid!",
	"I'm glad you're here!",
	"You are welcome here!",
	"Your gender is valid!",

	// Regretevator ones

	"dr! ar u sure i cant drink 20 blogsy's??",
	"That subway wuz so dark! Can't have a party withowt silly litez!",
	"Blogsy is so AWESOME!",
	"My life is liek a video game i think",

	"What’s yer favorite type o’ wood?",
	"Everybody knows th’ best kind o’ buildin’ is made outta grit and woodwork!",

	// Me IRL

	"tfw Hyprland boots faster than I do",
	"everyone gangsta till your free trial of life ends",

	// Reality
	
	"flake 'flake:self' does not provide attribute 'willpower'",
	"copilot stop writing my thoughts",
	"404: purpose not found",
	"respawn button greyed out",
	"you’ve reached the end of the existential demo",
	"feeling like an empty JSON object"

];

const debug: boolean = false as false | true;

if (debug === true) {
	splashes.forEach(async (a) => {
		await $`notify-send "Welcome to Hyprland!" "${a}"`;
	});
} else {
	const randomSplash = chooseRandom(splashes);

	await $`notify-send "Welcome to Hyprland!" "${randomSplash}"`;
}
