import 'package:flutter/material.dart';

class ThresholdSettingsScreen extends StatefulWidget {
  @override
  _ThresholdSettingsScreenState createState() => _ThresholdSettingsScreenState();
}

class _ThresholdSettingsScreenState extends State<ThresholdSettingsScreen> {
  double temperatureThreshold = 25.0; // Valeur par défaut pour le seuil de température
  double luminosityThreshold = 500.0; // Valeur par défaut pour le seuil de luminosité

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Réglage de Seuil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Définir les seuils pour la LED',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Seuil de Température (°C)',
              style: TextStyle(fontSize: 16),
            ),
            Slider(
              value: temperatureThreshold,
              min: 0,
              max: 70,
              divisions: 50,
              label: temperatureThreshold.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  temperatureThreshold = value;
                });
              },
            ),
            Text(
              'Seuil actuel : ${temperatureThreshold.toStringAsFixed(1)} °C',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Seuil de Luminosité (lux)',
              style: TextStyle(fontSize: 16),
            ),
            Slider(
              value: luminosityThreshold,
              min: 0,
              max: 1000,
              divisions: 100,
              label: luminosityThreshold.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  luminosityThreshold = value;
                });
              },
            ),
            Text(
              'Seuil actuel : ${luminosityThreshold.toStringAsFixed(1)} lux',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Sauvegarder les seuils définis
                  Navigator.pop(context, {
                    'temperatureThreshold': temperatureThreshold,
                    'luminosityThreshold': luminosityThreshold,
                  });
                },
                child: Text('Sauvegarder'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
