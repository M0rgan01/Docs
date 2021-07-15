# Nomad

## Helpers

- Le fichier [jobHelper.nomad](./jobs/jobHelper.nomad) comporte des commentaires pour aider
  à la compréhension de certaines stanza des jobs
- Le fichier [helper.policy.hcl](./policies/helper.policy.hcl) comporte des commentaires pour
  aider à la compréhension de certaines stanza des policies

## Mise en place d'un cluster consul / nomad à 4 noeuds

<p align="center">
    <img src="nomadConsul4NodesCluster.png"
    alt="nomadConsul4NodesCluster"
    width="50%"
    />
</p>

*Nécessite [Vagrant](https://www.vagrantup.com/downloads)
<br />
*Contexte [vagrant 4-nodes-vm](../vagrant/hashicorp-dev-vm/4-nodes-vm)

**Config**

- Nomad
  - [Install](./installNomad.sh)
  - [Client service](./execNomadClient.sh)
  - [Serveur service](./execNomadServer.sh)
- Consul
  - [Install](../consul/installConsul.sh)
  - [Client service](../consul/execConsulClient.sh)
  - [Serveur service](../consul/execConsulServer.sh)
- Vagrant
  - [Script initialisation](../vagrant/hashicorp-dev-vm/init.sh)
  - [Vagrantfile](../vagrant/hashicorp-dev-vm/4-nodes-vm/Vagrantfile)

**Commande**

```
$ Vagrant up
```

**URLs**

Consul:

- 172.16.0.2:8500 (server)
- 172.16.0.3:8500 (client)
- 172.16.0.4:8500 (client)
- 172.16.0.5:8500 (client)

nomad:

- 172.16.0.2:4646 (server)
- 172.16.0.3:4646 (client)
- 172.16.0.4:4646 (client)
- 172.16.0.5:4646 (client)

## Mise en place d'un cluster consul / nomad à 3 noeuds

<p align="center">
    <img src="nomadConsul3NodesCluster.png"
    alt="nomadConsul3NodesCluster"
    width="50%"
    />
</p>


*Nécessite [Vagrant](https://www.vagrantup.com/downloads)
<br />
*Contexte [vagrant 3-nodes-vm](../vagrant/hashicorp-dev-vm/3-nodes-vm)

**Config**

- Nomad
  - [Install](./installNomad.sh)
  - [nomad service](./execNomadClientServer.sh)
  - [nomad conf](./config/nomadClientServerConfig.hcl)
- Consul
  - [Install](../consul/installConsul.sh)
  - [consul service](../consul/execConsulClientServer.sh)
  - [consul conf](../consul/config/consulClientServerConfig.hcl)
- Vagrant
  - [Script initialisation](../vagrant/hashicorp-dev-vm/init.sh)
  - [Vagrantfile](../vagrant/hashicorp-dev-vm/3-nodes-vm/Vagrantfile)

**Commande**

```
$ Vagrant up
```

**URLs**

Consul:

- 172.16.0.2:8500 (server / client)
- 172.16.0.3:8500 (server / client)
- 172.16.0.4:8500 (server / client)

nomad:

- 172.16.0.2:4646 (server / client)
- 172.16.0.3:4646 (server / client)
- 172.16.0.4:4646 (server / client)

## Mise en place d'une instance de dev consul / nomad / vault

*Nécessite [Vagrant](https://www.vagrantup.com/downloads)
<br />
*Contexte [vagrant dev-vm](../vagrant/hashicorp-dev-vm/1-node-vm)

**Config**

- Nomad
  - [Install](./installNomad.sh)
  - [nomad service](./execNomadDev.sh)
  - [nomad conf](./config/nomadDevConfig.hcl)
- Consul
  - [Install](../consul/installConsul.sh)
  - [consul service](../consul/execConsulDev.sh)
  - [consul conf](../consul/config/consulDevConfig.hcl)
- vault
  - [Install](../vault/installVault.sh)
  - [vault service](../vault/execVaultDev.sh)
  - [vault conf](../vault/config/vaultDevConfig.hcl)
- Vagrant
  - [Script initialisation](../vagrant/hashicorp-dev-vm/init.sh)
  - [Vagrantfile](../vagrant/hashicorp-dev-vm/1-node-vm/Vagrantfile)

**Commande**

```
$ Vagrant up
```

**URLs**

Consul:

- 172.16.0.2:8500 (dev mode)

nomad:

- 172.16.0.2:4646 (dev mode)

vault:

- 172.16.0.2:8200 (dev mode)

**Vault token**

Le token pour l'authentification vault est `SQQHkK672aXEoxmDJU5lSu7H`

## Ajuster l'adresse de la CLI

Par défaut la cli Nomad pointe sur localhost (127.0.0.1), pour modifier cette valeur, éxecuter la commande suivante

```
$ export NOMAD_ADDR=http://172.16.0.2:4646
```

## Access Control List (ACL)

Ajouter la stanza suivante dans la configuration du serveur / client pour l'initialisation des acl

```
acl {
  enabled = true
}
```

La commande suivante initialise les ACL et fournis le secret ID. Il permet d'effectuer toutes les opérations.
Il doit être utilisé pour la création de nouveaux tokens et de policies

```
$ nomad acl bootstrap
```

Pour effectuer des opérations avec la CLI il faut exporter la variable d'environnement NOMAD_TOKEN

```
$ export NOMAD_TOKEN="BOOTSTRAP_SECRET_ID"
```

Le fichier [anonymous.policy](./policies/anonymous.policy.hcl) permet de configurer des policies de type anonyme,
utilisé pour permettre l'accès temporaire à l'API nomad en attendant de mettre en place d'autre policies et
des tokens. La commande suivante applique des policies de type anonyme :

```
$ nomad acl policy apply -description "Anonymous policy (full-access)" anonymous ./policies/anonymous.policy.hcl
```

Il existe 2 type de token :
- management -> donne toutes les permissions
- client -> donne les permissions des policies attribuées

Voiçi la commande de création d'un token client

```
$ nomad acl token create -name="client1" -global -policy="app1"
```

## Générateur de charge (Hey)

L'outil [Hey](https://github.com/rakyll/hey) est un générateur de charge HTTP

La commande suivante va générer de la charge sur l'enpoint en question

```
$ hey -z 1m -c 30 http://172.16.0.2:8000
```

Option -z pour la durée de la charge et -c pour le nombre de requêtes en parallèle