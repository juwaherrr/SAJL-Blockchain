// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract SajlRegistry {
    struct Artifact {
        string contentHash;    // e.g., IPFS hash string
        string proposedHash;   // pending update
        bool isActive;         // can be deactivated
        bool isPublic;         // visibility flag
        uint8 approvals;       // approvals collected for the pending update
    }

    uint256 public nextId;
    mapping(uint256 => Artifact) public artifacts;
    mapping(uint256 => mapping(address => bool)) public approvedBy;

    // hardcode a tiny “family list” for the PoC (you’ll swap to real lists later)
    mapping(address => bool) public isFamily;
    uint8 public threshold = 2; // PoC: need 2 approvals

    event ArtifactCreated(uint256 indexed id, string hash, address creator);
    event UpdateProposed(uint256 indexed id, string newHash);
    event Approved(uint256 indexed id, address approver, uint8 approvals);
    event Finalized(uint256 indexed id, string newHash);
    event VisibilityChanged(uint256 indexed id, bool isPublic);
    event Deactivated(uint256 indexed id);

    constructor(address f1, address f2, address f3) {
        // three family members for demo
        isFamily[f1] = true; isFamily[f2] = true; isFamily[f3] = true;
    }

    modifier onlyFamily() {
        require(isFamily[msg.sender], "not family");
        _;
    }

    function createArtifact(string calldata hash) external onlyFamily {
        uint256 id = nextId++;
        artifacts[id] = Artifact({
            contentHash: hash,
            proposedHash: "",
            isActive: true,
            isPublic: false,
            approvals: 0
        });
        emit ArtifactCreated(id, hash, msg.sender);
    }

    function proposeUpdate(uint256 id, string calldata newHash) external onlyFamily {
        require(artifacts[id].isActive, "inactive");
        artifacts[id].proposedHash = newHash;
        artifacts[id].approvals = 0;
        // reset who approved
        // (simple PoC reset: rely on newHash change; full version would clear mapping)
        emit UpdateProposed(id, newHash);
    }

    function approveUpdate(uint256 id) external onlyFamily {
        require(bytes(artifacts[id].proposedHash).length != 0, "no proposal");
        require(!approvedBy[id][msg.sender], "already approved");
        approvedBy[id][msg.sender] = true;
        artifacts[id].approvals += 1;
        emit Approved(id, msg.sender, artifacts[id].approvals);
    }

    function finalizeUpdate(uint256 id) external onlyFamily {
        require(artifacts[id].approvals >= threshold, "need more approvals");
        string memory newHash = artifacts[id].proposedHash;
        artifacts[id].contentHash = newHash;
        artifacts[id].proposedHash = "";
        // NOTE: keep approvals mapping as-is for PoC; real version would clear it.
        emit Finalized(id, newHash);
    }

    function toggleVisibility(uint256 id, bool makePublic) external onlyFamily {
        artifacts[id].isPublic = makePublic;
        emit VisibilityChanged(id, makePublic);
    }

    function deactivate(uint256 id) external onlyFamily {
        artifacts[id].isActive = false;
        emit Deactivated(id);
    }
}
