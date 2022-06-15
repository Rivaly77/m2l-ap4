import 'package:flutter/material.dart';
import 'package:m2l/animations/affichage_anime.dart';
import 'package:m2l/class/RequeteApi.dart';
import 'package:m2l/main.dart';
import 'package:m2l/navBar.dart';
import 'package:m2l/reservations/form.dart';

// Initilisation de l'appel à l'api
RequeteApi api = RequeteApi();

// Interface d'affiche des réservations de l'utilisateur courant
class MesReservations extends StatefulWidget {
  // Variable de stockage du statut du visiteur
  final dynamic dataUser;

  // Constructeur de la class d'accueil avec récupération du statut du visiteur
  const MesReservations({Key? key, required this.dataUser});

  @override
  State<MesReservations> createState() => _MesReservationsState();
}

class _MesReservationsState extends State<MesReservations> {
  // Déclaration de variable
  // final idUser;

  // Constructeur

  // Variable de stockage de la donnée
  // late Future<dynamic> dataUser;

  var listeReservation = [
    {'name': 'Réservation 1', 'date': '12/11/2021', 'salle': 1, 'domaine': 2},
    {'name': 'Réservation 2', 'date': '12/11/2021', 'salle': 2, 'domaine': 1},
    {'name': 'Réservation 3', 'date': '12/11/2021', 'salle': 3, 'domaine': 1},
    {'name': 'Réservation 4', 'date': '12/11/2021', 'salle': 2, 'domaine': 3}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: couleurOrangePale,
      drawer: NavBar(
        userConnect: widget.dataUser,
      ),
      appBar: AppBar(
        title: const Text(
          'Mes réservations',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(192, 253, 250, 236)),
        ),
        backgroundColor: couleurJaune,
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),
          // DelayedAnimation(
          //     delay: 1000,
          //     child: Text(
          //       widget.dataUser!.email,
          //       textAlign: TextAlign.center,
          //     )),
          // const SizedBox(
          //   height: 50,
          // ),
          for (var reservation in listeReservation)
            DelayedAnimation(
                delay: 1500,
                child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                        color: couleurJaune,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          reservation['name'].toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Salle ' + reservation['salle'].toString()),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(reservation['date'].toString())
                      ],
                    ))),
          const SizedBox(
            height: 10,
          ),
        ]),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: couleurJaune,
        onPressed: () {
          // Redirection vers l'interface de gestion des salles de réservation pour les visiteurs authentifiés
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Reservations(
                        userData: widget.dataUser,
                      )));
        },
        child: const Icon(
          Icons.add,
          color: couleurBleu,
        ),
      ),
    );
  }
}
