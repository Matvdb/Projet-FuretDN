import 'dart:io';

import 'package:mysql1/mysql1.dart';

import 'data.dart';
import 'db_config.dart';
import 'ihm_auteur.dart';
import 'ihm_editeur.dart';

class IhmPrincipale {
  static void titre() {
    print("<------------Bienvenu dans : ------------>");
    print("  La base de donnée du Furet du Nord !");
    print("           Projet Dart - Sql");
    print("-----------------------------------------");
  }

  static void quitter() {
    print("A bientot !");
  }

  static void afficherDonnee(Data data) {
    print(data.getEntete());
    print(data.getInLine());
  }

  static void afficherDesDonnees(List<Data> datalist) {
    print(datalist.first.getEntete());
    for (var Editeur in datalist) {
      print(Editeur.getInLine());
    }
  }

  // Méthodes de saisie*
  static int choixMenu(int nbChoix) {
    bool saisieValide = false;
    int i = -1;
    while (!saisieValide) {
      print(">> Veuillez saisir une action (0-$nbChoix)");
      try {
        i = int.parse(stdin.readLineSync().toString());
        if (i >= 0 && i <= nbChoix) {
          saisieValide = true;
        } else {
          print(
              "La saisie est invalide, veuillez saisir une action existante.");
        }
      } catch (e) {
        print("Erreur dans la saisie, veuillez recommencer");
      }
    }
    return i;
  }

  // retourne un bool pour demande de confirmation
  static bool confirmation() {
    bool saisieValide = false;
    bool confirme = false;
    while (!saisieValide) {
      print("Confirmez-vous cette action ? (o:n)");
      String reponse = stdin.readLineSync().toString();
      if (reponse.toLowerCase() == "o") {
        saisieValide = true;
        confirme = true;
      } else if (reponse.toLowerCase() == "n") {
        saisieValide = true;
        print("Annulation");
      } else {
        print("Erreur");
      }
    }
    return confirme;
  }

  static String saisieString(String objectifSaisie) {
    bool saisieValide = false;
    String s = "";
    while (!saisieValide) {
      print("<------------ Veuillez saisir $objectifSaisie : ------------>");
      try {
        s = stdin.readLineSync().toString();
        saisieValide = true;
      } catch (e) {
        print("Erreur");
      }
    }
    return s;
  }

  static String saisieMDP() {
    bool saisieValide = false;
    String s = "";
    while (!saisieValide) {
      print("> Veuillez saisir le mot de passe :");
      try {
        stdin.echoMode = false;
        s = stdin.readLineSync().toString();
        saisieValide = true;
        stdin.echoMode = true;
        print(
            "-------------------------------------------------------------------------");
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return s;
  }

  static int saisieInt() {
    bool saisieValide = false;
    int i = -1;
    while (!saisieValide) {
      print("<------------ Veuillez saisir un entier : ------------>");
      try {
        i = int.parse(stdin.readLineSync().toString());
        saisieValide = true;
      } catch (e) {
        print("Erreur");
      }
    }
    return i;
  }

  static int saisieID() {
    bool saisieValide = false;
    int i = -1;
    while (!saisieValide) {
      print("<------------ Veuillez saisir l'id correspondant: ------------>");
      try {
        i = int.parse(stdin.readLineSync().toString());
        if (i > 0) {
          saisieValide = true;
        } else {
          print("La valeur saisie est inférieur ou égale à zéro");
        }
      } catch (e) {
        print("Erreur");
      }
    }
    return i;
  }

  static void wait() {
    print("Appuyez sur entrer pour continuer ...");
    stdin.readLineSync();
  }

  static ConnectionSettings setting() {
    String bdd = IhmPrincipale.saisieString("le nom de la BDD");
    String user = IhmPrincipale.saisieString("l'utilisateur");
    String mdp = IhmPrincipale.saisieMDP();

    return ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'DartUser',
      password: 'dartmdp',
      db: "DartDB",
    );
  }

  static Future<int> menu(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print("<------------ Menu Principal ------------>");
      print("| 1- Gestion de la BDD");
      print("| 2- Gestion de la table Editeur");
      print("| 3- Gestion de la table Auteur");
      print("0- -----> Quitter <-----");
      choix = IhmPrincipale.choixMenu(3);
      print("<------------------------------------------->");
      if (choix == 1) {
        await IhmPrincipale.menuBDD(settings);
      } else if (choix == 2) {
        await IhmEditeur.menu(settings);
      } else if (choix == 3) {
        await IhmAuteur.menu(settings);
      }
    }
    return 0;
  }

  static Future<void> menuBDD(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print("<------------ Menu - Gestion BDD ------------>");
      print("| 1- Création des tables de la BDD");
      print("| 2- Verification des tables de la BDD");
      print("| 3- Afficher les tables de la BDD");
      print("| 4- Supprimer une table dans la BDD");
      print("| 5- Supprimer toutes les tables dans la BDD");
      print("0- -----> Quitter vers le menu précédent <-----");
      choix = IhmPrincipale.choixMenu(5);
      print("_______________________________________________________");

      if (choix == 1) {
        await IhmPrincipale.createTable(settings);
      } else if (choix == 2) {
        await IhmPrincipale.checkTable(settings);
      } else if (choix == 3) {
        await IhmPrincipale.selectTable(settings);
      } else if (choix == 4) {
        await IhmPrincipale.deleteTable(settings);
      } else if (choix == 5) {
        await IhmPrincipale.deleteAllTables(settings);
      }
    }
    print("Retour menu précédent.");
    print("_______________________________________________________");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour creer les tables
  static Future<void> createTable(ConnectionSettings settings) async {
    print("Création des tables manquantes dans la BDD ... Veuillez patienter");
    await DbConfig.createTables();
    print("Fin de l'opération.");
    print("_______________________________________________________");
    await Future.delayed(Duration(seconds: 1));
    IhmPrincipale.wait();
  }

// action pour vérifier les tables
  static Future<void> checkTable(ConnectionSettings settings) async {
    print("Verification des tables dans la BDD ...");
    if (await DbConfig.checkTables()) {
      print("Toutes les tables sont présentes dans la BDD.");
    } else {
      print("Il manque des tables dans la BDD.");
    }
    print("Fin de l'opération.");
    print("_______________________________________________________");
    await Future.delayed(Duration(seconds: 1));
    IhmPrincipale.wait();
  }

// action pour afficher les tables
  static Future<void> selectTable(ConnectionSettings settings) async {
    List<String> listTable = await DbConfig.selectTables();
    print("------------> Liste des tables : <------------");
    for (var table in listTable) {
      print("- $table");
    }
    print("Fin de l'opération.");
    print("_______________________________________________________");
    await Future.delayed(Duration(seconds: 1));
    IhmPrincipale.wait();
  }

// action pour supprimer une table
  static Future<void> deleteTable(ConnectionSettings settings) async {
    print("------------> Quelle table voulez vous supprimer ? <------------");
    String table = IhmPrincipale.saisieString("le nom de la table");
    if (IhmPrincipale.confirmation()) {
      DbConfig.dropTable();
      print("Table supprimée.");
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

// action pour supprimer les tables
  static Future<void> deleteAllTables(ConnectionSettings settings) async {
    if (IhmPrincipale.confirmation()) {
      DbConfig.dropTable();
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

  // Menu Méthodes et Actions

}
