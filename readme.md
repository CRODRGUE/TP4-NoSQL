# Atelier Elasticsearch & Kibana

## Explication de l'Architecture

#### Choix de l’environnement 

Le parti-pris pour mettre en place les différents services, a été la conteneurisation de celles-ci avec l’utilisation de Docker. Ce choix s’explique par le fait que cette approche offre une gestion plus flexible des ressources, une isolation accrue et facilite le déploiement sur des environnements différents, donc utilisable avec environnements Windows ou bien Linux…

[lien documentation configuration kibana](https://www.elastic.co/guide/en/kibana/current/docker.html)
[lien documentation configuration elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/8.13/docker.html)
[lien documentation configuration logstash](https://www.elastic.co/guide/en/logstash/current/docker-config.html)

#### Architecture des services 

Le docker compose est composé de quatre services : mysql, elasticsearch, kibana et logstash. Le service "MySQL" permet de faire tourner un serveur MySQL qui va contenir une base de données. Le service "Elasticsearch" va permettre de stocker les données présentes dans la base de données du serveur MySQL dans l'objectif de pouvoir profiter des performances de recherche & indexage de celui-ci. Quant au service "Logstash", lui va permettre de faire lien entre la base de données relationnelles MySQL et Elasticsearch, en mettant en place une pipeline qui va récupérer les données et les injecter dans Elasticsearch. Puis enfin le service "Kibana", lui va permettre de visualiser les données d'Elasticsaerch grâce à l'interface graphique.

Voir fichier "docker-compose.yml" pour la conteneurisation des différents services

#### Configuration de la pipeline 

Voici ci-dessous une explication du fichier de configuration pour la mise en place de la pipeline utilisée par Logstash pour lier MySQL à Elesticsearch : 

```bash
input {
  jdbc {
    jdbc_connection_string => "jdbc:mysql://mysql:3306/TP4_BDD" #Lien vers la base de données
    jdbc_user => "user_es" # Nom d'utilisateur
    jdbc_password => "azerty13" # Mot de passe
    jdbc_driver_library => "/usr/share/logstash/mysql-connector-j-8.4.0/mysql-connector-j-8.4.0.jar" # Lien des fichiers pour le plugin de connexion mysql
    jdbc_driver_class => "com.mysql.cj.jdbc.Driver"
    statement => "SELECT * FROM products" # Requête exécutée pour récupérer les données
    schedule => "* * * * *" # Récupération des données toute les minutes
  }
}

output {
  elasticsearch {
    hosts => ["http://elasticsearch:9200"]
    index => "products" # Nom de l'index des données
    document_id => "%{id}" # Récupération de l'id de la ressource pour l'indexer dans l'index "products"
  }
  stdout { codec => json_lines }
}
```

#### Comment démarrer le projet avec Docker ?

1. Ouvrir un terminal sur la machine, puis cloner le dépôt grâce à la commande suivante :

``` bash
git clone https://github.com/CRODRGUE/TP4-NoSQL.git
```

2. Se déplacer dans le dossier nommé "TP4-NoSQL", Grâce à la commande :

``` bash
cd TP4-NoSQL/
```
3. Démarrer les services en utilisant docker compose pour effectuer cela, il faut exécuter la commande suivante qui permet de lancer les services en arrière-plan :

``` bash
docker-compose up -d 
```
4. Vérifier l'état des différents conteneurs, grâce à la commande ci-dessous :
``` bash
docker ps -a 
```
## Injection des données fausses

Pour injecter des fausses données, il faut avoir au préalable effectué la partie "Comment démarrer le projet avec Docker ?". Premièrement, il faudra accéder au terminal du service "MySQL" en utilisant la commande ci-dessous :

```bash
docker exec -it mysql mysql -p
# Mot de passe : rootPWD
```
Ensuite, il suffira de copier-coller le contenu du fichier "mysql/script.sql" dans le terminal pour créer la base de données et ajouter les fausses données. Pour vérifier que les données sont bien ajouter, il faut exécuter les commandes ci-dessous toujours dans le termianl mysql :

```mysql
USE TP4_BDD;
SELECT * FROM products;
```

## Vérification de liaison de entre Elasticsearch & MySQL

Pour vérifier qu'Elasticsearch et MySQL soit correctement liés, il suffit de vérifier que les données soit présentes dans Elasticsearch pour l'index "products". Deux possibilités l'utilisation de l'API avec CURL ou bien l'utilisation de l'interface graphique avec le service "Kibana". Voici un exemple avec l'API d'Elasticsearch :

Pour vérifier, il suffit d'exécuter cette commande avec l'utilisation de CURL pour envoyer des requêtes HTTP :

```bash
curl -X GET "localhost:9200/products/_search?pretty"

#Exemple réponse :
{
  "took" : 3,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 20,
      "relation" : "eq"
    },
    "max_score" : 1.0,
    "hits" : [
      {
        "_index" : "products",
        "_id" : "13",
        "_score" : 1.0,
        "_source" : {
          "name" : "Snow Boots",
          "@version" : "1",
          "id" : 13,
          "@timestamp" : "2024-05-31T15:30:00.952700793Z",
          "date_created" : "2024-05-22T00:00:00.000Z",
          "price" : 109.99,
          "description" : "Insulated snow boots for cold weather."
        }
      },
      {
        "_index" : "products",
        "_id" : "17",
        "_score" : 1.0,
        "_source" : {
          "name" : "Clogs",
          "@version" : "1",
          "id" : 17,
          "@timestamp" : "2024-05-31T15:30:00.956251607Z",
          "date_created" : "2024-05-26T00:00:00.000Z",
          "price" : 39.99,
          "description" : "Comfortable clogs with a durable design."
        }
      },...
```