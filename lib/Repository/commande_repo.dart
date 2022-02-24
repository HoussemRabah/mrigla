import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/../modules/UserModule.dart';

class CommandeRepository {
  FirebaseFirestore database = FirebaseFirestore.instance;

  Future<TheUser?> getCommandeOfUser(TheUser user) async {
    DocumentSnapshot data = await database.doc('commandes/${user.id}').get();
    if ((data.data()) != null) {
      for (List<Map> d in (data.data() as List)) {
        for (Map commande in d) {}
      }
    }
    return null;
  }
}
