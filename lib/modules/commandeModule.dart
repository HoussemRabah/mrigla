class Commande {
  String id;
  String bon;
  String stat;
  Livraison? livraison;
  List<Ordre> ordres;
  List<StatLog> statLogs;
  String date;
  Commande(
      {required this.id,
      required this.livraison,
      required this.bon,
      required this.stat,
      required this.ordres,
      required this.date,
      required this.statLogs});

  int getTotalPrice() {
    int totalPrice = 0;
    for (Ordre ordre in ordres) {
      totalPrice += ordre.qnt * ordre.unitPrice;
    }
    return totalPrice;
  }

  Map<String, Object?> commandeToMap() {
    return {
      "id": this.id,
      "bon": this.bon,
      "stat": this.stat,
      "statLog": [
        for (StatLog statLog in statLogs) {statLog.toMap()}
      ],
      "ordres": [
        for (Ordre ordre in this.ordres)
          {
            "partId": ordre.partId,
            "unitPrice": ordre.unitPrice,
            "qnt": ordre.qnt
          }
      ],
      "livraisonId": this.livraison?.id,
      "date": this.date,
    };
  }
}

class Servicer {
  String id;
  String nom;
  String prenom;
  String tel;
  String email;
  String image;
  String type;
  Servicer(
      {required this.id,
      required this.nom,
      required this.prenom,
      required this.tel,
      required this.email,
      required this.type,
      required this.image});
}

class StatLog {
  String stat;
  String date;
  String changedBy;
  StatLog({
    required this.stat,
    required this.date,
    required this.changedBy,
  });

  Map<String, Object?> toMap() {
    return {"stat": stat, "date": date, "changedBy": changedBy};
  }
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
  String date;
  List<StatLog> statLogs;
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
      required this.date,
      required this.servicer,
      required this.statLogs});

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "carId": carId,
      "disc": disc,
      "livraisonId": livraison?.id,
      "stat": stat,
      "servicerId": servicerId,
      "type": type,
      "date": date,
      "statLog": [for (StatLog statLog in statLogs) statLog.toMap()]
    };
  }
}

class Livraison {
  String id;
  String position;
  String meta;
  int prix;
  String date;
  String stat;
  String telL;
  String telR;
  Livraison(
      {required this.id,
      required this.position,
      required this.meta,
      required this.date,
      required this.prix,
      required this.stat,
      required this.telL,
      required this.telR});

  Livraison changeStat(String newStat) {
    stat = newStat;
    return this;
  }

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "position": position,
      "meta": meta,
      "prix": prix,
      "date": date,
      "stat": stat,
      "telL": telL,
      "telR": telR,
    };
  }
}

class Ordre {
  String partId;
  int unitPrice;
  int qnt;
  Ordre({required this.partId, required this.unitPrice, required this.qnt});
}
