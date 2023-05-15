// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./interface/IEntryPoint.sol";
import "./interface/IGuardianControl.sol";
import "./interface/ILogicUpgradeControl.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";

library Storage {
    bytes32 private constant ACCOUNT_SLOT = keccak256("pearwallet.contracts.Storage");

    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }

    struct Layout {


        /// ┌───────────────────┐
        /// │     base data     │
        address owner;           // owner slot [unused]
        IEntryPoint entryPoint;  // entryPoint
        uint96 nonce;            //explicit sizes of nonce, to fit a single storage cell with "owner"
        uint256[50] __gap_0;
        /// └───────────────────┘



        /// ┌───────────────────┐
        /// │   upgrade data    │
        ILogicUpgradeControl.UpgradeLayout logicUpgrade;       // LogicUpgradeControl.sol
        Initializable.InitializableLayout initializableLayout;
        uint256[50] __gap_1;
        /// └───────────────────┘



        /// ┌───────────────────┐
        /// │     role data     │
        mapping(bytes32 => RoleData) roles;                       // AccessControl.sol
        mapping(bytes32 => EnumerableSet.AddressSet) roleMembers; // AccessControlEnumerable.sol
        uint256[50] __gap_2;
        /// └───────────────────┘



        /// ┌───────────────────┐
        /// │     guardian      │
        IGuardianControl.GuardianLayout guardian;     // GuardianControl.sol
        uint256[50] __gap_3;
        /// └───────────────────┘

        
    }

    function layout() internal pure returns (Layout storage l) {
        bytes32 slot = ACCOUNT_SLOT;
        assembly {
            l.slot := slot
        }
    }
}