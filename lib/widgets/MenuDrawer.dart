import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/HomeScreen.dart';
import '../screens/LedControlScreen.dart';  // Vérifie que ce chemin est correct
import '../screens/SignIn.dart';
import '../screens/StatisticsScreen.dart';
import '../screens/login_screen.dart';
import '../services/api_service.dart';

class MenuDrawer extends StatelessWidget {
  final User? user;

  MenuDrawer({this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.black87),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 50,
                ),
                SizedBox(height: 10),
                // Vérification de user null avant d'accéder à ses propriétés
                Text(
                  user != null ? 'Bonjour, ${user!.displayName ?? 'Ibtissam'}' : 'Bienvenue, Ibtissam',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Accueil'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Connexion'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => login_screen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person_add),
            title: Text('Inscription'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignIn()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text('Contrôle LED'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LedControlScreen(apiService: ApiService('https://example.com/api')),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Statistiques'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => StatisticsScreen(apiService: ApiService('https://example.com/api')),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Déconnexion'),
            onTap: () {
              Navigator.pop(context);
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => login_screen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
