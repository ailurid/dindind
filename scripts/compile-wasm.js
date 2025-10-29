import {spawn} from "node:child_process";
import path from "node:path";
import {cwd} from "node:process";

const currentDir = cwd();
console.log(`Current directory: ${currentDir}`);

const run = spawn("docker", [
  "run",
  "--rm",
  "-v",
  `${path.normalize(
    path.join(
      currentDir,
      // "..",
      "lib"
    )
  )}:/src`,
  "emscripten/emsdk:latest",
  "./build.sh"
]);

run.stdout.on("data", (data) => {
  console.log(`stdout: ${data}`);
});

run.stderr.on("data", (data) => {
  console.error(`stderr: ${data}`);
});

run.on("close", (code) => {
  console.log(`child process exited with code ${code}`);
});
