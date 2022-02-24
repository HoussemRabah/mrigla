part of 'commande_bloc.dart';

@immutable
abstract class CommandeEvent {}

class CommandeEventInit extends CommandeEvent {
  TheUser user;
  CommandeEventInit(this.user) : super();
}
