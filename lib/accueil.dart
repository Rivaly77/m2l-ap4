import 'package:flutter/material.dart';
import 'package:m2l/animations/affichage_anime.dart';
import 'package:m2l/connexion.dart';
import 'package:m2l/class/RequeteApi.dart';
import 'package:m2l/main.dart';
import 'package:m2l/navBar.dart';
import 'package:m2l/recherche.dart';
import 'package:m2l/reservations/form.dart';
import 'package:m2l/reservations/view.dart';
import 'package:m2l/reservations/select.dart';

// Initilisation de l'appel à l'api
RequeteApi api = RequeteApi();

// Création de l'interface de la page d'accueil
class Accueil extends StatefulWidget {
  // Variable de stockage du statut du visiteur
  final String statutConnexion;
  final dynamic userConnect;

  // Constructeur de la class d'accueil avec récupération du statut du visiteur
  const Accueil({Key? key, required this.statutConnexion, this.userConnect});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  // Variable de stockage de la donnée
  late Future<dynamic> dataUser;
  AlertDialog? test;
  String nomDomaine = 'Plongée sous-marine';
  int domaine = 1;
  String currentDate = DateTime.now().toString().substring(0, 10);
  bool lastDay = false;
  bool nextDay = false;

  @override
  Widget build(BuildContext context) {
    // Réinitialisation des boutons
    if (lastDay || nextDay) {
      lastDay = nextDay = false;
    }

    // Formatage de la date actuelle
    int newYear = int.parse(currentDate.substring(0, 4));
    int newMonth = int.parse(currentDate.substring(5, 7));
    int newDay = int.parse(currentDate.substring(8, 10));

    return Scaffold(
        backgroundColor: couleurOrangePale,
        drawer: widget.statutConnexion == 'connecte'
            ? NavBar(
                userConnect: widget.userConnect,
              )
            : null,
        appBar: AppBar(
            leading: widget.statutConnexion == 'connecte'
                ? null
                : Image.asset('assets/images/logo_rond.png'),
            backgroundColor: couleurJaune,
            centerTitle: true,
            title: Text(
              widget.statutConnexion == 'non connecte'
                  ? 'Maison des Ligues de Lorraine'
                  : widget.userConnect!.email,
              style: TextStyle(
                  color: widget.statutConnexion == 'connecte'
                      ? null
                      : couleurRouge,
                  fontSize: 17,
                  fontFamily: 'fantasy',
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              // Bouton de connexion ou d'affichage des salles
              IconButton(
                onPressed: () {
                  // Vérification du statut de connexion de visiteur
                  if (widget.statutConnexion == 'connecte') {
                    // Redirection vers l'interface de gestion des réservations de salles pour les visiteurs authentifiés
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MesReservations(dataUser: widget.userConnect)));
                  } else {
                    // Redirection vers le formulaire de connexion pour les visiteurs non authentifiés
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Connexion()));
                  }
                },
                // Style de l'icône du bouton à cliquer suivant le statut de connexion du visiteur
                icon: widget.statutConnexion == 'non connecte'
                    ? const Icon(Icons.login)
                    : const Icon(Icons.room_preferences_outlined),
                color:
                    widget.statutConnexion == 'connecte' ? null : couleurRouge,
                // color: couleurRouge,
                iconSize: 30,
              )
            ]),
        body: SingleChildScrollView(
            child: Container(
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            // BARRE DE RECHERCHE
            DelayedAnimation(
              delay: 1500,
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  // Ligne de la barre de recherche
                  child: BarreRecherche(
                      statut: widget.statutConnexion,
                      dataUser: widget.userConnect)),
            ),
            // PLANNING
            DelayedAnimation(
              delay: 2500,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                // Colonne des lignes du planning
                child: Column(
                  children: [
                    // Ligne de défilement du planning en jours
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Bouton d'affichage du planing sur le jour précédent
                        IconButton(
                            onPressed: () {
                              setState(() {
                                // Modification de la date courante du planning
                                currentDate =
                                    DateTime(newYear, newMonth, newDay)
                                        .subtract(const Duration(days: 1))
                                        .toString()
                                        .substring(0, 10);
                              });
                            },
                            icon: const Icon(Icons.navigate_before)),
                        // Affichage du jour courant du planning
                        Text(
                          'JOUR (' + currentDate + ')',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: couleurBleu,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3),
                        ),
                        // Bouton d'affichage du planing sur le jour précédent
                        IconButton(
                            onPressed: () {
                              setState(() {
                                // Modification de la date courante du planning
                                currentDate =
                                    DateTime(newYear, newMonth, newDay)
                                        .add(const Duration(days: 1))
                                        .toString()
                                        .substring(0, 10);
                              });
                            },
                            icon: const Icon(Icons.navigate_next))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Conteneur des dates et réservations du planning
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          // color: const Color.fromARGB(108, 219, 218, 218),
                          color: couleurJaune,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: const Color.fromARGB(255, 219, 219, 219),
                              width: .3,
                              style: BorderStyle.solid)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            // Colonne des différentes heures de la journée
                            child: Column(children: [
                              // Titre de la colonne Horaire
                              const Text(
                                'HORAIRE',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: couleurBleu),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              // Affichage des différentes heures de la journée
                              for (var i = 0; i < 10; i++)
                                Padding(
                                  padding: const EdgeInsets.all(10.5),
                                  child: Text(
                                    (8 + i).toString() + 'h',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                )
                            ]),
                          ),
                          Expanded(
                              child: Planning(
                            statut: widget.statutConnexion,
                            userData: widget.userConnect,
                            indomaine: domaine,
                            currentDate: currentDate,
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // Conteneur des domaines à sélectionner
                    Container(
                        width: double.infinity,
                        child: DelayedAnimation(
                          delay: 3000,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              // Titre du label de domaine
                              const Text(
                                'DOMAINE : ',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: couleurBleu,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                // Button de sélection des domaines
                                child: DropdownButton<String>(
                                  value: nomDomaine,
                                  isExpanded: true,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      // Sélection et stockage du domaine
                                      switch (newValue) {
                                        case 'Pétanque':
                                          domaine = 2;
                                          nomDomaine = newValue!;
                                          break;
                                        case 'Tennis':
                                          domaine = 3;
                                          nomDomaine = newValue!;
                                          break;
                                        default:
                                          domaine = 1;
                                          nomDomaine = newValue!;
                                      }
                                    });
                                  },
                                  // Liste des dommaines à afficher
                                  items: <String>[
                                    'Plongée sous-marine',
                                    'Pétanque',
                                    'Tennis'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            // RESERVATION DE SALLES
            DelayedAnimation(
                delay: 3500,
                child: Reserver(
                  statut: widget.statutConnexion,
                  dataConnect: widget.userConnect,
                )),
          ]),
        )));
  }
}

