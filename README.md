# cosmos-snapshots  
List of snapshots:   
***Crazy hosting provider Hetzner banned my account. I don't know yet how quickly I can restore everything***  
~~https://snapshots.c29r3.xyz:~~
- [Akash mainnet](https://github.com/c29r3/cosmos-snapshots/blob/main/instructions/Akash.md) | [MIRRORS](https://gist.githubusercontent.com/c29r3/1a8a951008b19aaa424d63d15cf528d8/raw/910b3ab34bcceb2b3e9bca0765a92461bafc53f8/akash-snapshot-mirrors)
- [Sentinel mainnet](https://github.com/c29r3/cosmos-snapshots/blob/main/instructions/Sentinel.md)
- [Desmos mainnet](https://github.com/c29r3/cosmos-snapshots/blob/main/instructions/Desmos.md)
- [Stargaze mainnet](https://github.com/c29r3/cosmos-snapshots/blob/main/instructions/Stargaze.md)
- [Agoric mainnet](https://github.com/c29r3/cosmos-snapshots/blob/main/instructions/Agoric.md)


## MIRRORS  
http://162.255.116.68/snapshots/ - privded by Min (Min#6706)  
https://snapshots.stakecraft.com/    - provided by Alex Novy  

http://snapshots.alexvalidator.com - Provided by [Bambarello](https://github.com/Bambarello)
- [Oasis mainnet](https://github.com/Bambarello/cosmos-snapshots/blob/main/Oasis.md)   
- IXO (Mainnet)   
- Regen (Mainnet)  
- Stargaze (Mainnet)   
- Juno (Mainnet)  
- Axelar (Mainnet)  
- Sifchain (Betanet)  
- Desmos (Mainnet)  
- Evmos (Mainnet)  
- Gravity Bridge (Mainnet)  
- Omniflix (Mainnet)  
- Umee (Mainnet)  
- Cosmos (Mainnet)  
- Kichain (Mainnet) 
  
https://services.staketab.com/  - provided by [Staketab](https://github.com/Staketab)  
- Axelar
- Axelar testnet 1
- Axelar testnet 2
- Cosmos
- Desmos
- Evmos
- Gravity bridge
- Omniflix
- Osmosis
- Sifchain
- Stargaze
- Umee
  
https://snapshots.stake2.me/ - provided by [Danil Ushakov](https://github.com/k0kk0k)  
- Agoric
- Akash
- Certik
- Gravity bridge
- IXO
- Osmosis
- Sifchain
- Stargaze


https://snapshot.notional.ventures/ - provided by [Notional](https://github.com/notional-labs)
- Cosmoshub
- Osmosis
- Juno
- Starname
- Regen
- Akash
- Sentinel
- E-money
- Terra
- Ixo
- Sifchain
- Likecoin
- Kichain
- Cyber
- Cheqd
- Stargaze
- Band
- Chihuahua
- Kava
- Bitcanna
- Konstellation
- Omniflixhub
- Vidulum
- Provenance
- Dig
- Gravity bridge
- Comdex
- Cerberus
- Bitsong
- AssetMantle
- FetchAI

## Run your own backup server with snapshots  
Install requirements  
```bash
sudo apt update && \
sudo apt install curl git docker.io -y
```

Clone github repo  
`git clone https://github.com/c29r3/cosmos-snapshots.git && cd cosmos-snapshots`  

Create folder for snapshots  
`mkdir $HOME/snapshots/`

Start Nginx via docker  
```bash
cd $HOME; \
docker run --name snapshots \
--restart always \
-v $(pwd)/default.conf:/etc/nginx/conf.d/default.conf \
-v $(pwd)/snapshots/:/root/ \
-p 80:80 \
-d nginx
```

Fill in the variables in the file `akash_snapshot.sh`  
```
CHAIN_ID="akashnet-2"
SNAP_PATH="$HOME/snapshots/akash"
LOG_PATH="$HOME/snapshots/akash_log.txt"
DATA_PATH="$HOME/.akash/data/"
SERVICE_NAME="akash.service"
```
Create new snapshot  
`./akash_snapshot.sh`  

Check snapshot  
```bash
MY_IP=$(curl -s 2ip.ru); \
curl -s http://${MY_IP}
```

## Automation  
You can add script to the cron  
```cron
# start every day at 00:00
0 0 * * * /bin/bash -c '/root/akash_snapshot.sh'
```
