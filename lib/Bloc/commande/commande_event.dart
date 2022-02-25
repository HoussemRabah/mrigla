part of 'commande_bloc.dart';

@immutable
abstract class CommandeEvent {}

class CommandeEventInit extends CommandeEvent {
  TheUser user;
  CommandeEventInit(this.user) : super();
}

class CommandeEventRefresh extends CommandeEvent {
  var newDocs;
  String type;
  CommandeEventRefresh({required this.newDocs, required this.type}) : super();
}
