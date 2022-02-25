import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mrigla/Bloc/commande/commande_bloc.dart';
import 'package:mrigla/UI/pages/HomeUI.dart';
import 'package:mrigla/modules/commandeModule.dart';
import '/../modules/UserModule.dart';

class CommandeRepository {
  FirebaseFirestore database = FirebaseFirestore.instance;
  bool init = true;

  Future<List<CommandeService>> getCommandesServiceOfUser(TheUser user) async {
    List<CommandeService> commandes = [];

    QuerySnapshot<Object?> data;
    data = (await database
        .collection('/commandes/${user.id}/commandesService/')
        .get());

    if (data != null) {
      for (var doc in data.docs) {
        commandes.add(commandeServiceFromMap(doc.data() as Map));
      }

      return commandes;
    }
    return [];
  }

  Future<List<Commande>> getCommandesOfUser(TheUser user) async {
    List<Commande> commandes = [];

    QuerySnapshot<Object?> data;
    data =
        (await database.collection('/commandes/${user.id}/commandes/').get());

    if (data != null) {
      for (var doc in data.docs) {
        commandes.add(commandeFromMap(doc.data() as Map));
      }

      return commandes;
    }

    return [];
  }

  Future<StreamSubscription<QuerySnapshot<Map<String, dynamic>>>>
      commandeListener(TheUser user, Function refrechFunction) async {
    return database
        .collection('/commandes/${user.id}/commandes/')
        .snapshots()
        .listen((event) async {
      refrechFunction(event.docs);
    });
  }

  Future<List<Commande>> getCommandes(var docs) async {
    List<Commande> commandes = [];
    if (docs != null) {
      for (var doc in docs) {
        commandes.add(commandeFromMap(doc.data() as Map));
      }

      return commandes;
    }
    return [];
  }
}
