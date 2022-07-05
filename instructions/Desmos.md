## Download latest snapshot (using the example of Desmos)  
Stop Desmos service  
`systemctl stop desmos.service`  

Remove old data in directory `~/.desmos/data`  
```
rm -rf ~/.desmos/data; \
mkdir -p ~/.desmos/data; \
cd ~/.desmos/data
```

Download snapshot  
```bash
SNAP_NAME=$(curl -s https://snapshots.c29r3.xyz/desmos/ | egrep -o ">desmos.*tar" | tr -d ">"); \
wget -O - https://snapshots.c29r3.xyz/desmos/${SNAP_NAME} | tar xf -
```
![alt text](https://github.com/c29r3/cosmos-snapshots/blob/main/2021-01-20_14-19.png?raw=true)

Start service and check logs  
```
systemctl start desmos.service; \
journalctl -u desmos.service -f --no-hostname
```
