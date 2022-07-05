## Download latest snapshot (using the example of Sifchain)  
Stop Sifchain service  
`systemctl stop sifchain.service`  

Remove old data in directory `~/.sifnoded/data`  
```
rm -rf ~/.sifnoded/data; \
mkdir -p ~/.sifnoded/data; \
cd ~/.sifnoded/data
```

Download snapshot  
```bash
SNAP_NAME=$(curl -s https://snapshots.c29r3.xyz/sifchain/ | egrep -o ">sifchain.*tar" | tail -n 1 | tr -d '>'); \
wget -O - https://snapshots.c29r3.xyz/sifchain/${SNAP_NAME} | tar xf -
```
![alt text](https://github.com/c29r3/cosmos-snapshots/blob/main/2021-01-20_14-19.png?raw=true)

Start service and check logs  
```
systemctl start sifchain.service; \
journalctl -u sifchain.service -f --no-hostname
```
