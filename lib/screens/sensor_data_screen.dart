import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/sensor_data_widget.dart';
import '../widgets/led_control_widget.dart';

class SensorDataScreen extends StatelessWidget {
  final ApiService apiService = ApiService('http://192.168.4.1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ESP32 Control'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SensorDataWidget(apiService: apiService),
            SizedBox(height: 40),
            LedControlWidget(apiService: apiService),
          ],
        ),
      ),
    );
  }
}