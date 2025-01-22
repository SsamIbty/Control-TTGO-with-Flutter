import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/MenuDrawer.dart';

class HomeScreen extends StatelessWidget {
  final User? user;

  HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TTGO Contrôle',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white), //
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          // Utilisation d'un PopupMenuButton pour afficher l'email dans un menu
          PopupMenuButton<String>(
            icon: Image.asset('assets/logoC.png', width: 40, height: 40),
            onSelected: (value) {
              if (value == 'email') {
                // Affichage de l'email de l'utilisateur dans un SnackBar
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Email : ${user!.email}')),
                  );

                }
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'email',
                  child: Text(user != null ? 'Email : ${user!.email}' : 'Veuillez vous connecter'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondf.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(), // On supprime le texte au centre de la page
        ),
      ),
      drawer: MenuDrawer(user: user), // Utilisation du MenuDrawer
    );
  }
}
