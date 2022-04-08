import 'dart:developer';

import 'editeur.dart';
import 'package:mysql1/mysql1.dart';
import 'db_config.dart';

class BdEditeur {
  static Future<Editeur> selectEditeur(
      ConnectionSettings settings, int id) async {
    Editeur edi = Editeur.vide();
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DbConfig.getSettings());
      try {
        String requete = "SELECT * FORM Editeur WHERE id=" +
            id.toString() +
            " AND EXISTS (SELECT id FORM Editeur WHERE id=" +
            id.toString() +
            " );";
        Results reponse = await conn.query(requete);
        edi = Editeur(reponse.first['id'], reponse.first['name'],
            reponse.first['adresse'], reponse.first['email']);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
    return edi;
  }

  static Future<List<Editeur>> selectAllEditeurs(
      ConnectionSettings settings) async {
    List<Editeur> listeEdi = [];
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DbConfig.getSettings());
      try {
        String requete = "SELECT * FROM Editeurs;";
        Results reponse = await conn.query(requete);
        Editeur etu = Editeur(reponse.first['id'], reponse.first['name'],
            reponse.first['adresse'], reponse.first['email']);
        listeEdi.add(etu);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }

    return listeEdi;
  }

  static Future<void> insertEditeur(ConnectionSettings settings, String nom,
      int id, String adresse, String email) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DbConfig.getSettings());
      try {
        String requete =
            "INSERT INTO Editeur (name, id, adresse, email) VALUES('" +
                nom +
                "', '" +
                id.toString() +
                "', " +
                adresse.toString() +
                "', " +
                email.toString() +
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

  static Future<void> updateEditeur(ConnectionSettings settings, String nom,
      int id, String adresse, String email) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DbConfig.getSettings());
      try {
        String requete = "UPDATE Editeur SET nom = '" +
            nom +
            ", ' WHERE id='" +
            id.toString() +
            ", adresse = '" +
            adresse.toString() +
            "', " +
            ", email = '" +
            email.toString() +
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
  static Future<void> deleteEditeur(ConnectionSettings settings, int id) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DbConfig.getSettings());
      try {
        String requete = "DELETE FROM Editeur WHERE id='" + id.toString() + "'";
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
  static Future<void> deleteAllEditeur(ConnectionSettings settings) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DbConfig.getSettings());
      try {
        String requete = "TRUNCATE TABLE Editeur;";
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
    if (!(await BdEditeur.selectEditeur(settings, id)).estNull()) {
      exist = true;
    }
    return exist;
  }

  // getEtudiant
  static Future<Editeur> getEditeur(ConnectionSettings settings, int id) async {
    dynamic r = await selectEditeur(settings, id);
    ResultRow rr = r.first;
    return Editeur(rr['nom'], rr['id'], rr['adresse'], rr['email']);
  }
}
