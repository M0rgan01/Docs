# SSH

## Génération clé privée

```
$ ssh-keygen -t ecdsa -b 521
```

La passphrase permet de définir un mot de passe à la clé, permettant de lui donnée une valeur.

## Ajout de la clé public

```
$ ssh-copy-id ${user}@${StandardServer}
```