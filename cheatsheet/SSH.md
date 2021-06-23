# SSH

## Génération clé privée

```
$ ssh-keygen -t ecdsa -b 521
```

La passphrase permet de définir un mot de passe à la clé, permettant de lui donnée une valeur.

## Ajout de la clé public

Solution 1

```
$ ssh-copy-id ${user}@${StandardServer}
```

Solution 2

Pour le root user

```
echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
```

Pour un autre utilisateur

```
echo #{ssh_pub_key} >> /home/{user}/.ssh/authorized_keys
```