/*/ BARRE DE RECHERCHE DE RESERVATIONS
class BarreRecherche extends StatelessWidget {
  final String statut;
  final dynamic dataUser;
  BarreRecherche(
      {Key? key, required this.statut, this.dataUser})
      : super(key: key);

  // Variables et initialisation des champs de saisie
  var saisie = TextEditingController();

  // Initialisation des saisies du formulaire
  @override
  void dispose() {
    // Initialisation de chaque champ
    saisie.dispose();

    // Affectation de la valeur recherchée
    // saisie = widget.saisie;
    saisie.text = widget.saisie;

    // Lancement de l'inialisation des champs
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Conteneur de la barre de recherche
        Expanded(
          child: Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromARGB(108, 219, 218, 218),
              ),
              child: Center(
                  child: TextField(
                controller: saisie,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    hintText: 'Rechercher une réservation',
                    border: InputBorder.none),
              ))),
        ),
        const SizedBox(
          width: 5,
        ),
        // Bouton de lancement de la recherche
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(108, 219, 218, 218),
          ),
          child: IconButton(
            onPressed: () {
              // Redirection vers le formulaire de réservation de salles
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Recherche(
                            statutConnexion: statut,
                            userConnect: dataUser,
                            saisie: saisie.toString(),
                          )));
            },
            icon: const Icon(
              Icons.search,
              // color: couleurBleu,
              color: Color.fromARGB(121, 39, 38, 38),
            ),
            iconSize: 30,
          ),
        ),
      ],
    );
  }
}*/

class BarreRecherche extends StatefulWidget {
  final String statut;
  final dynamic dataUser;
  BarreRecherche({Key? key, required this.statut, this.dataUser})
      : super(key: key);

