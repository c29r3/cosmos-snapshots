#!/bin/bash

###
# https://rpc.akashnet.net:443
# https://rpc.akash.forbole.com:443
# https://rpc-akash.ecostake.com:443
# https://akash-rpc.polkachu.com:443
# https://rpc-akash-ia.notional.ventures:443
# http://node.d3akash.cloud:26657
# http://akash.c29r3.xyz:80/rpc
###

###
# akash statesync cron job
# 0 5 * * 1 /bin/bash -c '/home/user/akash_statesync.sh'
###

AKASH_PATH="$HOME/.akash"
SERVICE_NAME="akash"

sudo systemctl stop ${SERVICE_NAME}

SNAP_RPC="https://akash-rpc.polkachu.com:443"
# SNAP_RPC="http://node.d3akash.cloud:26657"


LATEST_HEIGHT=$(curl -s $SNAP_RPC/block | jq -r .result.block.header.height); \
BLOCK_HEIGHT=$((LATEST_HEIGHT - 2000)); \
TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
#s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$SNAP_RPC,$SNAP_RPC\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"|" ${AKASH_PATH}/config/config.toml

sudo systemctl stop ${SERVICE_NAME}

akash tendermint unsafe-reset-all --home ${AKASH_PATH} --keep-addr-book

echo Restart
sudo systemctl restart ${SERVICE_NAME}
# sudo journalctl -u ${SERVICE_NAME} -f --no-hostname | grep statesync
