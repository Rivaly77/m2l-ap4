// Importation des packages de constrcution de pages
import 'package:flutter/material.dart';
import 'package:m2l/animations/affichage_anime.dart';
import 'package:m2l/class/RequeteApi.dart';
import 'package:m2l/accueil.dart';
import 'package:m2l/main.dart';

// Initilisation de l'appel à l'api
RequeteApi api = RequeteApi();

// Interface d'affiche des réservations
class Salles extends StatelessWidget {
  final String? action;
  const Salles({Key? key, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '$action de salles',
            style: const TextStyle(color: Color.fromARGB(192, 253, 250, 236)),
          ),
          backgroundColor: couleurJaune,
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
          child: const DelayedAnimation(delay: 1000, child: FormSalles()),
        )));
  }
}

// Page de Reservations à l'application
class FormSalles extends StatefulWidget {
  const FormSalles({Key? key}) : super(key: key);

  // String dateFin = '';

  @override
  State<FormSalles> createState() => _FormFormSallesState();
}

class _FormFormSallesState extends State<FormSalles> {
  // Clé du formulaire
  final _formKey = GlobalKey<FormState>();

  // Requête d'authentification
  // Future<String> Reservations(email, mdp) async {
  //   // Reservations à l'API
  //   return await api.Reservations(email, mdp);
  // }

  // Déinition et initialisation de la valeur par défaut des choix
  int domaine = 1;
  String nomDomaine = 'Plongée sous-marine';

  // Variables et initialisation des champs de saisie
  var nameSalle = TextEditingController();
  var capacite = TextEditingController();

  // Initialisation des saisies du formulaire
  @override
  void dispose() {
    // Initialisation de chaque champ
    nameSalle.dispose();
    capacite.dispose();

    // Lancement de l'inialisation des champs
    super.dispose();
  }

  // Formulaire rendu
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Titre du formulaire de création/modification de salles
          const Center(
            child: Text(
              'SALLES',
              style: TextStyle(
                  color: couleurBleu,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Nom de la salle
          TextFormField(
            controller: nameSalle,
            decoration: const InputDecoration(
              labelText: 'Nom de la salle',
              labelStyle: TextStyle(color: couleurBleu),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ doit être rempli';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          // Capacité de la salle
          TextFormField(
            controller: capacite,
            decoration: const InputDecoration(
              labelText: 'Capacité',
              labelStyle: TextStyle(color: couleurBleu),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ doit être rempli';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ), // Sélection du domaine lié à la salle
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
                  items: <String>['Plongée sous-marine', 'Pétanque', 'Tennis']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          // Bouton de création de la salle
          DelayedAnimation(
            delay: 2000,
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: couleurJaune,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.all(10)),
                child: const Text('Créer',
                    style: TextStyle(fontSize: 20, letterSpacing: 2)),
                onPressed: () async {
                  // if (_formKey.currentState!.validate()) {
                  //   // Authentification
                  //   var email = 'moi@gmail.com';
                  //   var mdp = 'moi';
                  //   var reponse =
                  //       // await api.Reservations(saisieEmail.text, saisieMdp.text);
                  //       await api.Reservations(email, mdp);

                  //   // Vérification de la réponse d'authentification
                  //   if (reponse['statut'] == 'on') {
                  //     // Redirection vers l'accueil pour les visiteurs inscrits
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) =>
                  //                 Accueil(reponse['utilisateur'])));
                  //   } else if (reponse['statut'] == 'invalide') {
                  //   } else {
                  //     // Redirection vers la page d'inscription pour les non inscrits
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const Inscription()));
                  //   }
                  // }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
