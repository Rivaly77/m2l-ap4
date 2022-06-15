// Importation des packages de constrcution de pages
import 'package:flutter/material.dart';
import 'package:m2l/animations/affichage_anime.dart';
import 'package:m2l/class/RequeteApi.dart';
import 'package:m2l/inscription.dart';
import 'package:m2l/accueil.dart';
import 'package:m2l/main.dart';

// Initilisation de l'appel à l'api
RequeteApi api = RequeteApi();

// Création de l'interface de la page d'accueil
class Connexion extends StatelessWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: couleurOrangePale,
        appBar: AppBar(
          title: const Text('Se connecter'),
          backgroundColor: couleurJaune,
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: Column(children: [
            // Logo d'accueil de la M2L
            DelayedAnimation(
                delay: 800,
                child: Container(
                    height: 200,
                    child: Image.asset('assets/images/logo_rond.png'))),
            const SizedBox(
              height: 50,
            ),
            // Formulaire de connexion
            const DelayedAnimation(delay: 1000, child: FormConnexion()),
            const SizedBox(
              height: 30,
            ),
            // Notification de demande d'inscription
            DelayedAnimation(
                delay: 1500,
                child: Text(
                    'Vous n\'avez pas de compte ? Cliquez ici pour vous inscrire.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13))),
            const SizedBox(
              height: 10,
            ),
            // Bouton de redirection vers la page d'inscription
            DelayedAnimation(
                delay: 2000,
                child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: couleurJaune,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.all(10)),
                      child: const Text(
                        'INSCRIPTION',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Inscription()));
                      },
                    ))),
          ]),
        )));
  }
}

// Page de connexion à l'application
class FormConnexion extends StatefulWidget {
  const FormConnexion({Key? key}) : super(key: key);

  @override
  State<FormConnexion> createState() => _FormConnexionState();
}

class _FormConnexionState extends State<FormConnexion> {
  // Clé du formulaire
  final _formKey = GlobalKey<FormState>();

  // Requête d'authentification
  Future<String> connexion(email, mdp) async {
    // Connexion à l'API
    return await api.connexion(email, mdp);
  }

  // Déclaration des variables de récupération des champs de texte
  var saisieEmail = TextEditingController();
  var saisieMdp = TextEditingController();
  var afficheMdp = true;

  // Initialisation des saisies du formulaire
  @override
  void dispose() {
    // Initialisation de chaque champ
    saisieEmail.dispose();
    saisieMdp.dispose();

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
          TextFormField(
            controller: saisieEmail,
            decoration: const InputDecoration(
              labelText: 'E-mail',
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
            height: 20,
          ),
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
            height: 30,
          ),
          // Bouton de connexion
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: couleurJaune,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.only(
                    top: 12, bottom: 12, left: 25, right: 25)),
            child: const Text(
              'CONNEXION',
              style: TextStyle(fontSize: 17),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // Authentification
                var reponse =
                    // await api.connexion(saisieEmail.text, saisieMdp.text);
                    await api.connexion(saisieEmail.text, saisieMdp.text);

                // Vérification de la réponse d'authentification
                if (reponse['statut'] == 'on') {
                  // Redirection vers l'accueil pour les visiteurs inscrits
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accueil(
                                statutConnexion: 'connecte',
                                userConnect: reponse['utilisateur'],
                              )));
                } else {
                  // Redirection vers la page d'inscription pour les non inscrits
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
