
import {
  init, signer, uSetting, Interface, formatEther, logPath, getProvider,
  formatUnits, parseEther, chains, getError, AddressZero, appendFile,
  role, promptList, promptInput, delay
} from "./utils/index.js";
import { buyAmount, minLp, maxLp } from "./main/setting.js";
import { 
  getPairInfo, lpValPass, isBlacklisted, getTokenPair, getDexName,
  getTxInfo, getFactories, addRouter, isKnownDex, buyToken, getSwapData,
  addBlacklist, addSnipe, isBlacklisted1, getTokenBalance, addLimbe
} from "./helper/index.js";
let INewPair = new Interface(["event PairCreated(address indexed token0,address indexed token1,address pair,uint)"]);
let topic = "0x0d3648bd0f6ba80134a33ba9275ac585d9d315f0ad8355cddefde31afa28d0e9";
const lines = "===================================================";
let args = process.argv.slice(2);
if(!args[0]) {
  console.log(`Chain!!!`);
  process.exit();
}
let chain = args[0];
let provider;
let autoBlacklist = true;
let addToSnipe = false;
let autoLimbe = true;
let targetPercent = "100";
let snipeAmt;

export async function wuwu () {
  await init(chain);
  /*
  if (!uSetting[chain].buy_amount) await buyAmount(true);
  if (!uSetting[chain].min_lp) await minLp(true);
  if (!uSetting[chain].max_lp) await maxLp(true);
  
  if (role != "other") {
    await promptList("Auto Blacklist ?",["Yes","No"]).then(res => {
      if(res == "Yes") {
        autoBlacklist = true;
      }
    });
    await promptList("Add To Limbe ?",["Yes","No"]).then(async res => {
      if(res == "Yes") {
        autoLimbe = true;
        targetPercent = await promptInput(`Target % : `);
      }
    });
    
    await promptList(`Add To Snipe ?`,["Yes","No"]).then(async res => {
      if(res == "Yes") {
        addToSnipe = true;
        snipeAmt = await promptInput(`Snipe Amount ${chains[chain].symbol}`);
      }
    });
  }
  */
  let factories = (await getFactories()).filter(x => x != AddressZero);
  provider = getProvider();
  let filter = {
    address: null,
    topics: [topic]
  }
  console.clear();
  console.log(`Started...`);
  provider.on(filter, async (logs) => {
    let data = INewPair.parseLog({
      data: logs.data,
      topics: logs.topics
    });
    let token0 = data.args.token0.toLowerCase();
    let token1 = data.args.token1.toLowerCase();
    let pairAddress = data.args.pair;
    let [
      lpInfo,
      [lpProvider, router, blacklisted]
    ] = await Promise.all([
      getPairInfo(pairAddress),
      getTxInfo(logs.transactionHash)
    ]).catch(e => {
      return [{},new Array(3)];
    });
    if(Object.keys(lpInfo).length > 1) {
    let [res0,res1,] = lpInfo.reserves;
    let [token,pair] = getTokenPair(token0,token1);
    let msg = `\n${lpInfo.name ? lpInfo.name : null}\nToken 0    : ${token0}\nToken 1    : ${token1}\nLp Address : ${pairAddress}\nLiquidity  : ${formatUnits(res0,lpInfo.token0.decimals)} ${lpInfo.token0.symbol}\n             ${formatUnits(res1,lpInfo.token1.decimals)} ${lpInfo.token1.symbol}\nDex        : ${getDexName(router)}\nValue      : ${formatEther(lpInfo.value)} ${chains[chain].symbol}\nBL         : ${blacklisted ? "🔴" : "🟢"}\n`;
    console.log(msg);
    if(addToSnipe && lpInfo.value.isZero()) {
      addSnipe(
        snipeAmt,
        token,
        token.toLowerCase() == lpInfo.token0.address.toLowerCase() ?
        lpInfo.token0.symbol : lpInfo.token1.symbol
      );
    }
    if(lpValPass(lpInfo.value) && !blacklisted) {
      let success = await buyToken(getSwapData(
        parseEther(uSetting[chain].buy_amount),
        token,
        pair,
        pairAddress,
        0,
        signer.address,
        "buy"
      )).catch(e => {
        console.log(getError(e));
        return false;
      });
      if(success) {
        msg = `${msg}✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅\n\n`;
        if(!isKnownDex(logs.address,factories)) {
          addRouter(router);
          factories = (await getFactories()).filter(x => x != AddressZero);
        }
        if(autoLimbe) {
          await delay(2000);
          let tokenBalance = await getTokenBalance(token,signer.address);
          let [tokenSymbol,tokenDecimals] = token.toLowerCase() == lpInfo.token0.address.toLowerCase() ? [lpInfo.token0.symbol, lpInfo.token0.decimals] : [lpInfo.token1.symbol, lpInfo.token1.decimals];
          let limbeData = {
            token: token,
            symbol: tokenSymbol,
            decimals: tokenDecimals,
            balance: formatUnits(tokenBalance,tokenDecimals),
            amount: formatUnits(tokenBalance,tokenDecimals),
            target: (Number(uSetting[chain].buy_amount) + (Number(uSetting[chain].buy_amount) * Number(targetPercent) / 100)).toString(),
            continues: false
          }
          addLimbe(limbeData);
        }
      }
      if(autoBlacklist) {
        addBlacklist(lpProvider);
      }
    }
    appendFile(`${logPath.wuwu}${chain}`,msg);
    console.log(lines);
    }
  });
}
wuwu();