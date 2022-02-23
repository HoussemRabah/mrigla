import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationStateService()) {
    on<NavigationEvent>((event, emit) {
      if (event is NavigationEventService) emit(NavigationStateService());
      if (event is NavigationEventCommande) emit(NavigationStateCommande());
      if (event is NavigationEventStore) emit(NavigationStateStore());
      if (event is NavigationEventCar) emit(NavigationStateCar());
    });
  }
}
