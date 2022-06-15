import 'package:flutter/material.dart';
import 'package:m2l/accueil.dart';

// Déclaration de variables de couleurs
const couleurBleu = Color(0xFF2b4c88);
const couleurRouge = Color(0xFFe02131);
const couleurJaune = Color(0xFFfec816);
const couleurJaune2 = Color(0xFFFAD658);
const couleurJauneClair = Color.fromARGB(255, 253, 250, 244);
const couleurOrangePale = Color.fromARGB(255, 248, 225, 183);
const couleurPale = Color.fromARGB(121, 39, 38, 38);
const orangePale = Color(0xFFffd485);

void main() async {
  runApp(const MyApp());
}

// Construction de l'application
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion des réservations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const Accueil(),
      home: const Accueil(
        statutConnexion: 'non connecte',
        userConnect: null,
      ),
    );
  }
}
