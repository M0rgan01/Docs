# SERVICES PRINCIPAUX

#### Amazon Elastic Compute Cloud / EC2 (serveurs virtuels appelés instances EC2)

    Fournit une capacité de calcul sécurisée et redimensionnable dans le cloud en tant qu'instances Amazon EC2

    Type d'instance:
        - usage général
        - calcul optimisé
        - mémoire optimisée
        - calcul accélé
        - stockage optimisé

    Type de tarification:
        - à la demande
        - "Savings Plan Amazon EC2"
        - instances réservées
        - instance Stot
        - Hôtes dédiés

    Type de mise à l'échelle (Auto Scaling Amazon EC2):
        - dynamique
        - prédictive

    Load Balancing -> Elastic Load Balancing

#### AWS Lambda (serverless)

    - Execution de code sur déclencheurs
    - 15 min max pour une exécution
    - Se déclenche à partir d'une source d'événement, telle que des services AWS, des applications mobiles ou des points de terminaison HTTP.
    - Vous ne payez que le temps de calcul que vous utilisez.

#### Amazon Simple Queue Service / SQS
    
    - Service de mise en file d'attente de messages
    - Stocker et recevoir des messages entre les composants logiciels
    -  Un utilisateur ou un service extrait un message de la file d'attente, le traite, puis le supprime de la file d'attente

#### Amazon Simple Notification Service / SNS

    - Service de publication/d'abonnement
    - Un éditeur publie des messages à l'intention des abonnés
    - Les abonnés peuvent être des serveurs web, des adresses e-mail, des fonctions AWS Lambda ou plusieurs autres options

#### Amazon Elastic Container Service / ECS

    - Prend en charge les conteneurs Docker
    - Utiliser les appels d'API pour lancer et arrêter des applications compatibles avec Docker

#### Amazon Elastic Service Kubernetes / EKS

    - Exécuter Kubernetes sur AWS
    - Gérer des applications conteneurisées à grande échelle

#### AWS Fargate (serverless)
    
    - Permet d'exécuter vos conteneurs au-dessus d'une plateforme de calcul serverless
    - Sans serveur pour les conteneurs
    - Fonctionne avec Amazon ECS et Amazon EKS
    - Gère votre infrastructure de serveurs à votre place, vous ne devez pas allouer ou gérer des serveurs
    - Vous ne payez que les ressources nécessaires à l'exécution de vos conteneurs

# NETWORK

#### Amazon CloudFront (CDN)

    - Permet de faire une copie (cache) d'une région dans une autre pour se rapprocher de certains clients
    - Emplacement périphérique ->  Site qu'Amazon CloudFront utilise pour stocker des copies mises en cache de votre contenu plus près de vos clients, aux fins d'une diffusion plus rapide.

#### Amazon Route 53 (DNS)

    - Connecte les requêtes des utilisateurs à l'infrastructure s'exécutant dans AWS
    - Peut acheminer les utilisateurs vers une infrastructure en dehors d'AWS
    - Gérer les enregistrements DNS pour les noms de domaine

#### Amazon Virtual Private Cloud / VPC
    
    - Service de réseaux que vous pouvez utiliser pour établir des limites autour de vos ressources AWS
    - Permet définir les services public (accessible depuis internet) et les services privé (accessible uniquement pour les autres services, ex: DB)

##### Passerelle Internet

Une passerelle Internet est une connexion entre un VPC et Internet. Vous pouvez penser qu'une passerelle Internet 
est semblable à une porte que les clients utilisent pour entrer dans le système.
Sans passerelle Internet, personne ne peut accéder aux ressources de votre VPC.

# STORAGE

#### Amazon Elastic Block Store / EBS -> fournit des volumes de stockage (par bloc), utilisable avec instance(s) EC2

    - Ressource de niveau 'zone de disponibilité' -> ex: centre de données us-west-1a
    - Volumes de donnée fix

#### Amazon Elastic File System / EFS -> partage de fichier entre plusieurs clients (par bloc)

    - Permet plusieurs opérations simultanées en lecture / écriture
    - Système de fichiers linux
    - Ressource régionale -> ex: centre de données us-west-1a, us-west-1b, us-west-1c ...
    - Stockage illimité

#### Amazon Simple Storage Service / S3 -> stockage d'objects (données, métadonnées, clé), qui est être stocké sur du long terme
    
    - Objets individuels d'une taille de 5 000 gigaoctets
    - Chaque objet a une URL dont vous pouvez contrôler les droits d'accès pour décider qui peut voir ou gérer l'image.
    - Ressource régionale -> ex: centre de données us-west-1a, us-west-1b, us-west-1c ...
    - Durables à 99, 999 999 %
    - Stockage illimité


##### Bloc vs Object

Le stockage d'objets traite n'importe quel fichier comme un objet complet et discret.
C'est génial pour les documents et les fichiers image et vidéo qui sont téléchargés et consommés en tant qu'objets entiers,
mais chaque fois qu'il y a une modification de l'objet, vous devez télécharger à nouveau l'intégralité du fichier.
Il n'y a pas de mises à jour delta. Le stockage par bloc décompose ces fichiers en petites parties ou blocs de composants.
Cela signifie que, pour un fichier video de 80 gigaoctets, lorsque vous effectuez une modification à une scène du film et que vous l'enregistrez,
le moteur ne met à jour que les blocs où se trouvent ces bits. Si vous faites plusieurs micro-modifications, utiliser EBS,
Elastic Block Storage, est le cas d'utilisation parfait. Si vous utilisiez S3, chaque fois que vous enregistrez les modifications,
le système doit charger les 80 gigaoctets, la totalité, à chaque fois.

# AWS INTERACTION SERVICES

#### AWS Management Console

    - Interface basée sur le web
    - Accéder à vos services AWS et les gérer
    - Surveillance des ressources, affichage des alarmes et accès aux informations de facturation
    - Plusieurs identités peuvent rester connectées à l'application mobile AWS Console en même temps

#### AWS CLI

    - Interface de ligne de commande
    - Contrôler plusieurs services AWS directement à partir de la ligne de commande
    - Disponible pour les utilisateurs sous Windows, macOS et Linux 
    - Automatiser les actions effectuées par vos services et applications à l'aide de scripts

#### Kits SDK (approche programmatique)

    - API conçue pour votre langage de programmation ou votre plateforme

#### AWS Elastic Beanstalk

    Vous fournissez le code et les paramètres de configuration, et Elastic Beanstalk déploie les ressources nécessaires pour effectuer les tâches suivantes :

        - Ajustement de la capacité
        - Load balancing
        - Mise à l'échelle automatique
        - Surveillance de la santé des application

#### AWS CloudFormation

    - Infrastructure as code (json, yaml...)

