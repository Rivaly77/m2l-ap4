import 'package:flutter/material.dart';
import 'package:m2l/animations/affichage_anime.dart';
import 'package:m2l/class/RequeteApi.dart';
import 'package:m2l/main.dart';
import 'package:m2l/navBar.dart';
import 'package:m2l/reservations/form.dart';

// Initilisation de l'appel à l'api
RequeteApi api = RequeteApi();

// Interface d'affiche des réservations de l'utilisateur courant
class SelectReservation extends StatefulWidget {
  // Variable de stockage du statut du visiteur
  final String statutUser;
  final dynamic dataUser;
  final int idReservation;

  // Constructeur de la class d'accueil avec récupération du statut du visiteur
  const SelectReservation(
      {Key? key,
      required this.statutUser,
      required this.dataUser,
      required this.idReservation});

  @override
  State<SelectReservation> createState() => _SelectReservationState();
}

class _SelectReservationState extends State<SelectReservation> {
  // Déclaration de variable
  // final idUser;

  // Constructeur

  // Variable de stockage de la donnée
  // late Future<dynamic> dataUser;

  @override
  Widget build(BuildContext context) {
    const reservations = [
      {
        'id': 1,
        'name': 'Réunion',
        'duree': 3,
        'capacite': 50,
        'createur': 'Dupont Jean',
        'date': '2022-06-13'
      },
      {
        'id': 2,
        'name': 'Séminaire',
        'duree': 2,
        'capacite': 30,
        'createur': 'Dupont Marc',
        'date': '2022-06-13'
      },
      {
        'id': 3,
        'name': 'Stage',
        'duree': 3,
        'capacite': 18,
        'createur': 'Mr Pierre',
        'date': '2022-06-13'
      },
      {
        'id': 4,
        'name': 'Séminaire',
        'duree': 2,
        'capacite': 30,
        'createur': 'Dupont Marc',
        'date': '2022-06-14'
      },
      {
        'id': 5,
        'name': 'Stage',
        'duree': 3,
        'capacite': 18,
        'createur': 'Mr Pierre',
        'date': '2022-06-14'
      },
      {
        'id': 6,
        'name': 'Cours de réseau',
        'duree': 3,
        'capacite': 30,
        'createur': 'Mr Rodrigue',
        'date': '2022-06-12'
      },
      {
        'id': 7,
        'name': 'Réunion professionnelle',
        'duree': 4,
        'capacite': 18,
        'createur': 'Mr Jean',
        'date': '2022-06-12'
      }
    ];
    // Initiaisation de la réservation sélectionnée
    dynamic reservationAffiche = reservations
        .where((reservation) => reservation['id'] == widget.idReservation);

    // Récupération de la réservation correspondante
    for (var reserv in reservationAffiche) {
      reservationAffiche = reserv;
    }

    // Récupération de la page
    return Scaffold(
      backgroundColor: couleurOrangePale,
      drawer: widget.statutUser == 'connecte'
          ? NavBar(
              userConnect: widget.dataUser,
            )
          : null,
      appBar: AppBar(
        title: const Text(
          'Réservation',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(192, 253, 250, 236)),
        ),
        backgroundColor: couleurJaune,
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(children: [
          const SizedBox(
            height: 40,
          ),
          DelayedAnimation(
              delay: 1000,
              child: Container(
                child: Text(reservationAffiche['name']),
              )),
          const SizedBox(
            height: 50,
          ),
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

// BOUTON DE RESERVATION DE SALLE OU D'AFFICHAGE D'UNE NOTIFICATION D'ALERTE
class AfficheReservation extends StatefulWidget {
  final int id;
  final dynamic dataConnect;
  const AfficheReservation(
      {Key? key, required this.id, required this.dataConnect})
      : super(key: key);

  @override
  State<AfficheReservation> createState() => _AfficheReservationState();
}

// Formatage du bouton
class _AfficheReservationState extends State<AfficheReservation> {
  // Widget d'affichage de la boite d'alerte en dialogue
  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ALERTE RESERVATION'),
          content: const Text(
              'Vous n\'avez pas les autorisations nécessaires pour réserver.'),
          actions: <Widget>[
            // Bouton de retour au planning
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Revenir au planning'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: couleurJaune,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.all(12)),
      // Bouton de réservation
      child: const Text(
        'Réserver une salle',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
      ),
      onPressed: () {
        // Vérification du statut de l'utilisation pour une redirection
        if (widget.id == 1) {
          // Redirection vers le formulaire de réservation de salles
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Reservations(
                        userData: widget.dataConnect,
                      )));
        } else {
          // Affichage de l'alerte en cas d'utilisateur non connecté
          showAlert(context);
        }
      },
    );
  }
}
