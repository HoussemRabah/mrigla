part of 'commande_bloc.dart';

@immutable
abstract class CommandeEvent {}

class CommandeEventInit extends CommandeEvent {
  final TheUser user;
  CommandeEventInit(this.user) : super();
}

class CommandeEventRefresh extends CommandeEvent {
  final newDocs;
  final String type;
  CommandeEventRefresh({required this.newDocs, required this.type}) : super();
}

class CommandeEventChangeStat extends CommandeEvent {
  final TheUser? user;
  final Commande commande;
  final String newStat;
  CommandeEventChangeStat(
      {required this.user, required this.commande, required this.newStat})
      : super();
}

class CommandeEventCommandeDone extends CommandeEvent {
  final TheUser? user;
  final Commande commande;
  CommandeEventCommandeDone({required this.user, required this.commande})
      : super();
}

class CommandeEventCommandeArchive extends CommandeEvent {
  final TheUser? user;
  final Commande commande;
  CommandeEventCommandeArchive({required this.user, required this.commande})
      : super();
}
