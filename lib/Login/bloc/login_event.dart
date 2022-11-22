part of 'login_bloc.dart';

abstract class LoginEvent {}

// class LoginUnknown extends LoginEvent {}

class Submitted extends LoginEvent {
  String email;
  String password;

  Submitted({required this.email, required this.password});

  List<Object> get props => [email, password];
}

class LoginSucessEvent extends LoginEvent {
  String user;
  LoginSucessEvent({required this.user});

  List<Object> get props => [user];
}

class LoginFail extends LoginEvent {}
