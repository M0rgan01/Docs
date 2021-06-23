# Ansible

## Installation

Les commandes pour l'installation d'ansible.

***Prérequis serveur**

Les serveurs cibles doivent avoir installés python3

```
$ sudo apt install python3
```

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

Voiçi la commande pour lancer l'installation du serveur :

```
$ ansible-playbook -i hosts install.yml
```

La commande pour la création de rôles, qui permettent de moduler la configuration

```
$ ansible-galaxy init tools
```

Commande création de chiffrement pour les chaines de caractères

```
$ ansible-vault encrypt_string
```

L'option "ask-vault-pass" permet la demande de mot de passe, il existe aussi "vault-password-file"

```
$ ansible-playbook -i hosts install.yml --ask-vault-pass
```