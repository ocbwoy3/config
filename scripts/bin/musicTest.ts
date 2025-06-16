import { $ } from "bun";
import { setConsoleTitle } from "@ocbwoy3/libocbwoy3";
import { existsSync, readFileSync, writeFileSync } from "fs";

setConsoleTitle("Music Test");

try {
	const artUrl = await $`playerctl -s -p cider,OCbwoy3_s_iPhone metadata mpris:artUrl`.text();
	const title = await $`playerctl -s -p cider,OCbwoy3_s_iPhone metadata title`.text();
	const artist = await $`playerctl -s -p cider,OCbwoy3_s_iPhone metadata artist`.text();
	const album = await $`playerctl -s -p cider,OCbwoy3_s_iPhone metadata album`.text();
	

	const MT = `${artist.trim()},${album.trim()}`;

	if (!existsSync("/tmp/.musictest-info") || readFileSync("/tmp/.musictest-info").toString("utf-8") !== MT) {
		writeFileSync("/tmp/.musictest-info",MT)
	
		const x = await fetch(artUrl.trim())
		writeFileSync("/tmp/.musictest",await x.bytes())
	}

	$`notify-send ${title.trim()} ${artist.trim()} -i /tmp/.musictest`.nothrow().catch(a => { });
} catch (e_) {
	console.error(e_)
	$`notify-send "music test" "lol"`.nothrow().catch(a => { });
}
