class Commande {
  String id;
  String bon;
  String stat;
  List<Ordre> ordres;
  Commande(
      {required this.id,
      required this.bon,
      required this.stat,
      required this.ordres});

  Commande mapToCommande(Map map) {
    return Commande(id: map['id'], bon: map['bon'], stat: map['stat'], ordres: [
      for (Map ordre in map["ordres"])
        Ordre(
            partId: ordre["partId"],
            unitPrice: ordre["unitPrice"],
            qnt: ordre["qnt"])
    ]);
  }
}

class Ordre {
  String partId;
  int unitPrice;
  int qnt;
  Ordre({required this.partId, required this.unitPrice, required this.qnt});
}
