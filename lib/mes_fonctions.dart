import 'dart:io';

class MesFonctions {
  int SaisirInt() {
    bool valide = false;
    int i = 0;
    while (!valide) {
      print("Veuillez saisir un entier");
      try {
        i = int.parse(stdin.readLineSync().toString());
        valide = true;
      } catch (e) {
        print("Veuillez recommencer");
      }
    }
    return i;
  }

  String SaisirString() {
    bool valide = false;
    String i = "";
    while (!valide) {
      print("Veuillez saisir une chaine de caractères");
      try {
        i = stdin.readLineSync().toString();
        valide = true;
      } catch (e) {
        print("Veuillez recommencer");
      }
    }
    return i;
  }
}
