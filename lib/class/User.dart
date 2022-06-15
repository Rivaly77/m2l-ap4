// Importation des packages
import 'dart:convert';
import 'package:http/http.dart' as http;

// Class de gestion des utilisateurs
class User {
  // Création des attributs locaux de l'utilisateur
  final int id;
  final String statut;
  final String email;
  final int niveauTarif;
  final int droitReservation;

  // Constructeur
  User(this.id, this.statut, this.email, this.niveauTarif,
      this.droitReservation);

  // Récupération du tarif de l'utilisateur
  int getTarif() {
    // Tarif
    return niveauTarif;
  }

  // Récupération de l'identifiant de l'utilisateur
  int getId() {
    // Tarif
    return id;
  }

  // Fonction de récupération test
  Future<dynamic> getDataUser() async {
    // Définition du chemin d'accès aux données de l'api
    String apiUrl = 'http://10.0.2.2:3000/api/mobile/test';

    // TRAITEMENTS
    try {
      // Requête à l'api
      var res = await http.get(Uri.parse(apiUrl));
      // Traitement de la réponse
      if (res.statusCode == 200) {
        // Récupération des données
        return jsonDecode(res.body);
      } else {
        // Notification d'absence de la données
        return Future.error("Données non récupérée");
      }
    } catch (err) {
      // Notificatyion d'erreur de la requête
      return Future.error(err);
    }
  }
}
