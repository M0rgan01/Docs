# Nomad

## Ajuster l'adresse de la CLI

Par défaut la cli Nomad pointe sur localhost (127.0.0.1), pour modifier cette valeur, éxecuter la commande suivante

```
$ export VAULT_ADDR=http://172.16.0.2:8200
```

## Définir le token de la cli

```
$ export VAULT_TOKEN={token}
```

## Mise en place d'un secret

```
$ vault kv put secret/{path} {key}={value}
```