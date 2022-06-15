import 'package:flutter/material.dart';
import 'package:m2l/main.dart';
import 'package:m2l/accueil.dart';
import 'package:m2l/reservations/form.dart';
import 'package:m2l/reservations/view.dart';

// SideBar
class NavBar extends StatelessWidget {
  final dynamic userConnect;
  const NavBar({Key? key, this.userConnect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: couleurJaune),
              accountName: Text(
                userConnect!.statut,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                userConnect!.email,
                style: const TextStyle(fontSize: 25),
              )),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Planning'),
            onTap: () {
              // Redirection vers le planning
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Accueil(
                            userConnect: userConnect,
                            statutConnexion: 'connecte',
                          )));
            },
          ),
          ListTile(
            leading: const Icon(Icons.room),
            title: const Text('Mes réservations'),
            onTap: () {
              // Redirection vers les réservations de l'utilisateur courant
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MesReservations(
                            dataUser: userConnect,
                          )));
            },
          ),
          ListTile(
            leading: const Icon(Icons.meeting_room),
            title: const Text('Créer une réservation'),
            onTap: () {
              // Redirection vers l'interface de gestion des salles de réservation pour les visiteurs authentifiés
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Reservations(
                            userData: userConnect,
                          )));
            },
          ),
          const Divider(
            height: 3,
            indent: 25,
            endIndent: 25,
            color: Colors.black38,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('DECONNEXION'),
            onTap: () {
              // Déconnexion et redirection vers le planning
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Accueil(
                            statutConnexion: 'non connecte',
                            userConnect: null,
                          )));
            },
          ),
        ],
      ),
    );
  }
}
