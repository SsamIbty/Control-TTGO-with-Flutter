import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dart:async'; // Pour utiliser Timer

class SensorDataWidget extends StatefulWidget {
  final ApiService apiService;

  SensorDataWidget({required this.apiService});

  @override
  _SensorDataWidgetState createState() => _SensorDataWidgetState();
}

class _SensorDataWidgetState extends State<SensorDataWidget> {
  String temperature = "Loading...";
  String luminosity = "Loading...";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Démarrer le Timer pour rafraîchir les données toutes les 5 secondes
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _fetchData();
    });
    // Charger les données immédiatement
    _fetchData();
  }

  @override
  void dispose() {
    // Arrêter le Timer lorsque le widget est supprimé
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchData() async {
    try {
      final temperature = await widget.apiService.fetchTemperature();
      final luminosity = await widget.apiService.fetchLuminosity();
      setState(() {
        this.temperature = temperature;
        this.luminosity = luminosity;
      });
    } catch (e) {
      setState(() {
        temperature = "Erreur";
        luminosity = "Erreur";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Température : $temperature °C', style: TextStyle(fontSize: 20)),
        SizedBox(height: 20),
        Text('Luminosité : $luminosity lux', style: TextStyle(fontSize: 20)),
      ],
    );
  }
}