import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable{
  const AuthenticationEvent();
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent{}

class LoggedIn extends AuthenticationEvent{
  final token;
  const LoggedIn({required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedIn { token : $token}';
}

class Registered extends AuthenticationEvent {
  final token;
  const Registered({required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'Registered { token: $token }';
}

class Register extends AuthenticationEvent{
  const Register();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Need Register { }';
}

class Logout extends AuthenticationEvent{
  const Logout();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Logged Out {}';
}