  @override
  State<BarreRecherche> createState() => _BarreRechercheState();
}

class _BarreRechercheState extends State<BarreRecherche> {
  // Variables et initialisation des champs de saisie
  var saisie = TextEditingController();

  // Initialisation des saisies du formulaire
  @override
  void dispose() {
    // Initialisation de chaque champ
    saisie.dispose();

    // Lancement de l'inialisation des champs
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Conteneur de la barre de recherche
        Expanded(
          child: Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromARGB(108, 219, 218, 218),
              ),
              child: Center(
                  child: TextField(
                controller: saisie,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    hintText: 'Rechercher une réservation',
                    border: InputBorder.none),
              ))),
        ),
        const SizedBox(
          width: 5,
        ),
        // Bouton de lancement de la recherche
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(108, 219, 218, 218),
          ),
          child: IconButton(
            onPressed: () {
              // Redirection vers le formulaire de réservation de salles
              print(saisie.text);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Recherche(
                            statutConnexion: widget.statut,
                            userConnect: widget.dataUser,
                            saisie: saisie.text,
                          )));
            },
            icon: const Icon(
              Icons.search,
              // color: couleurBleu,
              color: Color.fromARGB(121, 39, 38, 38),
            ),
            iconSize: 30,
          ),
        ),
      ],
    );
  }
}

// CLASS DE RECUPERATION DU PLANNING
class Planning extends StatefulWidget {
  final String statut;
  final dynamic userData;
  final int indomaine;
  final String currentDate;
  Planning(
      {Key? key,
      required this.statut,
      required this.userData,
      required this.indomaine,
      required this.currentDate});

  @override
  State<Planning> createState() => _PlanningState();
}

// Formatage du planning
class _PlanningState extends State<Planning> {
  // Variables de récupération des salles du domaine 1
  late List<dynamic> reservationsDomaine;

  // Mise à jour du composant planning
  @override
  void didUpdateWidget(Planning planning) {
    super.didUpdateWidget(planning);
  }

  // Récupération des données du planning
  Future<dynamic> getPlanningData() async {
    return await api.getPlanningData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: getPlanningData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Récupération des salles du domaine sélectionné
            reservationsDomaine = snapshot.data!['salles'];
            // Formatage des réservations de chaque salle du domaine sélectionné
            return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var salle in reservationsDomaine
                        .where((salle) => salle['area_id'] == widget.indomaine))
                      Reservation(widget.statut, widget.userData,
                          salle['room_name'], widget.currentDate)
                  ],
                ));
          } else {
            return const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text('Pas de données'),
                ));
          }
        });
  }
}

// FORMATAGE DES RESERVATION D'UNE SALLE DU DOMAINE SELECTIONNE
class Reservation extends StatelessWidget {
  // Variables locales de la salle
  final String statut;
  final dynamic userData;
  final String nameSalle;
  final String dateReservation;
  // final List<Map<String, dynamic>> reservations;
  static const reservations = [
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

  const Reservation(
      this.statut, this.userData, this.nameSalle, this.dateReservation);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(nameSalle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: couleurBleu,
                )),
          ),
        ),
        for (var reservation in reservations
            .where((aReservation) => aReservation['date'] == dateReservation))
          Container(
            margin: const EdgeInsets.only(top: 3, right: 3),
            width: 150,
            height: (38 * double.parse(reservation['duree'].toString())),
            decoration: BoxDecoration(
                color: Colors.amber.shade300,
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextButton(
                child: Text(
                  reservation['name'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectReservation(
                                statutUser: statut,
                                dataUser: userData,
                                idReservation:
                                    int.parse(reservation['id'].toString()),
                              )));
                },
              ),
            ),
          )
      ],
    );
  }
}

// BOUTON DE RESERVATION DE SALLE OU D'AFFICHAGE D'UNE NOTIFICATION D'ALERTE
class Reserver extends StatefulWidget {
  final String statut;
  final dynamic dataConnect;
  const Reserver({Key? key, required this.statut, required this.dataConnect})
      : super(key: key);

  @override
  State<Reserver> createState() => _ReserverState();
}

// Formatage du bouton
class _ReserverState extends State<Reserver> {
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
        if (widget.statut == 'connecte') {
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
