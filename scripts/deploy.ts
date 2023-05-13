import { ethers } from "hardhat";

async function main() {
  console.log("Start deploy contract balanceImpl");
  const BalanceImpl = await ethers.getContractFactory("BalanceImpl");
  const balanceImpl = await BalanceImpl.deploy();
  await balanceImpl.deployed();
  console.log(`End deploy contract BalanceImpl. the balanceImpl's address is: ${balanceImpl.address}`);

  console.log("Start deploy contract BalanceProxy");
  const BalanceProxy = await ethers.getContractFactory("BalanceProxy");
  const balanceProxy = await BalanceProxy.deploy(balanceImpl.address);
  await balanceProxy.deployed();
  console.log(`End deploy BalanceProxy contract. This BalanceProxy's address is ${balanceProxy.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
