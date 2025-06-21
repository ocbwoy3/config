import { homedir } from "os";
const API_URL = "https://api.e-z.host/files";

/**
 * Uploads a PNG image to e-z and returns the embed URL.
 * Throws an error if the file is not a PNG.
 *
 * @param content Image content as a Buffer
 * @returns The uploaded image's URL
 */
export async function UploadToEZ(content: Buffer): Promise<string> {
	if (!process.env.EZ_API_KEY) {
		throw new Error(`Missing \`EZ_API_KEY\`, make sure you're loading the env from \`${homedir()}/.ocbwoy3-dotfiles-SECRET-DO-NOT-TOUCH.env\`!`)
	}

	if (!(content[0] === 0x89 && content[1] === 0x50 && content[2] === 0x4e)) {
		throw new Error("File is not a PNG.");
	}

	const form = new FormData();
	form.append(
		"file",
		new Blob([content], { type: "image/png" }),
		"screenshot.png"
	);

	const res = await fetch(API_URL, {
		method: "POST",
		headers: {
			key: process.env.EZ_API_KEY,
		},
		body: form,
	});

	if (!res.ok) {
		throw new Error(
			`Upload failed with status ${res.status}: ${await res.text()}`
		);
	}

	const json = await res.json();

	if (!json.imageUrl) {
		console.warn(json);
		throw new Error("Malformed response from e-z.gg");
	}

	/*
	api response
	{
		success: true,
		message: "File Uploaded",
		imageUrl: "https://oc3.typescript.love/📸/something.png",
		rawUrl: "https://r2.e-z.host/something/something.png",
		deletionUrl: "https://api.e-z.host/files/delete?key=something",
	}
	
	*/

	return json.imageUrl;
}
