import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/api_service.dart';
import '../widgets/MenuDrawer.dart';
import 'ThresholdSettingsScreen.dart';

class LedControlScreen extends StatefulWidget {
  final ApiService apiService;

  LedControlScreen({required this.apiService});

  @override
  _LedControlScreenState createState() => _LedControlScreenState();
}

class _LedControlScreenState extends State<LedControlScreen> {
  String ledStatus = "OFF";
  String temperature = "Loading...";
  String luminosity = "Loading...";
  Timer? _timer;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchSensorData();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _fetchSensorData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchSensorData() async {
    try {
      final temp = await widget.apiService.fetchTemperature();
      final light = await widget.apiService.fetchLuminosity();
      setState(() {
        temperature = temp;
        luminosity = light;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('')),
      );
      setState(() {
        temperature = "Erreur";
        luminosity = "Erreur";
      });
    }
  }

  Future<void> turnOnLed() async {
    setState(() {
      isLoading = true;
    });
    try {
      await widget.apiService.turnOnLed();
      setState(() {
        ledStatus = "ON";
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Impossible d\'allumer la LED.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> turnOffLed() async {
    setState(() {
      isLoading = true;
    });
    try {
      await widget.apiService.turnOffLed();
      setState(() {
        ledStatus = "OFF";
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Impossible d\'éteindre la LED.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrôle LED', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      drawer: MenuDrawer(user: null),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(color: Colors.grey[200]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centre tous les widgets verticalement
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: Icon(
                ledStatus == "ON"
                    ? FontAwesomeIcons.solidLightbulb
                    : FontAwesomeIcons.lightbulb,
                key: ValueKey(ledStatus),
                color: ledStatus == "ON" ? Colors.amber : Colors.yellow,
                size: 100,
              ),
            ),
            SizedBox(height: 20),
            Text('LED : $ledStatus', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            Text('Température : $temperature °C', style: TextStyle(fontSize: 18)),
            Text('Luminosité : $luminosity lux', style: TextStyle(fontSize: 18)),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: isLoading ? null : turnOnLed,
                  icon: Icon(Icons.lightbulb, color: Colors.white),
                  label: Text('Allumer'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: isLoading ? null : turnOffLed,
                  icon: Icon(Icons.lightbulb_outline, color: Colors.white),
                  label: Text('Éteindre'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
            SizedBox(height: 40), // Ajout d'un espacement contrôlé
            ElevatedButton.icon(
              onPressed: () {
                // Navigation vers ThresholdSettingsScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThresholdSettingsScreen(),
                  ),
                );
              },
              icon: Icon(Icons.settings, color: Colors.white),
              label: Text('Réglages'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
