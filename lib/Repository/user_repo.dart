import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/../modules/UserModule.dart';

class UserRepository {
  FirebaseFirestore database = FirebaseFirestore.instance;

  Future<TheUser?> getUser(User user) async {
    DocumentSnapshot data = await database.doc('users/${user.uid}').get();
    if ((data.data()) != null) {
      return TheUser(
          nom: (data.data() as Map)['nom'],
          prenom: (data.data() as Map)['prenom'],
          phone: (data.data() as Map)['phone'],
          email: user.email ?? "");
    }
    return null;
  }

  Future<int> getPoints(User user) async {
    DocumentSnapshot data = await database.doc('points/${user.uid}').get();
    if ((data.data()) != null) {
      return (data.data() as Map)["score"];
    }
    return 0;
  }
}
