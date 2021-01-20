# cosmos-snapshots  
Snapshots for Akash Network can be found here  
http://135.181.60.250/akash  

## Download latest snapshot  
```bash
SNAP_NAME=$(curl -s http://${IP}/akash/ | egrep -o ">akashnet.*tar" | tr -d ">"); \
systemctl stop akash.service; \
cd ~/.akashd/data; \
rm -rf *; \
wget -O - http://135.181.60.250/akash/${SNAP_NAME} | tar xf -
```


## Run your own backup server with snapshots  
Install requirements  
```bash
sudo apt update && \
sudo apt install curl git docker.io -y
```

Clone github repo  
`git clone https://github.com/c29r3/cosmos-snapshots.git && cd cosmos-snapshots`  

Create folder for snapshots  
`mkdir $HOME/akash`

Start Nginx via docker  
```bash
cd $HOME; \
docker run --name nginx -v $(pwd)/default.conf:/etc/nginx/conf.d/default.conf -v $(pwd)/akash/:/root/ -p 80:80 -d nginx
```

Fill in the variables in the file `akash_snapshot.sh`  
```
CHAIN_ID="akashnet-1"
SNAP_PATH="/root/akash/akash"
LOG_PATH="/root/akash/akash_log.txt"
DATA_PATH="/root/.akashd/data/"
SERVICE_NAME="akash.service"
```
Create new snapshot  
`./akash_snapshot.sh`  

Check snapshot  
```bash
MY_IP=$(curl -s 2ip.ru); \
curl -s http://${MY_IP}
```

## Automation  
You can add script to the cron  
