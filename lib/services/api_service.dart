import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;


  final String esp32Url = "http://192.168.4.1";

  ApiService(this.baseUrl);

  // Fonction pour récupérer la température
  Future<String> fetchTemperature() async {
    try {
      // Utilisation de l'ESP32 pour récupérer la température
      final response = await http.get(Uri.parse('$esp32Url/readTemperature'));

      if (response.statusCode == 200) {
        return response.body; // Retourne la température
      } else {
        throw Exception('Erreur HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion : $e');
    }
  }

  // Fonction pour récupérer la luminosité
  Future<String> fetchLuminosity() async {
    try {
      // Utilisation de l'ESP32 pour récupérer la luminosité
      final response = await http.get(Uri.parse('$esp32Url/readLumiere'));

      if (response.statusCode == 200) {
        return response.body; // Retourne la luminosité
      } else {
        throw Exception('Erreur HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion : $e');
    }
  }

  // Fonction pour allumer la LED
  Future<void> turnOnLed() async {
    await _sendCommand('$esp32Url/led/on');
  }

  // Fonction pour éteindre la LED
  Future<void> turnOffLed() async {
    await _sendCommand('$esp32Url/led/off');
  }

  // Fonction pour envoyer une commande à l'ESP32
  Future<void> _sendCommand(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Erreur ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion');
    }
  }
}
