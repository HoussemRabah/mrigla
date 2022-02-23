part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent {}

class NavigationEventService extends NavigationEvent {}

class NavigationEventCommande extends NavigationEvent {}

class NavigationEventStore extends NavigationEvent {}

class NavigationEventCar extends NavigationEvent {}
