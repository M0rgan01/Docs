# Nomad

## Job stanza helper

Le fichier [jobHelper.nomad](./jobs/jobHelper.nomad) comporte des commentaires pour aider à la compréhension de certaines stanza

## Mise en place d'un cluster consul / nomad

<p align="center">
    <img src="nomadConsulCluster.png"
    alt="nomadConsulCluster"
    width="50%"
    />
</p>

*Nécessite [Vagrant](https://www.vagrantup.com/downloads)
<br />
*Contexte [vagrant multi-vm](../vagrant/multi-vm)

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
  - [Script initialisation](../vagrant/init.sh)
  - [Vagrantfile](../vagrant/multi-vm/Vagrantfile)
  
**Commande**

```
$ Vagrant up
```

## Mise en place d'un environnement de dev consul / nomad

*Nécessite [Vagrant](https://www.vagrantup.com/downloads)
<br />
*Contexte [vagrant dev-vm](../vagrant/dev-vm)

**Config**

- Nomad
  - [Install](./installNomad.sh)
  - [nomad service](./execNomadDev.sh)
  - [nomad conf](./nomadConf.hcl)
- Consul
  - [Install](../consul/installConsul.sh)
  - [consul service](../consul/execConsulDev.sh)
- Vagrant
  - [Script initialisation](../vagrant/init.sh)
  - [Vagrantfile](../vagrant/dev-vm/Vagrantfile)
  
**Commande**

```
$ Vagrant up
```

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

Le fichier [anonymous.policy](./anonymous.policy) permet de configurer des policies, qui peuvent être 
appliqué avec la commande suivante

```
$ nomad acl policy apply -description "Anonymous policy (full-access)" anonymous anonymous.policy.hcl
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