## Download latest snapshot (using the example of Oasis)  
Stop Oasis service  
`systemctl stop oasis.service`  

Remove `abci-state` and `data` in directory `.../serverdir/node/tendermint/` and remove `/serverdir/node/persistent-store.badger.db`  

Go to `.../serverdir/node/tendermint/`

Download and immediately unpack snapshot  
```bash
SNAP_NAME=$(curl -s http://snapshots.alexvalidator.com/oasis/ | egrep -o ">oasis.*tar" | tr -d ">"); \
wget -O - http://snapshots.alexvalidator.com/oasis/${SNAP_NAME} | tar xf -
```
Start service and check logs  
```
systemctl start oasis.service; \
journalctl -u oasis.service -f --no-hostname
```
