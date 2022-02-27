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

class Ordre {
  String partId;
  int unitPrice;
  int qnt;
  Ordre({required this.partId, required this.unitPrice, required this.qnt});
}
