import 'data.dart';

class Editeur implements Data {
  String _nom = "";
  String _adresse = "";
  int _id = 0;
  String _email = "";

  Editeur(this._nom, this._adresse, this._id, this._email);
  Editeur.sansID(this._nom, this._adresse, this._email);
  Editeur.vide();

  String getNom() {
    return this._nom;
  }

  String getAdresse() {
    return this._adresse;
  }

  int getId() {
    return this._id;
  }

  String getEmail() {
    return this._email;
  }

  bool estNull() {
    bool estnull = false;
    if (_id == 0 && _nom == "" && _adresse == "" && _email == "") {
      estnull = true;
    }
    return estnull;
  }

  @override
  String getEntete() {
    return "| id | name | adresse | email";
  }

  @override
  String getInLine() {
    return "| " + _id.toString() + " | " + _nom + " | " + _adresse + _email;
  }
}
