## Download latest snapshot (using the example of Bitcanna)  
Stop Bitcanna service  
`systemctl stop bcnad.service`  

Remove old data in directory `~/.bcna/data`  
```
rm -rf ~/.bcna/data; \
mkdir -p ~/.bcna/data; \
cd ~/.bcna/data
```

Download snapshot  
```bash
SNAP_NAME=$(curl -s http://135.181.60.250:8086/bitcanna/ | egrep -o ">bitcanna.*tar" | tr -d ">"); \
wget -O - http://135.181.60.250:8086/bitcanna/${SNAP_NAME} | tar xf -
```
![alt text](https://github.com/c29r3/cosmos-snapshots/blob/main/2021-01-20_14-19.png?raw=true)

Start service and check logs  
```
systemctl start bcnad.service; \
journalctl -u bcnad.service -f --no-hostname
```
