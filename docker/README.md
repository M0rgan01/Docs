# Docker

Le dockerfile permet de créer un conteneur debian 9, utiliser pour des tests et des démos.

## Les commandes

Création de x conteneur debian

```
./docker-debian.sh --create {number}
```

Copie de dossiers / fichiers dans le conteneur 

```
docker cp { host file/directory } $USER-debian-1:/{ container file/directory }
```

Connexion SSH au conteneur

```
ssh root@{ container ip }
```