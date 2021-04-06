import svelte from "rollup-plugin-svelte";
import commonjs from "@rollup/plugin-commonjs";
import resolve from "@rollup/plugin-node-resolve";
import livereload from "rollup-plugin-livereload";
import { terser } from "rollup-plugin-terser";
import typescript from "@rollup/plugin-typescript";
import css from "rollup-plugin-css-only";
import postcss from "rollup-plugin-postcss";

import sveltePreprocess from "svelte-preprocess";

const production = !process.env.ROLLUP_WATCH;

function serve() {
	let server;

	function toExit() {
		if (server) server.kill(0);
	}

	return {
		writeBundle() {
			if (server) return;
			server = require("child_process").spawn(
				"npm",
				["run", "start", "--", "--dev"],
				{
					stdio: ["ignore", "inherit", "inherit"],
					shell: true,
				}
			);

			process.on("SIGTERM", toExit);
			process.on("exit", toExit);
		},
	};
}

export default {
	input: "src/main.ts",
	output: {
		sourcemap: true,
		format: "iife",
		name: "app",
		file: "public/build/bundle.js",
	},
	plugins: [
		svelte({
			preprocess: sveltePreprocess({ sourceMap: !production }),
			compilerOptions: {
				dev: !production,
			},
		}),

		css({ output: "components.css" }),

		resolve({
			browser: true,
			dedupe: ["svelte"],
		}),
		commonjs(),

		postcss({
			extract: true,
			minimize: true,
			use: [
				[
					"sass",
					{
						includePaths: ["./theme", "./node_modules"],
					},
				],
			],
		}),

		typescript({
			sourceMap: !production,
			inlineSources: !production,
		}),

		!production && serve(),

		!production && livereload("public"),

		production && terser(),
	],
	watch: {
		clearScreen: false,
	},
};
