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
RANDOM_IP=$(curl -s https://gist.githubusercontent.com/c29r3/1a8a951008b19aaa424d63d15cf528d8/raw/910b3ab34bcceb2b3e9bca0765a92461bafc53f8/akash-snapshot-mirrors | shuf | head -n1); \
SNAP_NAME=$(curl -s $RANDOM_IP/akash/ | egrep -o ">akashnet-2.*tar" | tr -d ">"); \
wget -O - $RANDOM_IP/akash/${SNAP_NAME} | tar xf -
```
![alt text](https://github.com/c29r3/cosmos-snapshots/blob/main/2021-01-20_14-19.png?raw=true)

Start service and check logs  
```
systemctl start akash.service; \
journalctl -u akash.service -f --no-hostname
```
