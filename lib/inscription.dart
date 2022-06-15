// Importation des packages de constrcution de pages
import 'package:flutter/material.dart';
import 'package:m2l/animations/affichage_anime.dart';
import 'package:m2l/main.dart';
import 'package:m2l/accueil.dart';

// Création de l'interface de la page d'accueil
class Inscription extends StatelessWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: couleurOrangePale,
        appBar: AppBar(
          backgroundColor: couleurJaune,
          title: const Text('S\'inscrire'),
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: Column(children: [
            DelayedAnimation(
                delay: 1000,
                child: Container(
                    height: 150,
                    child: Image.asset('assets/images/logo_rond.png'))),
            const SizedBox(
              height: 50,
            ),
            const DelayedAnimation(delay: 1500, child: FormInscription())
          ]),
        )));
  }
}

// Formulaire d'inscription
class FormInscription extends StatefulWidget {
  const FormInscription({Key? key}) : super(key: key);

  @override
  State<FormInscription> createState() => _FormInscriptionState();
}

class _FormInscriptionState extends State<FormInscription> {
  // Clé du formulaire
  final _formKey = GlobalKey<FormState>();

  // Déclaration des variables de récupération des champs de texte
  var saisieEmail = TextEditingController();
  var saisieMdp = TextEditingController();
  // var saisieTarif = TextEditingController();
  var typeStatut = 'Particulier';
  var saisieTarif = 4;
  var afficheMdp = true;

  // Requête d'authentification
  Future<String> inscription(email, mdp, droitReservation, niveauTarif) async {
    // Connexion à l'API
    return await api.inscription(email, mdp, droitReservation, niveauTarif);
  }

  // Initialisation des saisies du formulaire
  @override
  void dispose() {
    // Initialisation de chaque champ
    saisieEmail.dispose();
    saisieMdp.dispose();
    // saisieTarif.dispose();

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
          // Adresse électronique de l'utilisateur
          TextFormField(
            controller: saisieEmail,
            decoration: const InputDecoration(
                labelText: 'E-mail',
                labelStyle: TextStyle(
                  color: couleurBleu,
                ),
                contentPadding: EdgeInsets.all(10)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ doit être rempli';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          /*/ Statut (niveau de tarif de l'utilisateur) 
          /TextFormField(
            controller: saisieTarif,
            decoration: const InputDecoration(
                labelText: 'Statut',
                labelStyle: TextStyle(
                  color: couleurBleu,
                ),
                contentPadding: EdgeInsets.all(10)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ doit être rempli';
              }
              return null;
            },
          ),*/
          // Mot de passe de l'utilisateur
          TextFormField(
            controller: saisieMdp,
            obscureText: afficheMdp,
            decoration: InputDecoration(
                labelText: 'Mot de passe',
                labelStyle: const TextStyle(
                  color: couleurBleu,
                ),
                contentPadding: const EdgeInsets.all(10),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        afficheMdp = !afficheMdp;
                      });
                    },
                    icon: const Icon(Icons.visibility))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ doit être rempli';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          // Confirmation du mot de passe
          TextFormField(
            obscureText: afficheMdp,
            decoration: InputDecoration(
                labelText: 'Confirmez votre mot de passe',
                labelStyle: const TextStyle(
                  color: couleurBleu,
                ),
                contentPadding: const EdgeInsets.all(10),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        afficheMdp = !afficheMdp;
                      });
                    },
                    icon: const Icon(Icons.visibility))),
            validator: (value) {
              if (value == null || value.isEmpty || value != saisieMdp.text) {
                return 'Les mots de passe ne correspondent pas !';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          // Statut (niveau de tarif de l'utilisateur)
          Row(
            children: [
              const SizedBox(
                width: 12,
              ),
              Container(
                width: 100,
                child: const Text(
                  'Votre statut : ',
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
                  value: typeStatut,
                  icon: const Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      // Modification dynamique
                      switch (newValue) {
                        case 'Lycée ou collège':
                          saisieTarif = 1;
                          typeStatut = newValue!;
                          break;
                        case 'Particulier':
                          saisieTarif = 4;
                          typeStatut = newValue!;
                          break;
                        case 'Entreprise':
                          saisieTarif = 3;
                          typeStatut = newValue!;
                          break;
                        case 'Ligue':
                          saisieTarif = 2;
                          typeStatut = newValue!;
                          break;
                        default:
                          saisieTarif = 4;
                          typeStatut = newValue!;
                      }
                    });
                  },
                  items: <String>[
                    'Lycée ou collège',
                    'Particulier',
                    'Entreprise',
                    'Ligue',
                    'Autre'
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
          const SizedBox(
            height: 30,
          ),
          // Bouton d'inscription
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: couleurJaune,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.only(
                    top: 12, bottom: 12, left: 25, right: 25)),
            child: const Text('INSCRIPTION', style: TextStyle(fontSize: 17)),
            onPressed: () async {
              // Vérification du formulaire
              if (_formKey.currentState!.validate()) {
                // Authentification
                var reponse = await api.inscription(
                    saisieEmail.text, saisieMdp.text, 0, saisieTarif);

                // Vérification de la réponse d'authentification
                if (reponse['statut'] == 'on') {
                  // Redirection vers la page de connexion
                  // const AlertInscription(statut: 'non connecte');
                  // Redirection vers l'accueil
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Accueil(
                                statutConnexion: 'non connecte',
                                userConnect: null,
                              )));
                } else {
                  // Actualisation de la page d'inscription
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Inscription()));
                }
              }
            },
          )
        ],
      ),
    );
  }
}

// BOUTON D'AFFICHAGE D'UNE NOTIFICATION D'ALERTE
class AlertInscription extends StatefulWidget {
  final String statut;
  const AlertInscription({Key? key, required this.statut}) : super(key: key);

  @override
  State<AlertInscription> createState() => _AlertInscriptionState();
}

// Formatage du bouton
class _AlertInscriptionState extends State<AlertInscription> {
  // Widget d'affichage de la boite d'alerte en dialogue
  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('INSCRIPTION REUSSIE'),
          content: const Text(
              'Vous pouvez vous connecter une fois que l\'administrateur aura accepté votre demande d\'inscription.'),
          actions: <Widget>[
            // Bouton de retour au planning
            TextButton(
                onPressed: () {
                  // Redirection vers l'accueil pour les visiteurs inscrits
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accueil(
                                statutConnexion: widget.statut,
                                userConnect: null,
                              )));
                },
                child: const Text('Revenir à l\'accueil'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Affichage de l'alerte en cas d'utilisateur non connecté
    return showAlert(context);
  }
}
