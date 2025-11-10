# SAJL — Secure Archive for Qatari Lineage
*67-404 Blockchain | Group 3 (Aisha, Juwaher, Fatma, Shareefa)*

## Overview  
SAJL (which means "record" or "witness" in Arabic) is a blockchain-based platform designed to preserve Qatari family heritage.  
The goal is to digitally record traditional items, such as swords, jewelry, abayas, falconry tools, and oral stories, as verified NFTs.  
This allows families to protect and authenticate their cultural artifacts across generations while maintaining privacy and ownership.

## Current Sprint (Sprint 3)  
- Deployed the **SajlRegistry** contract to Sepolia and verified it on Etherscan  
- Completed Foundry configuration (`foundry.toml`) and deployment scripts  
- Generated gas and coverage reports for core functions  
- Preparing usability test #1 and demo walkthrough  

## Planned Structure  
/contracts → Solidity smart contracts (ERC-721 variant)  
/frontend → Web interface (React or Next.js)  
/docs → Reports, sprint check-ins, and proposals  

## Team Members  
- **Aisha Al-Muhannadi** — Smart Contract Lead  
- **Juwaher Naqadan** — PM & Documentation Lead  
- **Fatma AlMulla** — Privacy & Policy Lead  
- **Shareefa AlSulaiti** — UX & Design Lead  

## Links  
**Board:** https://github.com/users/juwaherrr/projects/1  
**Demo:** https://www.figma.com/design/itKoRHPCF69QsfTmoDa9TR/66182-Term-Project-Demo?node-id=114-22464  

## Vision  
To make digital preservation more **authentic, secure, and family-owned**,  
ensuring that cultural data remains under community control, not platform control.

---

### Foundry Build & Deployment

To compile and deploy SAJL smart contracts on the Ethereum Sepolia testnet:

```bash
# 1. Build the contracts
forge build

# 2. Run tests (optional)
forge test

# 3. Deploy to Sepolia
forge script script/Deploy.s.sol \
  --rpc-url $SEPOLIA_RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast \
  --verify
