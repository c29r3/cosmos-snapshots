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
SNAP_NAME=$(curl -s http://135.181.60.250:8086/stargaze/ | egrep -o ">stargaze.*tar" | tr -d ">"); \
wget -O - http://135.181.60.250:8086/stargaze/${SNAP_NAME} | tar xf -
```
![alt text](https://github.com/c29r3/cosmos-snapshots/blob/main/2021-01-20_14-19.png?raw=true)

Start service and check logs  
```
systemctl start stargaze.service; \
journalctl -u stargaze.service -f --no-hostname
```
