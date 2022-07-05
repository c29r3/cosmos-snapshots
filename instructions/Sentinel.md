## Install Aria2
## https://aria2.github.io/

sudo apt-get install wget -y

## Download latest snapshot (using the example of Sentinel)  
Stop Sentinel service  
`systemctl stop sentinel.service`  

Remove old data in directory `~/.sentinelhub/data/`  
```
rm -rf ~/.sentinelhub/data/; \
mkdir -p ~/.sentinelhub/data/; \
cd ~/.sentinelhub/data/
```

Download snapshot  
```bash
SNAP_NAME=$(curl -s https://snapshots.c29r3.xyz/sentinel/ | egrep -o ">sentinelhub-2.*tar" | tr -d ">"); \
wget -O - https://snapshots.c29r3.xyz/sentinel/${SNAP_NAME} | tar xf -
```
![alt text](https://github.com/c29r3/cosmos-snapshots/blob/main/2021-01-20_14-19.png?raw=true)

Start service and check logs  
```
systemctl start sentinel.service; \
journalctl -u sentinel.service -f --no-hostname
```
