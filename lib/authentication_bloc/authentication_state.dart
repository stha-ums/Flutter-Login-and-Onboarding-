part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String userID;

  const Authenticated(this.userID);

  @override
  List<Object> get props => [userID];

  @override
  String toString() => 'Authenticated { displayName: $userID }';
}

class Unauthenticated extends AuthenticationState {}

