#!/bin/bash

###
# sentinel statesync cron job
# 0 5 * * 1 /bin/bash -c '/home/user/sentinel_statesync.sh'
###

SERVICE_NAME="sentinel"

sudo systemctl stop ${SERVICE_NAME}

SNAP_RPC="https://rpc.sentinel.co:443"

LATEST_HEIGHT=$(curl -s $SNAP_RPC/block | jq -r .result.block.header.height); \
BLOCK_HEIGHT=$((LATEST_HEIGHT - 2000)); \
TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$SNAP_RPC,$SNAP_RPC\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"|" $HOME/.sentinelhub/config/config.toml

sudo systemctl stop ${SERVICE_NAME}

sentinelhub tendermint unsafe-reset-all --home $HOME/.sentinelhub --keep-addr-book

echo Restart
sudo systemctl restart ${SERVICE_NAME}
# sudo journalctl -u ${SERVICE_NAME} -f --no-hostname | grep statesync
