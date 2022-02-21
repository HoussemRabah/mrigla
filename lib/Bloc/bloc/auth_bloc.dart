import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:mrigla/Repository/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository databaseAuth;
  bool init = true;
  AuthBloc(this.databaseAuth) : super(AuthStateWaiting()) {
    on<AuthEvent>((event, emit) async {
      if (init) {
        databaseAuth.authStateListner().listen((User? user) {
          if (user == null) {
            print('User is currently signed out!');
          } else {
            print('User is signed in!');
          }
        });

        init = false;
      }
      if (event is AuthEventSignUp) {
        emit(AuthStateLoading());
        AuthError? reponse = await databaseAuth.signUp(
            event.email, event.password, event.name, event.prenom, event.phone);
        if (reponse == null) {
          emit(AuthStateLoged());
        } else {
          emit(AuthStateError(reponse));
        }
      }

      if (event is AuthEventLogin) {
        emit(AuthStateLoading());
        AuthError? reponse =
            await databaseAuth.login(event.email, event.password);
        if (reponse == null) {
          emit(AuthStateLoged());
        } else {
          emit(AuthStateError(reponse));
        }
      }
    });
  }
}
