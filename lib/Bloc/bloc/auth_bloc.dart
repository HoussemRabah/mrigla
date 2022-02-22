import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '/../UI/pages/LoginUI.dart';
import '/../Repository/auth_repo.dart';
import '/../UI/pages/HomeUI.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository databaseAuth;
  bool init = true;
  AuthBloc(this.databaseAuth) : super(AuthStateLoading()) {
    on<AuthEvent>((event, emit) async {
      if (init) {
        init = false;

        await Future.delayed(Duration(seconds: 1));
        if (!databaseAuth.isSignIn()) {
          emit(AuthStateWaiting());
        }

        databaseAuth.authStateListner().listen((User? user) async {
          if (user == null) {
          } else {
            await Future.delayed(Duration(milliseconds: 1000));
            if (databaseAuth.context != null) {
              Navigator.pushReplacement(
                databaseAuth.context!,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }
          }
        });
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
