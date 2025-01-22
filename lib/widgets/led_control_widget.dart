import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'package:http/http.dart' as http;

class LedControlWidget extends StatefulWidget {
  final ApiService apiService;

  LedControlWidget({required this.apiService});

  @override
  _LedControlWidgetState createState() => _LedControlWidgetState();
}

class _LedControlWidgetState extends State<LedControlWidget> {
  String ledStatus = "OFF";

  final String esp32Url = "http://192.168.4.1";

  Future<void> turnOnLed() async {
    try {
      final response = await http.get(Uri.parse('$esp32Url/led/on'));
      if (response.statusCode == 200) {
        setState(() {
          ledStatus = "ON";
        });
      }
    } catch (e) {
      setState(() {
        ledStatus = "Erreur";
      });
    }
  }

  Future<void> turnOffLed() async {
    try {
      final response = await http.get(Uri.parse('$esp32Url/led/off'));
      if (response.statusCode == 200) {
        setState(() {
          ledStatus = "OFF";
        });
      }
    } catch (e) {
      setState(() {
        ledStatus = "Erreur";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: turnOnLed,
                  icon: Icon(Icons.lightbulb),
                  label: Text('Allumer'),
                ),
                SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: turnOffLed,
                  icon: Icon(Icons.lightbulb_outline),
                  label: Text('Éteindre'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'LED : $ledStatus',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Action pour naviguer vers les réglages
              },
              icon: Icon(Icons.settings),
              label: Text('Réglagess'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
