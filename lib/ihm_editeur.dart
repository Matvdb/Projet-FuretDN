import 'package:mysql1/mysql1.dart';

import 'bd_editeur.dart';
import 'editeur.dart';
import 'ihm_principale.dart';

class IhmEditeur {
  static Future<void> menu(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print("<------------ Menu - Gestion des Editeurs ----------->");
      print("| 1- Consulter les données de la table");
      print("| 2- Ajouter des données dans la table ");
      print("| 3- Modifier les données de la table");
      print("| 4- Supprimer une/des données dans la table");
      print("| 5 - Supprimer toutes les tables");
      print("0 - Retour au menu précédent");
      choix = IhmPrincipale.choixMenu(5);
      print("_______________________________________________________");

      if (choix == 1) {
        await IhmEditeur.menuSelectEdi(settings);
      } else if (choix == 2) {
        await IhmEditeur.insertEditeur(settings);
      } else if (choix == 3) {
        await IhmEditeur.updateEditeur(settings);
      } else if (choix == 4) {
        await IhmEditeur.deleteEditeur(settings);
      } else if (choix == 5) {
        await IhmEditeur.deleteAllEditeurs(settings);
      }
    }
    print("Retour au menu précédent");
    print("_______________________________________________________");
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> menuSelectEdi(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print("<------------ Menu - Select Editeurs ------------>");
      print("| 1- Afficher selon l'ID");
      print("| 2- Afficher toute la table.");
      print("0- Retour au menu précédent");
      choix = IhmPrincipale.choixMenu(2);
      print("_______________________________________________________");

      if (choix == 1) {
        await IhmEditeur.selectEditeur(settings);
      } else if (choix == 2) {
        await IhmEditeur.selectAllEditeurs(settings);
      }
    }
    print("Retour menu précédent.");
    print("_______________________________________________________");
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> insertEditeur(ConnectionSettings settings) async {
    String nom = IhmPrincipale.saisieString("le nom");
    int id = IhmPrincipale.saisieID();
    String adresse = IhmPrincipale.saisieString("l'adresse");
    String email = IhmPrincipale.saisieString("l'email");
    if (IhmPrincipale.confirmation()) {
      await BdEditeur.insertEditeur(settings, nom, id, adresse, email);
      print("Editeur inséré dans la table.");
      print("_______________________________________________________");
    } else {
      print("Annulation de l'opération.");
      print("_______________________________________________________");
    }
    print("Fin de l'opération.");
    print("_______________________________________________________");
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> updateEditeur(ConnectionSettings settings) async {
    print(
        "------------> Quelle Editeur voulez vous mettre à jour ? <------------");
    int id = IhmPrincipale.saisieID();
    if (await BdEditeur.exist(settings, id)) {
      String nom = IhmPrincipale.saisieString("le nom");
      int id = IhmPrincipale.saisieID();
      String adresse = IhmPrincipale.saisieString("l'adresse");
      String email = IhmPrincipale.saisieString("l'email");
      if (IhmPrincipale.confirmation()) {
        await BdEditeur.updateEditeur(settings, nom, id, adresse, email);
        print("Editeur $id mis à jour.");
        print("_______________________________________________________");
      } else {
        print("Annulation de l'opération.");
        print("_______________________________________________________");
      }
      await Future.delayed(Duration(seconds: 1));
      IhmPrincipale.wait();
    } else {
      print("L'editeur $id n'existe pas.");
      print("Fin de l'opération.");
      print("_______________________________________________________");
      await Future.delayed(Duration(seconds: 1));
      IhmPrincipale.wait();
    }
  }

  static Future<void> selectEditeur(ConnectionSettings settings) async {
    print("------------> Quelle Etudiant voulez vous afficher ? <------------");
    int id = IhmPrincipale.saisieID();
    Editeur edi = await BdEditeur.selectEditeur(settings, id);
    if (!edi.estNull()) {
      IhmPrincipale.afficherDonnee(edi);
      print("Fin de l'opération.");
      print("_______________________________________________________");
    } else {
      print("L'editeur $id n'existe pas");
      print("Fin de l'opération.");
      print("_______________________________________________________");
    }
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> selectAllEditeurs(ConnectionSettings settings) async {
    List<Editeur> listeEdi = await BdEditeur.selectAllEditeurs(settings);
    if (listeEdi.isNotEmpty) {
      IhmPrincipale.afficherDesDonnees(listeEdi);
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

  static Future<void> deleteEditeur(ConnectionSettings settings) async {
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

  static Future<void> deleteAllEditeurs(ConnectionSettings settings) async {
    if (IhmPrincipale.confirmation()) {
      BdEditeur.deleteAllEditeur(settings);
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
