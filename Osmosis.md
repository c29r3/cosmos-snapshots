## Download latest snapshot (using the example of Osmosis)  
Stop Osmosis service  
`systemctl stop osmosis.service`  

Remove old data in directory `~/.osmosisd/data`  
```
rm -rf ~/.osmosisd/data; \
mkdir -p ~/.osmosisd/data; \
cd ~/.osmosisd/data
```

Download snapshot  
```bash
SNAP_NAME=$(curl -s http://135.181.60.250:5888/osmosis/ | egrep -o ">osmosis.*tar" | tr -d ">"); \
wget -O - http://135.181.60.250:5888/osmosis/${SNAP_NAME} | tar xf -
```
![alt text](https://github.com/c29r3/cosmos-snapshots/blob/main/2021-01-20_14-19.png?raw=true)

Start service and check logs  
```
systemctl start osmosis.service; \
journalctl -u osmosis.service -f --no-hostname
```
