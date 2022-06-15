import 'package:flutter/material.dart';
import 'package:m2l/animations/affichage_anime.dart';
import 'package:m2l/class/RequeteApi.dart';
import 'package:m2l/main.dart';
import 'package:m2l/navBar.dart';
import 'package:date_time_picker/date_time_picker.dart';

// Initilisation de l'appel à l'api
RequeteApi api = RequeteApi();

// Interface d'affiche des réservations de l'utilisateur courant
class Recherche extends StatefulWidget {
  // Variable de récupération de la saisie à rechercher
  final String statutConnexion;
  final dynamic userConnect;
  final String saisie;

  // Constructeur de la class de recherche
  const Recherche(
      {Key? key,
      required this.statutConnexion,
      this.userConnect,
      required this.saisie});

  @override
  State<Recherche> createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {
  // Déclaration de variable
  String newSaisie = '';

  @override
  Widget build(BuildContext context) {
    // Initialisation de la première saisie
    newSaisie = widget.saisie;

    return Scaffold(
      backgroundColor: couleurOrangePale,
      drawer: widget.statutConnexion == 'connecte'
          ? NavBar(
              userConnect: widget.userConnect,
            )
          : null,
      appBar: AppBar(
        title: const Text(
          'Rerchercher une réservation',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(192, 253, 250, 236)),
        ),
        backgroundColor: couleurJaune,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Container(
            child: Column(children: [
              // Barre de recherche
              DelayedAnimation(
                  delay: 1000,
                  child: BarreRecherche(
                    saisie: newSaisie,
                  )),
              const SizedBox(
                height: 20,
              ),
              /*/ Liste des réservations correspondant à la recherche
              for (var reservation in listeReservation.where((reservation) =>
                  reservation['name']
                      .toString()
                      .toLowerCase()
                      .contains(newSaisie.toLowerCase())))
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
                        ))
                ),*/
            ]),
          )),
    );
  }
}

// BARRE DE RECHERCHE DES RESERVATIONS AVEC CRITETES DE SELECTION
class BarreRecherche extends StatefulWidget {
  String saisie;
  BarreRecherche({Key? key, required this.saisie}) : super(key: key);

  @override
  State<BarreRecherche> createState() => _BarreRechercheState();
}

class _BarreRechercheState extends State<BarreRecherche> {
  // Clé du formulaire
  final _formKey = GlobalKey<FormState>();

  // Requête d'authentification
  // Future<String> Reservations(email, mdp) async {
  //   // Reservations à l'API
  //   return await api.Reservations(email, mdp);
  // }

  // Déinition et initialisation de la valeur par défaut des choix
  int domaine = 1;
  String periodicite = 'Jour';
  int nomSalle = 5;
  String type = 'Amphithéâtre';
  String nomDomaine = 'Plongée sous-marine';

  // Variables et initialisation des champs de saisie
  var saisie = TextEditingController();
  String? dateTrie;

  var listeReservation = [
    {'name': 'Réunion', 'date': '12/11/2021', 'salle': 1, 'domaine': 2},
    {'name': 'Conférence', 'date': '17/10/2021', 'salle': 2, 'domaine': 1},
    {'name': 'Cours', 'date': '10/07/2021', 'salle': 3, 'domaine': 1},
    {'name': 'Festivités', 'date': '12/11/2021', 'salle': 2, 'domaine': 3},
    {
      'name': 'Cours de travail',
      'date': '12/11/2021',
      'salle': 1,
      'domaine': 2
    },
    {'name': 'Séminaire', 'date': '01/04/2021', 'salle': 2, 'domaine': 3},
    {'name': 'Stage', 'date': '28/09/2021', 'salle': 2, 'domaine': 3},
    {'name': 'Palabre', 'date': '31/12/2021', 'salle': 2, 'domaine': 3},
  ];

  @override
  void didUpdateWidget(BarreRecherche barreDeRecherche) {
    super.didUpdateWidget(barreDeRecherche);
  }

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
    // Récupération de la donnée à rechercher
    saisie.text = widget.saisie;

