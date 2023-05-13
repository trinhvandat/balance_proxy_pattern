// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract BalanceProxy {
    bytes32 private constant BALANCE_IMPL_SLOT =
        keccak256("org.openzeppelin.proxy.implementation");

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
        bytes32 slot = BALANCE_IMPL_SLOT;
        assembly {
            sstore(slot, _balanceImpl)
        }
        balanceImpl = _balanceImpl;
    }
}
