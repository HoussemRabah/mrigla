import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'commande_event.dart';
part 'commande_state.dart';

class CommandeBloc extends Bloc<CommandeEvent, CommandeState> {
  CommandeBloc() : super(CommandeStateInitial()) {
    on<CommandeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
