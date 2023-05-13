// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract BalanceProxy {
    address private balanceImpl;

    constructor(address _balanceImpl) {
        setBalanceImpl(_balanceImpl);
    }

    fallback() external payable {
        delegateToImpl(balanceImpl);
    }

    function delegateToImpl(address _balanceImpl) internal {
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(
                gas(),
                _balanceImpl,
                0,
                calldatasize(),
                0,
                0
            )
            returndatacopy(0, 0, returndatasize())

            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }

    function setBalanceImpl(address _balanceImpl) private {
        balanceImpl = _balanceImpl;
    }
}
