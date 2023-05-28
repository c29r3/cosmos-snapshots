#!/bin/bash

SERVICE_NAME="agoricd"

###
# agoric statesync cron job
# 0 5 * * 1 /bin/bash -c '/home/user/agoric_statesync.sh'
###

SNAP_RPC="https://agoric-rpc.polkachu.com:443"
#SNAP_RPC="http://46.166.143.91:26657"
#SNAP_RPC="http://116.202.114.4:26657"

LATEST_HEIGHT=$(curl -s $SNAP_RPC/block | jq -r .result.block.header.height); \
BLOCK_HEIGHT=$((LATEST_HEIGHT - 2000)); \
TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$SNAP_RPC,$SNAP_RPC\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"|" $HOME/.agoric/config/config.toml

sudo systemctl stop ${SERVICE_NAME}

agd tendermint unsafe-reset-all

echo Restart
sudo systemctl restart ${SERVICE_NAME}
# sudo journalctl -u ${SERVICE_NAME} -f --no-hostname | grep statesync
