import { existsSync, readFileSync } from "fs";

const STATE_FILE_PATH = "/tmp/.regretevator_state";

type DeadUnknownState = { state: "DEAD" | "UNKNOWN" };

type InElevatorState = {
	floor: number;
	state: "INGAME";
	isGoingUp: boolean;
};

export type RegretevatorState = DeadUnknownState | InElevatorState;

/*

➜  config git:(main) ✗ cat /tmp/.regretevator_state
{"text":"ý 82","tooltip":"On Floor 82"}
➜  config git:(main) ✗ cat /tmp/.regretevator_state
{"text":"ý ","tooltip":"Floor 82  83"}

*/

export function getRegretevatorState(): null | RegretevatorState {
	if (!existsSync(STATE_FILE_PATH)) return null;
	try {
		const {text, tooltip}: { text: string, tooltip: string } = JSON.parse(readFileSync(STATE_FILE_PATH).toString('utf-8'))
		if (/^On Floor ([0-9]+)$/.test(tooltip)) {
			const floorNum = tooltip.match(/^On Floor ([0-9]+)$/)![1]
			return {
				floor: Number(floorNum),
				state: "INGAME",
				isGoingUp: false
			}
		}
		if (/^Floor ([0-9]+)/.test(tooltip)) {
			const floorNum = tooltip.match(/^Floor ([0-9]+)/)![1]
			return {
				floor: Number(floorNum),
				state: "INGAME",
				isGoingUp: true
			}
		}
		return {
			state: "UNKNOWN"
		}
	} catch {}
	return null;
}
