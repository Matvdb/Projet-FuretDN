import 'package:mysql1/mysql1.dart';

import 'ihm_principale.dart';

void main(List<String> arguments) async {
  IhmPrincipale.titre();
  ConnectionSettings settings = IhmPrincipale.setting();
  await IhmPrincipale.menu(settings);
  IhmPrincipale.quitter();
}
