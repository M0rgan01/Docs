# Ansible

## Prérequis

Une dépendance à python3 est nécessaire pour le fonctionnement d'Ansible

```
$ sudo apt install python3
```

Une installation de [Vagrant](https://www.vagrantup.com/downloads) est également nécessaire.

## Installation

Les commandes pour l'installation d'ansible.

### Pip

```
$ sudo apt install python3-pip
```

```
$ pip3 install ansible==2.9.9
```

### Gestionnaire de paquet

```
$ sudo apt update
```

```
$ sudo apt install ansible
```

## Commandes

### Playbook

La mise en place des VMs est nécessaire avant de lancer un playbook, faire un `vagrant up`
dans l'un des dossiers suivants :

- [1-node-vm](../hashiCorpStack/vagrant/standard-vm/1-node-vm) pour du single-node
- [3-nodes-vm](../hashiCorpStack/vagrant/standard-vm/3-nodes-vm) pour un cluster à 3 nodes


Voiçi la commande pour lancer le playbook :

```
$ ansible-playbook -i inventory playbook.yml
```

Pour renseigner une clé privée spécifique :

```
$ ansible-playbook -i inventory playbook.yml --key-file "~/.ssh/mykey.pem"
```

### Role

La commande pour la création de rôles, qui permettent de moduler la configuration

```
$ ansible-galaxy init tools
```

### Vault

Commande création de chiffrement pour les chaines de caractères

```
$ ansible-vault encrypt_string
```

L'option "ask-vault-pass" permet la demande de mot de passe, il existe aussi "vault-password-file"

```
$ ansible-playbook -i hosts playbook.yml --ask-vault-pass
```