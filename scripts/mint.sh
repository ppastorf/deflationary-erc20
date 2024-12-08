#!/bin/env bash

PRIVKEY="0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
ACCOUNT="0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"
TOKEN_ADDR="0x5FbDB2315678afecb367f032d93F642f64180aa3"
MINT_AMOUNT="100000ether"

cast send --rpc-url=$RPC_URL --private-key=$PRIVKEY $TOKEN_ADDR `cast calldata 'mint(address,uint256)' $ACCOUNT $MINT_AMOUNT` > /dev/null
if [[ $? -ne 0 ]]; then
    echo "Failed to send transaction."
    exit 1
fi

TOTAL_SUPPLY=$(cast call --rpc-url=$RPC_URL $TOKEN_ADDR "totalSupply()" | cast to-dec | cast from-wei)
ACCOUNT_SUPPLY=$(cast call --rpc-url=$RPC_URL $TOKEN_ADDR "balanceOf(address)" $PUBKEY | cast to-dec | cast from-wei)

printf "TOTAL SUPPLY = %s ether\n" $TOTAL_SUPPLY
printf "'TO' ACCOUNT SUPPLY = %s ether\n" $ACCOUNT_SUPPLY