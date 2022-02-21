part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthEventLogin extends AuthEvent {}

class AuthEventSignUp extends AuthEvent {
  final String email;
  final String password;
  AuthEventSignUp(this.email, this.password) : super();
}

class AuthEventLoginViaGmail extends AuthEvent {}

class AuthEventLoginViaFacebook extends AuthEvent {}
