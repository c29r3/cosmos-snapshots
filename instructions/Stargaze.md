## Download latest snapshot (using the example of Osmosis)  
Stop Stargaze service  
`systemctl stop stargaze.service`  

Remove old data in directory `~/.starsd/data`  
```
rm -rf ~/.starsd/data; \
mkdir -p ~/.starsd/data; \
cd ~/.starsd/data
```

Download snapshot  
```bash
SNAP_NAME=$(curl -s https://snapshots.c29r3.xyz/stargaze/ | egrep -o ">stargaze.*tar" | tr -d ">"); \
wget -O - https://snapshots.c29r3.xyz/stargaze/${SNAP_NAME} | tar xf -
```
![alt text](https://github.com/c29r3/cosmos-snapshots/blob/main/2021-01-20_14-19.png?raw=true)

Start service and check logs  
```
systemctl start stargaze.service; \
journalctl -u stargaze.service -f --no-hostname
```
