import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '/../modules/UserModule.dart';
import '/../Repository/commande_repo.dart';
import '/../modules/commandeModule.dart';

part 'commande_event.dart';
part 'commande_state.dart';

class CommandeBloc extends Bloc<CommandeEvent, CommandeState> {
  List<Commande> commandes = [];
  bool init = true;
  CommandeRepository commandeDB;
  CommandeBloc({required this.commandeDB}) : super(CommandeStateInitial()) {
    on<CommandeEvent>((event, emit) async {
      if (event is CommandeEventInit) {
        emit(CommandeStateLoading());
        commandes = (await commandeDB.getCommandesOfUser(event.user));
      }
    });
  }
}
