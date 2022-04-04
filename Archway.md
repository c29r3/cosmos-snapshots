## Download latest snapshot (using the example of Akash)  
Stop Akash service  
`systemctl stop archway.service`  

Remove old data in directory `~/.archway/data`  
```
rm -rf ~/.archway/data; \
mkdir -p ~/.archway/data; \
cd ~/.archway/data
```

Download snapshot  
```bash
SNAP_NAME=$(curl -s http://135.181.60.250:5889/archway/ | egrep -o ">augusta-1.*tar" | tr -d ">"); \
wget -O - http://135.181.60.250:5889/archway/${SNAP_NAME} | tar xf -
```
![alt text](https://github.com/c29r3/cosmos-snapshots/blob/main/2021-01-20_14-19.png?raw=true)

Start service and check logs  
```
systemctl start archway.service; \
journalctl -u archway.service -f --no-hostname
```
