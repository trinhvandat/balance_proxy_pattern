import { ethers } from 'hardhat';
import { expect } from 'chai';
import { Contract, ContractFactory } from 'ethers';

describe("Balance proxy test", function () {
    let BalanceImpl: ContractFactory;
    let BalanceProxy: ContractFactory;
    let balanceImpl: Contract;
    let balanceProxy: Contract;
    let proxiedBalanceImpl: Contract;

    beforeEach(async function () {
        BalanceImpl = await ethers.getContractFactory('BalanceImpl');
        BalanceProxy = await ethers.getContractFactory('BalanceProxy');

        balanceImpl = await BalanceImpl.deploy();
        await balanceImpl.deployed();

        balanceProxy = await BalanceProxy.deploy(balanceImpl.address);
        await balanceProxy.deployed();

        proxiedBalanceImpl = BalanceImpl.attach(balanceProxy.address);
    });

    it('should add balance correctly', async function() {
        await proxiedBalanceImpl.add(50);
        const balance = await proxiedBalanceImpl.getBalance();
        expect(balance).to.equal(50);
    });
});
