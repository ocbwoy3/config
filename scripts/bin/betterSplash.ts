#!/run/current-system/sw/bin/bun

import { $ } from "bun";

const splashes = [
	
	"not ben shaped pear-o",

	"\"I use Nix, btw!\" - OCbwoy3",
	"I use Nix, btw!",
	"Nix beats arch",

	"You like kissing boys, don't you?",

	"Now with gay furries :3",
	"Now with femboys :3",
	
];

const debug: boolean = false as false | true;

if (debug === true) {
	splashes.forEach(async(a)=>{
		await $`notify-send "Welcome to... your PC?" "${a}"`;
	})
} else {
	const randomSplash = splashes[Math.floor(Math.random() * splashes.length)];
	
	await $`notify-send "Welcome to... your PC?" "${randomSplash}"`;
}

