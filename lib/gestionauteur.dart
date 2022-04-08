import 'data.dart';

class GestionAuteur implements Data {
  String _auteur;
  String _prenom;

  GestionAuteur(this._auteur, this._prenom);

  getPrenom() {
    return this._prenom;
  }

  getAuteur() {
    return this._auteur;
  }

  @override
  String getEntete() {
    return "| auteur | prenom |";
  }

  @override
  String getInLine() {
    return "| " + _auteur.toString() + " | " + _prenom.toString() + " |";
  }
}
