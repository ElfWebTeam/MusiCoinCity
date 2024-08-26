## MusiCoinCity - Edu Chain Hackathon: Semester 1

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.


### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Deploy

```shell
$ forge script script/Forest.s.sol:ForestScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```
```shell
$ forge script script/Space.s.sol:SpaceScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```
```shell
$ forge script script/Desert.s.sol:DesertScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```
```shell
$ forge script script/Ocean.s.sol:OceanScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Verify Smart Contracts

```shell
forge verify-contract \
  --rpc-url https://rpc.open-campus-codex.gelato.digital \
  --verifier blockscout \
  --verifier-url 'https://opencampus-codex.blockscout.com/api/' \
  0x6E2eEb00Fb099B6c6fc78568eb4dD55b489F295F \
  src/Forest.sol:Forest
```
```shell
forge verify-contract \
  --rpc-url https://rpc.open-campus-codex.gelato.digital \
  --verifier blockscout \
  --verifier-url 'https://opencampus-codex.blockscout.com/api/' \
  0xc92F3e7E47D85b5671587b377883248ce063C54C \
  src/Space.sol:Space
```
```shell
forge verify-contract \
  --rpc-url https://rpc.open-campus-codex.gelato.digital \
  --verifier blockscout \
  --verifier-url 'https://opencampus-codex.blockscout.com/api/' \
  0x9b438006f9d84955cc63649193dc6c8c4271b9fa \
  src/Desert.sol:Desert
```
```shell
forge verify-contract \
  --rpc-url https://rpc.open-campus-codex.gelato.digital \
  --verifier blockscout \
  --verifier-url 'https://opencampus-codex.blockscout.com/api/' \
  0xACc53053fe9453cD7c75d6Eb35c832C0a69959bD \
  src/Ocean.sol:Ocean
```
