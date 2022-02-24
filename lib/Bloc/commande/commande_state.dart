part of 'commande_bloc.dart';

@immutable
abstract class CommandeState {}

class CommandeStateInitial extends CommandeState {}

class CommandeStateLoading extends CommandeState {}

class CommandeStateLoaded extends CommandeState {}
