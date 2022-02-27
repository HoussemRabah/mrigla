import 'package:mrigla/Repository/commande_repo.dart';

class Commande {
  String id;
  String bon;
  String stat;
  Livraison? livraison;
  List<Ordre> ordres;
  Commande(
      {required this.id,
      required this.livraison,
      required this.bon,
      required this.stat,
      required this.ordres});

  int getTotalPrice() {
    int totalPrice = 0;
    for (Ordre ordre in ordres) {
      totalPrice += ordre.qnt * ordre.unitPrice;
    }
    return totalPrice;
  }
}

class Servicer {
  String id;
  String nom;
  String prenom;
  String tel;
  String email;
  String type;
  Servicer(
      {required this.id,
      required this.nom,
      required this.prenom,
      required this.tel,
      required this.email,
      required this.type});
}

class CommandeService {
  String id;
  String? carId;
  String? disc;
  Livraison? livraison;
  String stat;
  String servicerId;
  String type;
  String servicerName;
  Servicer? servicer;
  CommandeService(
      {required this.id,
      required this.livraison,
      required this.stat,
      required this.servicerId,
      required this.type,
      this.carId,
      this.disc,
      required this.servicerName,
      required this.servicer});
}

class Livraison {
  String id;
  String position;
  String meta;
  int prix;
  String date;
  String stat;
  Livraison({
    required this.id,
    required this.position,
    required this.meta,
    required this.date,
    required this.prix,
    required this.stat,
  });
}

commandeFromMap(Map map) async {
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
    livraison: await CommandeRepository().getLivraison(map["livraisonUrl"]),
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
      livraison: await CommandeRepository().getLivraison(map["livraisonUrl"]),
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

class Ordre {
  String partId;
  int unitPrice;
  int qnt;
  Ordre({required this.partId, required this.unitPrice, required this.qnt});
}
