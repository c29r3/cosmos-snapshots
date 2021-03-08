## Download latest snapshot (using the example of Akash)  
Stop Akash service  
`systemctl stop akash.service`  

Remove old data in directory `~/.akash/data`  
```
rm -rf ~/.akash/data; \
mkdir -p ~/.akash/data; \
cd ~/.akash/data
```

Download snapshot  
```bash
SNAP_NAME=$(curl -s http://135.181.60.250/akash/ | egrep -o ">akashnet-2.*tar" | tr -d ">"); \
wget -O - http://135.181.60.250/akash/${SNAP_NAME} | tar xf -
```
![alt text](https://github.com/c29r3/cosmos-snapshots/blob/main/2021-01-20_14-19.png?raw=true)

Start service and check logs  
```
systemctl start akash.service; \
journalctl -u akash.service -f --no-hostname
```
