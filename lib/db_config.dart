import 'package:mysql1/mysql1.dart';
import 'editeur.dart';
import 'dart:developer';

class DbConfig {
  static ConnectionSettings settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'DartUser',
    password: 'dartmdp',
    db: "DartDB",
  );

  static ConnectionSettings getSettings() {
    return settings;
  }

  static Future<void> createTables() async {
    bool checkEditeur = false;

    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DbConfig.getSettings());
      try {
        String requete = "SHOW TABLES;";
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            if (fields.toString() == "Editeur") {
              checkEditeur = true;
            }
          }
        }
        if (!checkEditeur) {
          requete =
              'CREATE TABLE Editeur (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, name varchar(255), adresse varchar(100);';
          await conn.query(requete);
        }
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> dropAllTable() async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DbConfig.getSettings());
      try {
        String requete = "SHOW TABLES;";
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            await conn.query("DROP TABLES IF EXISTS " + fields + ";");
          }
        }
      } catch (e) {
        log(e.toString());
      }

      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  // retourne vrai si les tables sont créer, sinon non
  static Future<bool> checkTables() async {
    bool checkAll = false;
    bool checkEditeur = false;
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DbConfig.getSettings());
      String requete = "SHOW TABLES;";
      try {
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            if (fields.toString() == "Editeurs") {
              checkEditeur = true;
            }
          }
        }
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
    if (checkEditeur) {
      checkAll = true;
    }
    return checkAll;
  }

  static Future<List<String>> selectTables() async {
    List<String> listTable = [];
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DbConfig.getSettings());
      try {
        String requete = 'SHOW TABLES;';
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            listTable.add(fields);
          }
        }
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
    return listTable;
  }

  // permet de supprimer une tabble via son nom passé en paramètre
  static Future<void> dropTable() async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DbConfig.getSettings());
      try {
        String requete = "SHOW TABLES;";
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            await conn.query("DROP TABLES IF EXISTS " + fields + ";");
          }
        }
      } catch (e) {
        log(e.toString());
      }

      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<dynamic> executerRequete(String requete) async {
    Results? reponse;
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DbConfig.getSettings());
      try {
        reponse = await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
    return reponse;
  }
}
