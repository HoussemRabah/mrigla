part of 'commande_bloc.dart';

@immutable
abstract class CommandeState {}

class CommandeStateInitial extends CommandeState {}

class CommandeStateLoading extends CommandeState {}

class CommandeStateLoaded extends CommandeState {
  final List<Commande>? commandes;
  final List<CommandeService>? commandeServices;
  int calcTotalPriceOfCommandes() {
    int total = 0;
    for (Commande commande in commandes ?? []) {
      total += commande.getTotalPrice();
    }
    return total;
  }

  CommandeStateLoaded({this.commandes, this.commandeServices}) : super();
}
