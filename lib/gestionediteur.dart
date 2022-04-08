import 'data.dart';

class GestionEditeur implements Data {
  String _nom;
  String _adresse;
  int _id;
  String _email;

  GestionEditeur(this._nom, this._adresse, this._id, this._email);

  getNom() {
    return this._nom;
  }

  getAdresse() {
    return this._adresse;
  }

  getId() {
    return this._id;
  }

  getEmail() {
    return this._email;
  }

  @override
  String getEntete() {
    return "| id | name | adresse | email |";
  }

  @override
  String getInLine() {
    return "| " +
        _id.toString() +
        " | " +
        _nom +
        " | " +
        _adresse.toString() +
        " | " +
        _email.toString() +
        " |";
  }
}
