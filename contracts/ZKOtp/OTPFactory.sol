// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.12;

import "./OTP.sol";

abstract contract OTPFactory is OTP {
    OTP[] private _otps;

    event ContractCreated(address newAddress);

    function createOTP(address _verifier, uint256 merkleRoot) public {
        OTP otp = new OTP(_verifier, merkleRoot);
        _otps.push(otp);
        emit ContractCreated(address(otp));
    }
}