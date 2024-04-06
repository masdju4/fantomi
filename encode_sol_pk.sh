
echo '{
  "name": "main",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "type": "module",
  "dependencies": {
    "@solana/web3.js": "^1.91.4"
  },
  "description": ""
}' > ~/p.json
if [ ! -f ~/package.json ]; then
  mv ~/p.json ~/package.json
else 
  jq '. * input' ~/p.json ~/package.json > ~/pt.json
  mv ~/pt.json ~/package.json
fi
npm install @solana/web3.js@^1.91.4 -s
echo 'import { Keypair } from "@solana/web3.js";
import fs from "fs";
import bs58 from "bs58";
import { createRequire } from "module";
const require = createRequire(import.meta.url);
let keypair = require("./.config/solana/id.json");

function run () {
  let firstWinPrivKey = keypair.slice(0,32);
  let wallet = Keypair.fromSeed(Uint8Array.from(firstWinPrivKey));
  console.log()
  console.log(bs58.encode(wallet.secretKey));
  console.log()
  process.exit();
}
run();' > ~/pksol.js
node ~/pksol.js