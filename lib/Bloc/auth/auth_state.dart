part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthStateWaiting extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateLoged extends AuthState {}

class AuthStateSigningUp extends AuthState {}

class AuthStateLogin extends AuthState {}

class AuthStateError extends AuthState {
  final AuthError error;
  AuthStateError(this.error) : super();
}

class AuthStateLoginViaGmail extends AuthState {}

class AuthStateLoginViaFacebook extends AuthState {}
