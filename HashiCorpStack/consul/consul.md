# Reproduction du schéma

<p align="center">
    <img src="./consulEx.png"
    alt="consulEx"
    width="50%"
    />
</p>

## Les commandes

Contexte -> folder [HashiCorpStack][../]

```
./docker-debian.sh --create 4
```

### Server

```
docker cp consul/installServerConsul.sh $USER-debian-1:/tmp
```

```
docker cp consul/execConsulServer.sh $USER-debian-1:/tmp
```

```
ssh root@172.17.0.2
```

```
cd /tmp/ && chmod 755 installServerConsul.sh && ./installServerConsul.sh && ./execConsulServer.sh
```

### Clients

```
docker cp consul/installServerConsul.sh $USER-debian-2:/tmp
```

```
docker cp consul/execConsulClient.sh $USER-debian-2:/tmp
```

```
ssh root@172.17.0.3
```

```
cd /tmp/ && chmod 755 installServerConsul.sh && ./installServerConsul.sh 172.17.0.3 && ./execConsulClient.sh 172.17.0.3 172.17.0.2
```

### DNS tests

```
dig @172.17.0.2 -p 8600 ${service}.service.consul SRV +short
```
