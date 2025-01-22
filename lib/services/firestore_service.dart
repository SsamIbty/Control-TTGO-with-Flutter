import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveSensorData(String temperature, String luminosity) async {
    await _firestore.collection('sensorData').add({
      'temperature': temperature,
      'luminosity': luminosity,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}