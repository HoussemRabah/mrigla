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

  changeCommandeStat(String? uid, Commande commande, String newStat) async {
    if (uid != null) {
      commande.stat = newStat;
      await database
          .doc('/commandes/$uid/commandes/${commande.id}')
          .update(commande.commandeToMap());
    }
  }

  commandeDone(String? uid, Commande commande) async {
    if (uid != null) {
      await database
          .doc('/commandes/$uid/commandes/${commande.id}')
          .delete()
          .then((value) async {
        await database
            .doc('/commandes/$uid/commandesDone/${commande.id}')
            .set(commande.commandeToMap());
      });
    }
  }

  commandeArchive(String? uid, Commande commande) async {
    if (uid != null) {
      await database
          .doc('/commandes/$uid/commandes/${commande.id}')
          .delete()
          .then((value) async {
        await database
            .doc('/commandes/$uid/commandesArchive/${commande.id}')
            .set(commande.commandeToMap());
      });
    }
  }

  changeCommandeServiceStat(
      String? uid, CommandeService commande, String newStat) async {
    if (uid != null) {
      commande.stat = newStat;
      await database
          .doc('/commandes/$uid/commandesService/${commande.id}')
          .update(commande.toMap());
    }
  }

  commandeServiceDone(String? uid, CommandeService commande) async {
    if (uid != null) {
      await database
          .doc('/commandes/$uid/commandesService/${commande.id}')
          .delete()
          .then((value) async {
        await database
            .doc('/commandes/$uid/commandesServiceDone/${commande.id}')
            .set(commande.toMap());
      });
    }
  }

  commandeServiceArchive(String? uid, CommandeService commande) async {
    if (uid != null) {
      await database
          .doc('/commandes/$uid/commandesService/${commande.id}')
          .delete()
          .then((value) async {
        await database
            .doc('/commandes/$uid/commandesServiceArchive/${commande.id}')
            .set(commande.toMap());
      });
    }
  }

  Future<List<CommandeService>> getCommandesServiceOfUser(TheUser user) async {
    List<CommandeService> commandes = [];

    QuerySnapshot<Object?> data;
    data = (await database
        .collection('/commandes/${user.id}/commandesService/')
        .get());

    if (data != null) {
      for (var doc in data.docs) {
        commandes.add(await commandeServiceFromMap(doc.data() as Map));
      }

      return commandes;
    }
    return [];
  }

  Future<Servicer?> getServicer(String uid) async {
    DocumentSnapshot data;
    data = (await database.doc('/servicer/${uid}/').get());

    if (data != null) {
      return servicerFromMap(data.data() as Map);
    }
    return null;
  }

  Future<Livraison?> getLivraison(String uid) async {
    DocumentSnapshot data;
    data = (await database.doc('/livraison/$uid/').get());

    if (data != null) {
      return livraisonFromMap(data.data() as Map);
    }
    return null;
  }

  Future<List<Commande>> getCommandesOfUser(TheUser user) async {
    List<Commande> commandes = [];

    QuerySnapshot<Object?> data;
    data =
        (await database.collection('/commandes/${user.id}/commandes/').get());

    if (data != null) {
      for (var doc in data.docs) {
        commandes.add(await commandeFromMap(doc.data() as Map));
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

  Future<StreamSubscription<QuerySnapshot<Map<String, dynamic>>>>
      commandeServiceListener(TheUser user, Function refrechFunction) async {
    return database
        .collection('/commandes/${user.id}/commandesService/')
        .snapshots()
        .listen((event) async {
      refrechFunction(event.docs);
    });
  }

  Future<List<Commande>> getCommandes(var docs) async {
    List<Commande> commandes = [];
    if (docs != null) {
      for (var doc in docs) {
        commandes.add(await commandeFromMap(doc.data() as Map));
      }

      return commandes;
    }
    return [];
  }

  Future<List<CommandeService>> getCommandesService(var docs) async {
    List<CommandeService> commandes = [];
    if (docs != null) {
      for (var doc in docs) {
        commandes.add(await commandeServiceFromMap(doc.data() as Map));
      }

      return commandes;
    }
    return [];
  }
}

Future<Commande> commandeFromMap(Map map) async {
  Livraison? livraison =
      await CommandeRepository().getLivraison(map["livraisonId"]);
  return Commande(
    id: map['id'],
    bon: map['bon'],
    stat: map['stat'],
    ordres: [
      for (Map ordre in map["ordres"])
        Ordre(
            partId: ordre["partId"],
            unitPrice: ordre["unitPrice"],
            qnt: ordre["qnt"])
    ],
    livraison: livraison,
  );
}

livraisonFromMap(Map map) {
  return Livraison(
    id: map["id"],
    position: map["position"],
    meta: map["meta"],
    date: map["date"],
    prix: map["prix"],
    stat: map["stat"],
  );
}

Future<CommandeService> commandeServiceFromMap(Map map) async {
  Servicer? servicer =
      await CommandeRepository().getServicer(map['servicerId']);

  return CommandeService(
      id: map['id'],
      servicerId: map['servicerId'],
      stat: map['stat'],
      type: (servicer != null) ? servicer.type : "",
      servicer: servicer,
      carId: map['carId'],
      disc: map['disc'],
      livraison: await CommandeRepository().getLivraison(map["livraisonId"]),
      servicerName:
          (servicer != null) ? "${servicer.nom} ${servicer.prenom}" : "");
}

Servicer servicerFromMap(Map map) {
  return Servicer(
      email: map['email'],
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      tel: map['tel'],
      type: map['type']);
}
