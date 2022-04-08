import 'data.dart';

class Auteur implements Data {
  String _auteur = "";
  String _prenom = "";

  Auteur(this._auteur, this._prenom);
  Auteur.sansID(this._prenom, this._auteur);
  Auteur.vide();

  String getAuteur() {
    return this._auteur;
  }

  String getPrenom() {
    return this._prenom;
  }

  bool estNull() {
    bool estnull = false;
    if (_auteur == "" && _prenom == "") {
      estnull = true;
    }
    return estnull;
  }

  @override
  String getEntete() {
    throw UnimplementedError();
  }

  @override
  String getInLine() {
    throw UnimplementedError();
  }
}
