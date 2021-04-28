## Download latest snapshot (using the example of Sifchain)  
Stop service  
`systemctl stop ag-chain-cosmos.service`  

Remove old data in directory `~/.ag-chain-cosmos/data/`  
```
rm -rf ~/.ag-chain-cosmos/data/; \
mkdir -p ~/.ag-chain-cosmos/data/; \
cd ~/.ag-chain-cosmos/data/
```

Download snapshot  
```bash
SNAP_NAME=$(curl -s http://135.181.60.250:8082/agoric/ | egrep -o ">agoric.*tar" | tr -d ">"); \
wget -O - http://135.181.60.250:8082/agoric/${SNAP_NAME} | tar xf -
```
![alt text](https://github.com/c29r3/cosmos-snapshots/blob/main/2021-01-20_14-19.png?raw=true)

Start service and check logs  
```
systemctl start ag-chain-cosmos.service; \
journalctl -u ag-chain-cosmos.service -f --no-hostname
```
