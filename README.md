# ttgo_flutter



Cette application Flutter permet de récupérer des données de capteurs (température, luminosité) depuis un ESP32 via une API RESTful et d'interagir avec un dispositif ESP32 pour contrôler une LED. L'application affiche les données des capteurs et permet à l'utilisateur de contrôler l'état de la LED. Elle offre également une interface de réglage de seuil et une interface de statistiques pour visualiser l'usage et la localisation des capteurs.

## Fonctionnalités

1. **Affichage des Données des Capteurs** : L'application récupère et affiche les données de température et de luminosité à partir d'un ESP32 via une API RESTful. Les données peuvent être affichées sous différents formats (textuel, JSON, graphique).
   
2. **Contrôle de la LED** : L'application permet de contrôler l'allumage et l'extinction de la LED sur l'ESP32 via l'API. L'état de la LED est mis à jour en temps réel dans l'application.
   
3. **Interface de Réglage de Seuil** : L'utilisateur peut définir un seuil pour activer ou désactiver la LED en fonction des données des capteurs (par exemple, allumer la LED si la température dépasse un certain seuil).
   
4. **Interface de Statistiques** : L'application permet à l'utilisateur de visualiser les statistiques d'utilisation des capteurs et de surveiller les performances et la localisation des capteurs.

5. **Stockage des Données** : Les données des capteurs sont stockées dans Firebase Firestore pour permettre la persistance des données au-delà du streaming en temps réel.

## Prérequis

- **Flutter** : Assurez-vous que Flutter est installé sur votre machine. Vous pouvez suivre les instructions d'installation officielles de Flutter ici : [Flutter Installation](https://flutter.dev/docs/get-started/install).
  
- **Firebase** : Vous devez configurer Firebase pour utiliser Firestore et Firebase Core dans votre application. Vous pouvez trouver des instructions sur la configuration de Firebase avec Flutter ici : [Firebase avec Flutter](https://firebase.flutter.dev/docs/overview).


