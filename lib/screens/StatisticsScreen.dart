import 'dart:async'; // Pour le Timer
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Pour les graphiques
import '../services/api_service.dart'; //
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/MenuDrawer.dart';

class StatisticsScreen extends StatefulWidget {
  final ApiService apiService;

  StatisticsScreen({required this.apiService});

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String temperature = "Loading...";
  String luminosity = "Loading...";

  // Historique des valeurs des capteurs
  List<double> temperatureHistory = [];
  List<double> luminosityHistory = [];

  // Timer pour mettre à jour les données en temps réel
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _fetchSensorData(); // Charger les données des capteurs au démarrage
    _startPeriodicUpdates(); // Démarrer les mises à jour périodiques
  }

  // Fonction pour récupérer la température et la luminosité
  Future<void> _fetchSensorData() async {
    try {
      final temp = await widget.apiService.fetchTemperature();
      final light = await widget.apiService.fetchLuminosity();

      setState(() {
        temperature = temp;
        luminosity = light;

        // Convertir les valeurs en double
        double tempValue = double.tryParse(temp) ?? 0.0; // Valeur par défaut si invalid
        double lightValue = double.tryParse(light) ?? 0.0; // Valeur par défaut si invalid

        // Ajouter les nouvelles données à l'historique
        temperatureHistory.add(tempValue);
        luminosityHistory.add(lightValue);
      });
    } catch (e) {
      setState(() {
        temperature = "Erreur";
        luminosity = "Erreur";
      });
      print('Erreur lors de la récupération des données: $e');
    }
  }

  // Démarrer un Timer pour mettre à jour les données toutes les 5 secondes
  void _startPeriodicUpdates() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _fetchSensorData(); // Mettre à jour les données à chaque intervalle
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Annuler le Timer lorsque l'écran est détruit
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Statistiques',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      drawer: MenuDrawer(user: user), // Ajout du MenuDrawer ici
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Centrer le contenu
          children: [
            // Affichage de l'icône de la thermoresistance
            Center(
              child: Column(
                children: [
                  Icon(Icons.thermostat_outlined, color: Colors.red, size: 60),
                  Text(
                    'Thermoresistance',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Graphique en courbe pour la température
            Text(
              'Courbe de la température',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center, // Centrer le texte
            ),
            SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true),
                      titlesData: FlTitlesData(
                        leftTitles: SideTitles(showTitles: true, reservedSize: 32),
                        bottomTitles: SideTitles(showTitles: true),
                        topTitles: SideTitles(showTitles: false), // Désactiver les titres en haut
                        rightTitles: SideTitles(showTitles: false), // Désactiver les titres à droite
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: List.generate(
                            temperatureHistory.length,
                                (index) => FlSpot(index.toDouble(), temperatureHistory[index]),
                          ),
                          isCurved: true, // Courbe lissée
                          colors: [Colors.red], // Couleur rouge pour la température
                          belowBarData: BarAreaData(
                            show: true,
                            colors: [Colors.red.withOpacity(0.3)], // Ombre sous la courbe
                          ), // Zone ombragée sous la courbe
                        ),
                      ],
                      minY: 0, // Température minimale
                      maxY: 70, // Température maximale
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Affichage de l'icône de la photorésistance
            Center(
              child: Column(
                children: [
                  Icon(Icons.wb_sunny, color: Colors.blue, size: 60),
                  Text(
                    'Photoresistance',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Graphique en courbe pour la luminosité
            Text(
              'Courbe de la luminosité',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center, // Centrer le texte
            ),
            SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true),
                      titlesData: FlTitlesData(
                        leftTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (context, value) => TextStyle(
                            fontSize: 10, // Taille de la police plus petite
                            color: Colors.black,
                          ),
                          margin: 8,
                          reservedSize: 30,
                          getTitles: (value) {
                            return "${value.toInt()} lux"; // Affichage des valeurs en lux
                          },
                        ),
                        bottomTitles: SideTitles(showTitles: true),
                        topTitles: SideTitles(showTitles: false), // Désactiver les titres en haut
                        rightTitles: SideTitles(showTitles: false), // Désactiver les titres à droite
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: List.generate(
                            luminosityHistory.length,
                                (index) => FlSpot(index.toDouble(), luminosityHistory[index]),
                          ),
                          isCurved: true, // Courbe lissée
                          colors: [Colors.blue], // Couleur bleue pour la luminosité
                          belowBarData: BarAreaData(
                            show: true,
                            colors: [Colors.blue.withOpacity(0.3)], // Ombre sous la courbe
                          ), // Zone ombragée sous la courbe
                        ),
                      ],
                      minY: 0, // Luminosité minimale
                      maxY: 7000, // Luminosité maximale (ajustez selon vos besoins)
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
