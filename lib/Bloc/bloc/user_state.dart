part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserStateLoading extends UserState {}

class UserStateLoaded extends UserState {
  TheUser user;
  UserStateLoaded(this.user) : super();
}
