# SSH

## Génération clé privée / clé publique

```
$ ssh-keygen -t ecdsa -b 521
```

La passphrase permet de définir un mot de passe à la clé, améliorant la sécurité 
mais devra être renseigné à chaque utilisation de la clé publique.

```
$ Enter file in which to save the key (/home/user/.ssh/id_rsa): name
```

La valeur rentrée correspond au nom des clé générées

## Ajout de la clé public sur un hôte distant

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

## Connection SSH depuis les github actions


**Etape 1.** générer les clés public / privée en local :

```
$ ssh-keygen -m PEM -t rsa -b 4096
```

**Etape 2.** copier le contenu de la clé privée dans un secret github actions:

<p align="center">
    <img src="https://miro.medium.com/max/700/1*8oMkxxZtLrMD_3oe4Oho1A.png"
    alt="nomadConsul3NodesCluster"
    width="50%"
    />
</p>

**Etape 3.** supprimer la clé privée en local

**Etape 4.** ajouter la clé public dans l'hôte distant

```
$ echo #{ssh_pub_key} >> /.ssh/authorized_keys
```

**Etape 5.** supprimer la clé publique en local