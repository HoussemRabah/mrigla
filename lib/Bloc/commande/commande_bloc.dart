import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '/../modules/UserModule.dart';
import '/../Repository/commande_repo.dart';
import '/../modules/commandeModule.dart';

part 'commande_event.dart';
part 'commande_state.dart';

class CommandeBloc extends Bloc<CommandeEvent, CommandeState> {
  List<Commande> commandes = [];
  List<CommandeService> commandeServices = [];
  bool init = true;
  CommandeRepository commandeDB;
  CommandeBloc({required this.commandeDB}) : super(CommandeStateLoading()) {
    on<CommandeEvent>((event, emit) async {
      // first time
      if (event is CommandeEventInit) {
        emit(CommandeStateLoading());
        commandeServices =
            (await commandeDB.getCommandesServiceOfUser(event.user));

        commandes = await commandeDB.getCommandesOfUser(event.user);
        await commandeDB.commandeListener(event.user, (e) {
          add(CommandeEventRefresh(newDocs: e, type: "commande"));
        });
        emit(CommandeStateLoaded(
            commandes: commandes, commandeServices: commandeServices));
      } else
      // refresh
      if (event is CommandeEventRefresh) {
        emit(CommandeStateLoading());
        if (event.type == "commande")
          commandes = await commandeDB.getCommandes(event.newDocs);
        emit(CommandeStateLoaded(
            commandes: commandes, commandeServices: commandeServices));
      }
    });
  }
}
