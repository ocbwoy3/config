#!/run/current-system/sw/bin/bun

import { $ } from "bun";
import { execSync } from "child_process";

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
	const j = day % 10;
	const k = day % 100;
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
	
	"Keep on ricing yo' Hyprland...",

	"Contains infinite genders!",
	"You are valid!",

	"Blogsy is so AWESOME!",
	"I love Blogsy!",
	"What’s yer favorite type o’ wood?",
];

const debug: boolean = false as false | true;

if (debug === true) {
	splashes.forEach(async (a) => {
		execSync(`notify-send "Sveicināti Hyprland!" "${a}"`);
	});
} else {
	const randomSplash = chooseRandom(splashes);

	execSync(`notify-send "Sveicināti Hyprland!" "${randomSplash}"`);
}
