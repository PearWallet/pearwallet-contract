// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/SignatureChecker.sol";
import "../interface/IGuardianControl.sol";
import "../core/SenderCreator.sol";
import "../Storage.sol";

contract GuardianControl is IGuardianControl {
    using Storage for Storage.Layout;
    using ECDSA for bytes32;

    struct GuardianCallData {
        bytes signature;
        bytes initCode;
    }

    SenderCreator private immutable senderCreator = new SenderCreator();

    /**
     * @dev decode guardian call data (data in signature)
     */
    function decodeGuardianCallData(
        bytes memory guardianCallData
    ) internal pure returns (GuardianCallData memory) {
        (bytes memory _signature, bytes memory _initCode) = abi.decode(
            guardianCallData,
            (bytes, bytes)
        );
        return GuardianCallData(_signature, _initCode);
    }

    /**
     * @dev get guardian info
     * @return (address [], address, address,uint64,uint32) : (current guardian now, wallet, guardian next,`guardian next` effective time, guardian delay)
     */
    function getGuardianInfo()
        public
        view
        returns (address[] memory, address, address, uint64, uint32)
    {
        GuardianLayout memory l = Storage.layout().guardian;
        return (
            l.guardians,
            l.wallet,
            l.pendingGuardian,
            l.activateTime,
            l.guardianDelay
        );
    }
    function addGuardian() public {

    }
}
