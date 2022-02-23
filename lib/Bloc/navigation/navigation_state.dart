part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState {
  int index = 0;
}

class NavigationStateService extends NavigationState {
  int index = 0;
}

class NavigationStateCommande extends NavigationState {
  int index = 1;
}

class NavigationStateStore extends NavigationState {
  int index = 2;
}

class NavigationStateCar extends NavigationState {
  int index = 3;
}
