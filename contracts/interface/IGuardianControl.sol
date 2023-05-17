// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @dev Interface of the GuardianControl
 */
interface IGuardianControl {
    struct GuardianLayout {
        // the list of guardians
        address[] guardians;
        // wallet
        address wallet;
        // guardian next
        address pendingGuardian;
        // `guardian next` effective time
        uint64 activateTime;
        // guardian delay
        uint32 guardianDelay;
        uint256[50] __gap;
    }
    /**
     * @dev Emitted when `guardian` is set. ( Just added, not yet reached the activate time )
     */
    event GuardianSet(address guardian, address wallet, uint64 activateTime);

    /**
     * @dev Emitted when `guardian` is confirmed. ( Initialize or reached the activate time )
     */
    event GuardianConfirmed(address guardian, address previousGuardian);

    /**
     * @dev Emitted when `guardian` is canceled. ( Cancel before reached the activate time )
     */
    event GuardianCanceled(address guardian, address wallet);

    event GuardianRevoked(address guardian, address wallet);
}
