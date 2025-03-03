import fs from "fs";
import path from "path";
import { exec } from "child_process";

const stateFilePath = path.join(
	process.env.HOME || "~",
	".regretevator-challenge-state"
);

const regretevatorStateFile = path.join(
	process.env.HOME || "~",
	".regretevator_state"
);

if (fs.existsSync(regretevatorStateFile)) process.exit(0);

function sendReminderNotification() {
	exec(
		`notify-send -a "tuxstrap" -u low "OCbwoy3's Dotfiles" "It's time for Regretevator!"`
	);
}

function sendReminderNotificationPlayed(floors: number) {
	exec(
		`notify-send -a "tuxstrap" -u low "OCbwoy3's Dotfiles" "Man... Only ${floors} floors, really? You can do better than that."`
	);
}

function sendSpamNotifications() {
	for (let i = 0; i < 2; i++) {
		exec(
			`notify-send -a "tuxstrap" -u low "OCbwoy3's Dotfiles" "HURRY UP!!!!!"`
		);
	}
}

function writeState(floorsSurvived: number) {
	const state = {
		date: new Date().toLocaleString("en-CA", { timeZoneName: "short" }).split(",")[0],
		floors: floorsSurvived,
	};
	fs.writeFileSync(stateFilePath, JSON.stringify(state, null, 2));
}

function checkChallengeState() {
	if (fs.existsSync(stateFilePath)) {
		const state = JSON.parse(fs.readFileSync(stateFilePath, "utf-8"));
		const today = new Date().toLocaleString("en-CA", { timeZoneName: "short" }).split(",")[0];
		const stateDate = state.date;
		const floorsSurvived = state.floors;

		const now = new Date();
		const hoursLeft = 24 - now.getHours();

		if (stateDate === today) {
			if (floorsSurvived < 25) {
				/*
				if (floorsSurvived === 0) {
					sendReminderNotification();
				} else {
					sendReminderNotificationPlayed(floorsSurvived);
				}
				if (hoursLeft <= 4) {
					sendSpamNotifications();
				}
			       */
			      sendReminderNotification();
			}
		} else {
			sendReminderNotification();
			writeState(0);
		}
	} else {
		sendReminderNotification();
		writeState(0);
	}
}

// Run the check
checkChallengeState();
