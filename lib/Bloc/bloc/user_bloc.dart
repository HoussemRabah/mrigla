import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:mrigla/Repository/user_repo.dart';
import 'package:mrigla/modules/UserModule.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  bool init = true;
  User? userAuth;
  TheUser? user;
  UserRepository userDB;
  UserBloc({required this.userDB, required this.userAuth})
      : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (init && userAuth != null) {
        init = false;
        emit(UserStateLoading());
        user = await userDB.getUser(userAuth!);
        if (user == null) {
        } else {
          emit(UserStateLoaded(user!));
        }
      }
    });
  }
}
