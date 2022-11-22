part of 'login_bloc.dart';

abstract class LoginState {}

class LoginUnknown extends LoginState {}

class LoginSuccessState extends LoginState {
  final User user;

  LoginSuccessState(this.user);

  @override
  List<Object> get props => [user];
}

class LoginFailure extends LoginState {
  late bool email;
  late bool password;
}
