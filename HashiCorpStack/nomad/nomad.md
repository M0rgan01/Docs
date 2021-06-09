# Nomad

## Prérequis

Nécessite la mise en place de consul (voir [consul.md](../consul/consul.md))

## Les commandes

Contexte -> folder [HashiCorpStack](../)

### Server

```
docker cp nomad/installNomad.sh $USER-debian-1:/tmp
```

```
docker cp nomad/execNomadServer.sh $USER-debian-1:/tmp
```

```
ssh root@172.17.0.2
```

```
cd /tmp/ && chmod 755 installNomad.sh && ./installNomad.sh && ./execNomadServer.sh
```

### Clients

```
docker cp nomad/installNomad.sh $USER-debian-2:/tmp
```

```
docker cp nomad/execNomadClient.sh $USER-debian-2:/tmp
```

```
ssh root@172.17.0.3
```

```
cd /tmp/ && chmod 755 installNomad.sh && ./installNomad.sh 172.17.0.3 && ./execNomadClient.sh 172.17.0.3 172.17.0.2
```
