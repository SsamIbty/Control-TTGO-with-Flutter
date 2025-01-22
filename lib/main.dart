import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/homeScreen.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP32 Control',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Si l'état de la connexion est en attente, afficher un indicateur de chargement
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Si l'utilisateur est connecté, afficher l'écran d'accueil
          if (snapshot.hasData) {
            return HomeScreen(user: snapshot.data); // Passe l'utilisateur ici
          }

          // Si l'utilisateur n'est pas connecté, afficher l'écran de connexion
          return login_screen(); // Utilise la classe login_screen
        },
      ),
    );
  }
}
