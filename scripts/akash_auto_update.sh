#!/bin/bash

SERVICE_NAME="akash.service"
BIN_NAME="akash"
BIN_PATH="$HOME/go/bin/"


check_for_update(){
  CHECK_UPD=$(sudo journalctl -u ${SERVICE_NAME} --since "30 seconds ago" | egrep  "UPGRADE" | head -n 1 | egrep -o "https://.*\.json")
  echo $CHECK_UPD
}


while true;
do
  echo "Checking logs"
  RES=$(check_for_update)
  if [[ $RES == *"https://"* ]]
  then
    RES=$(curl -s ${RES} | jq -r '.binaries."linux/amd64"')
    echo -e "UPDATE LINK: $RES"
    
    cd /tmp
    wget -q ${RES}
    unzip *zip
    chmod u+x $BIN_NAME
    SHASUM_OLD=$(shasum ${BIN_PATH}${BIN_NAME} | cut -d " " -f1)
    SHASUM_NEW=$(shasum ${BIN_NAME} | cut -d " " -f1)
    echo -e "OLD: $SHASUM_OLD\nNEW: $SHASUM_NEW"
    
    if [[ $SHASUM_OLD != $SHASUM_NEW ]]
    then
      echo "Replacing bin file"
      rm -f ${BIN_PATH}${BIN_NAME}
      mv ${BIN_NAME} ${BIN_PATH}
      echo "Restarting service"
      sudo systemctl restart ${SERVICE_NAME}
    else
      echo "Binary files are same"
      rm -f ${BIN_NAME}
      sleep 60
    fi
    rm -f /tmp/${BIN_NAME}*zip*
  fi
  sleep 10
done
