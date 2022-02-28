import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

annulerCommandeDialogue(BuildContext context, Function todo) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.WARNING,
    animType: AnimType.BOTTOMSLIDE,
    title: 'annuler la commande',
    desc: 'Après votre confirmation, votre commande sera annulée',
    btnCancelOnPress: () {},
    btnOkOnPress: () {
      todo();
    },
  )..show();
}

OkCommandeDialogue(BuildContext context, Function todo) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.SUCCES,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Confirmer la réception de la commande',
    desc:
        'Après confirmation, vous obtiendrez des points pour gagner de précieux cadeaux',
    btnCancelOnPress: () {},
    btnOkOnPress: () {
      todo();
    },
  )..show();
}
