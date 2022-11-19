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
SNAP_NAME=$(curl -s http://216.158.230.250:81/akash/ | egrep -o ">akashnet-2.*tar" | tr -d ">"); \
wget -O - http://216.158.230.250:81/akash/${SNAP_NAME} | tar xf -
```
![alt text](https://github.com/c29r3/cosmos-snapshots/blob/main/2021-01-20_14-19.png?raw=true)

Start service and check logs  
```
systemctl start akash.service; \
journalctl -u akash.service -f --no-hostname
```

One line command  
```
sudo systemctl stop akash.service; \
rm -rf ~/.akash/data; \
mkdir -p ~/.akash/data; \
cd ~/.akash/data; \
SNAP_NAME=$(curl -s http://216.158.230.250:81/akash/ | egrep -o ">akashnet-2.*tar" | tr -d ">"); \
wget -O - http://216.158.230.250:81/akash/${SNAP_NAME} | tar xf -; \
sudo systemctl start akash.service; \
sudo journalctl -u akash.service -f --no-hostname
```
