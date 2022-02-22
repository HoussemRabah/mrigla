part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthEventInit extends AuthEvent {}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;
  AuthEventLogin(this.email, this.password) : super();
}

class AuthEventSignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String prenom;
  final String phone;
  AuthEventSignUp(this.email, this.password, this.name, this.prenom, this.phone)
      : super();
}

class AuthEventLoginViaGmail extends AuthEvent {}

class AuthEventLoginViaFacebook extends AuthEvent {}
