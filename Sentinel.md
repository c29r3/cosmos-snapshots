## Download latest snapshot (using the example of Sentinel)  
Stop Sentinel service  
`systemctl stop sentinel.service`  

Remove old data in directory `~/.sentinelhub/data/`  
```
rm -rf ~/.sentinelhub/data/; \
mkdir -p ~/.sentinelhub/data/; \
cd ~/.sentinelhub/data/
```

Download snapshot  
```bash
SNAP_NAME=$(curl -s http://135.181.60.250:8083/sentinel/ | egrep -o ">sentinelhub-2.*tar" | tr -d ">"); \
wget -O - http://135.181.60.250:8083/sentinel/${SNAP_NAME} | tar xf -
```
![alt text](https://github.com/c29r3/cosmos-snapshots/blob/main/2021-01-20_14-19.png?raw=true)

Start service and check logs  
```
systemctl start sentinel.service; \
journalctl -u sentinel.service -f --no-hostname
```
