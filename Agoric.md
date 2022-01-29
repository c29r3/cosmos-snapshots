## Download latest snapshot (using the example of Osmosis)  
Stop Agoric service  
`sudo systemctl stop agoricd.service`  

Remove old data in directory `~/.agoric/data`  
```
rm -rf ~/.agoric/data; \
mkdir -p ~/.agoric/data; \
cd ~/.agoric/data
```

Download snapshot  
```bash
SNAP_NAME=$(curl -s http://135.181.60.250:8087/agoric/ | egrep -o ">agoric-3.*tar" | tr -d ">"); \
wget -O - http://135.181.60.250:8087/agoric/${SNAP_NAME} | tar xf -
```
![alt text](https://github.com/c29r3/cosmos-snapshots/blob/main/2021-01-20_14-19.png?raw=true)

Start service and check logs  
```
sudo systemctl start agoricd.service; \
sudo journalctl -u agoricd.service -f --no-hostname
```
