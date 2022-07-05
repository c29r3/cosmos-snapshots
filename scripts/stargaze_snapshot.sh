#!/bin/bash
CHAIN_ID="stargaze-1"
SNAP_PATH="$HOME/snapshots/stargaze"
LOG_PATH="$HOME/snapshots/stargaze/stargaze_log.txt"
DATA_PATH="$HOME/.starsd/data/"
SERVICE_NAME="starsd.service"
RPC_ADDRESS="https://stargaze.c29r3.xyz/rpc"
SNAP_NAME=$(echo "${CHAIN_ID}_$(date '+%Y-%m-%d').tar")
WASM_NAME="stargaze_wasm.tar"
OLD_SNAP=$(ls ${SNAP_PATH} | egrep -o "${CHAIN_ID}.*tar")
OLD_WASM=$(ls ${SNAP_PATH} | egrep -o "wasm.*tar")


now_date() {
    echo -n $(TZ=":Europe/Moscow" date '+%Y-%m-%d_%H:%M:%S')
}


log_this() {
    YEL='\033[1;33m' # yellow
    NC='\033[0m'     # No Color
    local logging="$@"
    printf "|$(now_date)| $logging\n" | tee -a ${LOG_PATH}
}

LAST_BLOCK_HEIGHT=$(curl -s ${RPC_ADDRESS}/status | jq -r .result.sync_info.latest_block_height)
log_this "LAST_BLOCK_HEIGHT ${LAST_BLOCK_HEIGHT}"

log_this "Stopping ${SERVICE_NAME}"
systemctl stop ${SERVICE_NAME}; echo $? >> ${LOG_PATH}

log_this "Creating new snapshot"
time tar cf ${HOME}/${SNAP_NAME} -C ${DATA_PATH} . &>>${LOG_PATH}

log_this "Creating new WASM snapshot"
time tar cf ${HOME}/${WASM_NAME} -C $HOME/.starsd/wasm . &>>${LOG_PATH}

log_this "Starting ${SERVICE_NAME}"
systemctl start ${SERVICE_NAME}; echo $? >> ${LOG_PATH}

log_this "Removing old snapshot(s):"
cd ${SNAP_PATH}
rm -fv ${OLD_SNAP} &>>${LOG_PATH}
rm -fv ${OLD_WASM} &>>${LOG_PATH}

log_this "Moving new snapshot to ${SNAP_PATH}"
mv ${HOME}/${CHAIN_ID}*tar ${SNAP_PATH} &>>${LOG_PATH}
mv ${HOME}/${WASM_NAME} ${SNAP_PATH} &>>${LOG_PATH}


du -hs ${SNAP_PATH} | tee -a ${LOG_PATH}

log_this "Done\n---------------------------\n"
