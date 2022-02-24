class Commande {
  String id;
  String bon;
  String stat;
  String livraison;
  List<Ordre> ordres;
  Commande(
      {required this.id,
      required this.livraison,
      required this.bon,
      required this.stat,
      required this.ordres});
}

class CommandeService {
  String id;
  String? carId;
  String? disc;
  String livraison;
  String stat;
  String servicerId;
  String type;
  CommandeService(
      {required this.id,
      required this.livraison,
      required this.stat,
      required this.servicerId,
      required this.type,
      this.carId,
      this.disc});
}

commandeFromMap(Map map) {
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
    livraison: map['livraison'],
  );
}

CommandeService commandeServiceFromMap(Map map) {
  return CommandeService(
    id: map['id'],
    servicerId: map['servicerId'],
    stat: map['stat'],
    type: map['type'],
    carId: map['carId'],
    disc: map['disc'],
    livraison: map['livraison'],
  );
}

class Ordre {
  String partId;
  int unitPrice;
  int qnt;
  Ordre({required this.partId, required this.unitPrice, required this.qnt});
}
