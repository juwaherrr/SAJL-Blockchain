// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/// @title AttestationHub (minimal stub for Sprint 2)
/// @notice Stores validator attest/revoke for a tokenId (e.g., an artifact/NFT)
contract AttestationHub {
    // --- simple ownership ---
    address public owner;
    modifier onlyOwner() { require(msg.sender == owner, "not owner"); _; }

    constructor() { owner = msg.sender; }

    // --- validator whitelist ---
    mapping(address => bool) public isValidator;
    event ValidatorAdded(address validator);
    event ValidatorRemoved(address validator);

    function addValidator(address validator) external onlyOwner {
        require(validator != address(0), "zero addr");
        isValidator[validator] = true;
        emit ValidatorAdded(validator);
    }

    function removeValidator(address validator) external onlyOwner {
        isValidator[validator] = false;
        emit ValidatorRemoved(validator);
    }

    // --- attestations ---
    struct Attestation {
        bool isAttested;         // true = attested, false = revoked/not attested
        address by;              // last validator who changed it
        uint64 updatedAt;        // unix time
    }

    // tokenId => validator => attestation
    mapping(uint256 => mapping(address => Attestation)) private _attestations;

    event Attested(uint256 indexed tokenId, address indexed validator, bool attested);

    modifier onlyValidator() { require(isValidator[msg.sender], "not validator"); _; }

    /// @notice Validator attests authenticity for tokenId
    function attest(uint256 tokenId) external onlyValidator {
        _attestations[tokenId][msg.sender] = Attestation(true, msg.sender, uint64(block.timestamp));
        emit Attested(tokenId, msg.sender, true);
    }

    /// @notice Validator revokes authenticity for tokenId
    function revoke(uint256 tokenId) external onlyValidator {
        _attestations[tokenId][msg.sender] = Attestation(false, msg.sender, uint64(block.timestamp));
        emit Attested(tokenId, msg.sender, false);
    }

    /// @notice Returns if ANY validator currently attests tokenId
    function isAuthentic(uint256 tokenId) external view returns (bool) {
        // naive OR over validators is not stored; for Sprint 2, front-end can
        // query per-validator via getAttestation and aggregate. Keep it simple.
        return false; // stubbed aggregate
    }

    /// @notice Read a specific validator’s attestation on tokenId
    function getAttestation(uint256 tokenId, address validator)
        external
        view
        returns (bool attested, address by, uint64 updatedAt)
    {
        Attestation memory a = _attestations[tokenId][validator];
        return (a.isAttested, a.by, a.updatedAt);
    }
}
