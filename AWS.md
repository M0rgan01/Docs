# SERVICES LIST AWS:

#### Amazon Elastic Compute Cloud / EC2 (serveurs virtuels appelés instances EC2)

    - Type d'instance:
        - usage général
        - calcul optimisé
        - mémoire optimisée
        - calcul accélé
        - stockage optimisé

    - Type de tarification:
        - à la demande
        - "Savings Plan Amazon EC2"
        - instances réservées
        - instance Stot
        - Hôtes dédiés

    - Type de mise à l'échelle (Auto Scaling Amazon EC2):
        - dynamique
        - prédictive

    - Load Balancing -> Elastic Load Balancing

#### AWS Lambda (serverless -> execution de code sur déclencheurs, 15min max)

#### Amazon Simple Queue Service / SQS

#### Amazon Simple Notification Service / SNS

#### Amazon Elastic Container Service / ECS

#### Amazon Elastic Service Kubernetes / EKS

#### AWS Fargate (serverless -> permet d'exécuter vos conteneurs au-dessus d'une plateforme de calcul serverless)

#### Amazon CloudFront (CDN) -> permet de faire une copie (cache) d'une région dans une autre pour se rapprocher de certains clients

#### Amazon Route 53 (DNS) -> service de noms de domaine

#### Amazon Virtual Private Cloud / VPC -> permet définir les services public (accessible depuis internet) et les services privé (accessible uniquement pour les autres services, ex: DB)


# STORAGE

#### Amazon Elastic Block Store / EBS -> fournit des volumes de stockage (par bloc), utilisable avec instance(s) EC2

- Ressource de niveau 'zone de disponibilité' -> ex: centre de données us-west-1a
- Volumes de donnée fix

#### Amazon Elastic File System / EFS -> partage de fichier entre plusieurs clients (par bloc)

- Permet plusieurs opération simultanées en lecture / écriture
- Système de fichiers linux
- Ressource régionale -> ex: centre de données us-west-1a, us-west-1b, us-west-1c ...
- Stockage illimitée

#### Amazon Simple Storage Service / S3 -> stockage d'objects (données, métadonnées, clé), qui est être stocké sur du long terme

- Objets individuels d'une taille de 5 000 gigaoctets
- Chaque objet a une URL dont vous pouvez contrôler les droits d'accès pour décider qui peut voir ou gérer l'image.
- Ressource régionale -> ex: centre de données us-west-1a, us-west-1b, us-west-1c ...
- Durables à 99, 999 999 %
- Stockage illimitée


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

#### AWS Management Console (UI)

#### AWS CLI (interface de ligne de commande)

#### kits SDK (approche programmatique)

#### AWS Elastic Beanstalk (application as code) pour :

    - Ajustement de la capacité
    - Load balancing
    - Mise à l'échelle automatique
    - Surveillance de la santé des application

#### AWS CloudFormation (infrastructure as code -> json, yaml...)