    // Récupération du formulaire
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Barre de recherche
          Row(
            children: [
              // Conteneur de la barre de recherche
              Expanded(
                child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        // color: const Color.fromARGB(108, 219, 218, 218),
                        color: Colors.amber.shade300),
                    child: Center(
                        child: TextField(
                      style: const TextStyle(fontSize: 15, letterSpacing: 1),
                      controller: saisie,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          hintText: 'Décrivez la réservation...',
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
                  // color: const Color.fromARGB(150, 219, 218, 218),
                  color: Colors.amber.shade300,
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      // Mise à jour des résultats de recherche
                      widget.saisie = saisie.text;
                    });
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
          ),
          // Critères de tri de réservation
          Container(
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  child: // Entrée de la date et de l'heure de début
                      DateTimePicker(
                    type: DateTimePickerType.date,
                    autovalidate: true,
                    dateMask: 'dd/MM/yyyy',
                    initialValue: DateTime.now().toString(),
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2025),
                    icon: const Icon(Icons.event),
                    dateLabelText: 'Date de réservation',
                    selectableDayPredicate: (date) {
                      // Disable weekend days to select from the calendar
                      if (date.weekday == 6 || date.weekday == 7) {
                        return false;
                      }
                      return true;
                    },
                    onChanged: (val) {},
                    onSaved: (val) {
                      // Enregistrement de la date et l'heure de début de réservation
                      dateTrie = val;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // Sélection du domaine
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: const Text(
                        'Domaine : ',
                        style: TextStyle(
                          fontSize: 17,
                          color: couleurBleu,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        value: nomDomaine,
                        icon: const Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            // Modification dynamique
                            switch (newValue) {
                              case 'Pétanque':
                                domaine = 2;
                                nomSalle = 1;
                                nomDomaine = newValue!;
                                break;
                              case 'Tennis':
                                domaine = 3;
                                nomSalle = 6;
                                nomDomaine = newValue!;
                                break;
                              default:
                                domaine = 1;
                                nomSalle = 5;
                                nomDomaine = newValue!;
                            }
                          });
                        },
                        items: <String>[
                          'Plongée sous-marine',
                          'Pétanque',
                          'Tennis'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                // Sélection de la salle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      child: const Text(
                        'Salle : ',
                        style: TextStyle(
                          fontSize: 17,
                          color: couleurBleu,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: GetSalles(
                        indomaine: domaine,
                        initSalle: nomSalle,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          // Liste des réservations correspondant à la recherche
          for (var reservation in listeReservation.where((reservation) =>
              reservation['name']
                  .toString()
                  .toLowerCase()
                  .contains(saisie.text.toLowerCase())))
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
                        // Titre de la réservation
                        Text(
                          reservation['name'].toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Salle affiliée à la réservation
                        Text('Salle ' + reservation['salle'].toString()),
                        const SizedBox(
                          height: 5,
                        ),
                        // Date de début de la réservation
                        Text(reservation['date'].toString())
                      ],
                    ))),
        ],
      ),
    );
  }
}

// CLASS DE RECUPERATION DES SALLES
class GetSalles extends StatefulWidget {
  final int indomaine;
  int initSalle;
  GetSalles({Key? key, required this.indomaine, required this.initSalle});

  @override
  State<GetSalles> createState() => _GetSallesState();
}

// Formattage des salles récupérées
class _GetSallesState extends State<GetSalles> {
  // Variables de récupération des salles du domaine 1
  late Iterable<dynamic> reservationsDomaine;

  @override
  void didUpdateWidget(GetSalles planning) {
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
            reservationsDomaine = snapshot.data!['salles']
                .where((salle) => salle['area_id'] == widget.indomaine);
            // Formatage des réservations de chaque salle du domaine sélectionné
            return DropdownButton<int>(
              value: widget.initSalle,
              icon: const Icon(Icons.arrow_drop_down),
              isExpanded: true,
              onChanged: (int? newValue) {
                setState(() {
                  // Mise à jour de l'identifiant
                  widget.initSalle = newValue!;
                });
              },
              items: reservationsDomaine
                  .map<DropdownMenuItem<int>>((dynamic value) {
                return DropdownMenuItem<int>(
                  value: value['id'],
                  child: Text(value['room_name'].toString()),
                );
              }).toList(),
            );
          } else {
            return const Center(child: Text('Pas de données'));
          }
        });
  }
}
