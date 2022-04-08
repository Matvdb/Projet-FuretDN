import 'auteur.dart';
import 'dart:developer';

import 'package:mysql1/mysql1.dart';
import 'db_config.dart';

class BdAuteur {
  static Future<Auteur> selectAuteur(
      ConnectionSettings settings, int id) async {
    Auteur auteur = Auteur.vide();
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DbConfig.getSettings());
      try {
        String requete = "SELECT * FORM Auteur WHERE id=" +
            id.toString() +
            " AND EXISTS (SELECT id FORM Auteur WHERE id=" +
            id.toString() +
            " );";
        Results reponse = await conn.query(requete);
        auteur = Auteur(reponse.first['id'], reponse.first['name']);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
    return auteur;
  }

  static Future<List<Auteur>> selectAllAuteurs(
      ConnectionSettings settings) async {
    List<Auteur> listeAuteur = [];
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DbConfig.getSettings());
      try {
        String requete = "SELECT * FROM Auteurs;";
        Results reponse = await conn.query(requete);
        Auteur auteur = Auteur(
          reponse.first['id'],
          reponse.first['name'],
        );
        listeAuteur.add(auteur);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }

    return listeAuteur;
  }

  static Future<void> insertAuteur(
      ConnectionSettings settings, String auteur, String prenom) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DbConfig.getSettings());
      try {
        String requete = "INSERT INTO Auteur (name, auteur) VALUES('" +
            auteur +
            "', '" +
            prenom.toString() +
            "');";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> updateAuteur(
      ConnectionSettings settings, int auteur, String prenom) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DbConfig.getSettings());
      try {
        String requete = "UPDATE Auteurs SET nom = '" +
            prenom +
            ", prenom = '" +
            auteur.toString() +
            "'";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  //delete
  static Future<void> deleteAuteur(ConnectionSettings settings, int id) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DbConfig.getSettings());
      try {
        String requete = "DELETE FROM Auteurs WHERE id='" + id.toString() + "'";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

//delete all
  static Future<void> deleteAllAuteurs(ConnectionSettings settings) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DbConfig.getSettings());
      try {
        String requete = "TRUNCATE TABLE Auteurs;";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  // verifie l'existance d'un etudiant selon son ID
  static Future<bool> exist(ConnectionSettings settings, int id) async {
    bool exist = false;
    if (!(await BdAuteur.selectAuteur(settings, id)).estNull()) {
      exist = true;
    }
    return exist;
  }

  // getEtudiant
  static Future<Auteur> getAuteur(ConnectionSettings settings, int id) async {
    dynamic r = await selectAuteur(settings, id);
    ResultRow rr = r.first;
    return Auteur(rr['auteur'], rr['prenom']);
  }
}
