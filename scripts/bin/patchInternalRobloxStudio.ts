import { promises as fs } from "fs";
import * as path from "path";
import * as os from "os";
import { setConsoleTitle } from "@ocbwoy3/libocbwoy3";

setConsoleTitle("Roblox Studio patcher");

const SIGNATURE = Buffer.from([
	0x48, 0x81, 0xEC, 0x40, 0x03, 0x00, 0x00, 0x84, 0xD2, 0x74, 0x05, 0xE8
]);

const PATCH = Buffer.from([
	0x48, 0x81, 0xEC, 0x40, 0x03, 0x00, 0x00, 0x84, 0xD2, 0x90, 0x90, 0xE8
]);

const baseDir = path.join(
	os.homedir(),
	".var/app/org.vinegarhq.Vinegar/data/vinegar/versions"
);

function findSignature(buffer: Buffer, signature: Buffer): number {
	const sigLen = signature.length;
	for (let i = 0; i <= buffer.length - sigLen; i++) {
		let match = true;
		for (let j = 0; j < sigLen; j++) {
			if (buffer[i + j] !== signature[j]) {
				match = false;
				break;
			}
		}
		if (match) return i;
	}
	return -1;
}

async function patchFile(folder: string) {
	const exePath = path.join(folder, "RobloxStudioBeta.exe");

	let binary: Buffer;
	try {
		binary = await fs.readFile(exePath);
	} catch (err) {
		console.error(`[ERROR] Could not read ${exePath}/RobloxStudioBeta.exe:`, err);
		return;
	}

	if (findSignature(binary, PATCH)) {
		console.log(`[SKIP] ${folder}/RobloxStudioBeta.exe has already been patched`);
		return;
	}

	const offset = findSignature(binary, SIGNATURE);
	if (offset === -1) {
		console.error(`[FAIL] Signature not found in ${exePath}/RobloxStudioBeta.exe`);
		return;
	}

	// Apply patch
	PATCH.copy(binary, offset);
	try {
		await fs.writeFile(exePath, binary);
		console.log(`[PATCHED] Patched ${exePath}/RobloxStudioBeta.exe`);
	} catch (err) {
		console.error(`[ERROR] Failed to write patched file:`, err);
	}
}

async function main() {
	const folders: string[] = [];

	try {
		const entries = await fs.readdir(baseDir, { withFileTypes: true });
		for (const entry of entries) {
			if (entry.isDirectory()) {
				folders.push(path.join(baseDir, entry.name));
			}
		}
	} catch (err) {
		console.error(`[ERROR] Failed to list folders in ${baseDir}:`, err);
		return;
	}

	console.log(`[INFO] Found ${folders.length} version folders.`);

	const start = Date.now();
	await Promise.all(folders.map(patchFile));
	console.log(
		`[DONE] Patched internal Roblox Studio in ${Date.now() - start}ms`
	);
}

main();
