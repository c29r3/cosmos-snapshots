## Download latest snapshot (using the example of Oasis)  
Stop Oasis service  
`systemctl stop oasis.service`  

Remove `abci-state` and `data` in directory `.../serverdir/node/tendermint/` and remove `/serverdir/node/persistent-store.badger.db`  

Go to `.../serverdir/node/tendermint/`

Download and immediately unpack snapshot  
```bash
SNAP_NAME=$(curl -s http://95.216.45.250:8081/ | egrep -o ">oasis.*tar" | tr -d ">"); \
wget -O - http://95.216.45.250:8081/${SNAP_NAME} | tar xzf -
```
![alt text](https://github.com/c29r3/cosmos-snapshots/blob/main/2021-01-20_14-19.png?raw=true)

Start service and check logs  
```
systemctl start oasis.service; \
journalctl -u oasis.service -f --no-hostname
```
