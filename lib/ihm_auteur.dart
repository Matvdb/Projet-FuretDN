import 'package:mysql1/mysql1.dart';

import 'auteur.dart';
import 'bd_auteur.dart';
import 'bd_editeur.dart';
import 'editeur.dart';
import 'ihm_principale.dart';

class IhmAuteur {
  static Future<void> menu(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print("<------------ Menu - Gestion des Auteurs ----------->");
      print("| 1- Consulter les données de la table");
      print("| 2- Ajouter des données dans la table ");
      print("| 3- Modifier les données de la table");
      print("| 4- Supprimer une/des données dans la table");
      print("| 5 - Supprimer toutes les tables");
      print("0 - Retour au menu précédent");
      choix = IhmPrincipale.choixMenu(5);
      print("_______________________________________________________");

      if (choix == 1) {
        await IhmAuteur.menuSelectAuteur(settings);
      } else if (choix == 2) {
        await IhmAuteur.insertAuteur(settings);
      } else if (choix == 3) {
        await IhmAuteur.updateAuteur(settings);
      } else if (choix == 4) {
        await IhmAuteur.deleteAuteur(settings);
      } else if (choix == 5) {
        await IhmAuteur.deleteAllAuteurs(settings);
      }
    }
    print("Retour au menu précédent");
    print("_______________________________________________________");
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> menuSelectAuteur(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print("<------------ Menu - Select Auteur ------------>");
      print("| 1- Afficher toute la table.");
      print("0- Retour au menu précédent");
      choix = IhmPrincipale.choixMenu(2);
      print("_______________________________________________________");

      if (choix == 1) {
        await IhmAuteur.selectAllAuteurs(settings);
      } else if (choix < 1) {
        print("Veuillez saisir la valeur correspondante");
      }
    }
    print("Retour menu précédent.");
    print("_______________________________________________________");
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> insertAuteur(ConnectionSettings settings) async {
    String auteur = IhmPrincipale.saisieString("l'auteur");
    String prenom = IhmPrincipale.saisieString("le prénom");
    if (IhmPrincipale.confirmation()) {
      await BdAuteur.insertAuteur(settings, auteur, prenom);
      print("Auteur inséré dans la table.");
      print("_______________________________________________________");
    } else {
      print("Annulation de l'opération.");
      print("_______________________________________________________");
    }
    print("Fin de l'opération.");
    print("_______________________________________________________");
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> updateAuteur(ConnectionSettings settings) async {
    print(
        "------------> Quelle Auteur voulez vous mettre à jour ? <------------");
    int id = IhmPrincipale.saisieID();
    if (await BdEditeur.exist(settings, id)) {
      String prenom = IhmPrincipale.saisieString("le nom");
      String auteur = IhmPrincipale.saisieString("l'adresse");
      String nom = IhmPrincipale.saisieString("le nom");
      if (IhmPrincipale.confirmation()) {
        await BdEditeur.updateEditeur(settings, prenom, id, nom, auteur);
        print("Auteur $id mis à jour.");
        print("_______________________________________________________");
      } else {
        print("Annulation de l'opération.");
        print("_______________________________________________________");
      }
      await Future.delayed(Duration(seconds: 1));
      IhmPrincipale.wait();
    } else {
      print("L'auteur $id n'existe pas.");
      print("Fin de l'opération.");
      print("_______________________________________________________");
      await Future.delayed(Duration(seconds: 1));
      IhmPrincipale.wait();
    }
  }

  static Future<void> selectAuteur(ConnectionSettings settings) async {
    print("------------> Quelle Auteur voulez vous afficher ? <------------");
    int id = IhmPrincipale.saisieID();
    Editeur aut = await BdEditeur.selectEditeur(settings, id);
    if (!aut.estNull()) {
      IhmPrincipale.afficherDonnee(aut);
      print("Fin de l'opération.");
      print("_______________________________________________________");
    } else {
      print("L'editeur $id n'existe pas");
      print("Fin de l'opération.");
      print("_______________________________________________________");
    }
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> selectAllAuteurs(ConnectionSettings settings) async {
    List<Auteur> listeAuteur = await BdAuteur.selectAllAuteurs(settings);
    if (listeAuteur.isNotEmpty) {
      IhmPrincipale.afficherDesDonnees(listeAuteur);
      print("Fin de l'opération.");
      print("_______________________________________________________");
    } else {
      print("la table est vide");
      print("Fin de l'opération.");
      print("_______________________________________________________");
    }
    await Future.delayed(Duration(seconds: 1));
    IhmPrincipale.wait();
  }

  static Future<void> deleteAuteur(ConnectionSettings settings) async {
    print("------------> Quelle Editeur voulez vous supprimer ? <------------");
    int id = IhmPrincipale.saisieID();
    if (IhmPrincipale.confirmation()) {
      BdEditeur.deleteEditeur(settings, id);
      print("Editeur $id supprimé.");
      print("Fin de l'opération.");
      print("_______________________________________________________");
      await Future.delayed(Duration(seconds: 1));
      IhmPrincipale.wait();
    } else {
      print("Annulation de l'opération.");
      print("_______________________________________________________");
      await Future.delayed(Duration(seconds: 1));
      IhmPrincipale.wait();
    }
  }

  static Future<void> deleteAllAuteurs(ConnectionSettings settings) async {
    if (IhmPrincipale.confirmation()) {
      BdAuteur.deleteAllAuteurs(settings);
      print("Tables supprimées.");
      print("Fin de l'opération.");
      print("_______________________________________________________");
      await Future.delayed(Duration(seconds: 1));
      IhmPrincipale.wait();
    } else {
      print("Annulation de l'opération.");
      print("_______________________________________________________");
      await Future.delayed(Duration(seconds: 1));
      IhmPrincipale.wait();
    }
  }
}
