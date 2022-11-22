part of 'signup_bloc.dart';

abstract class SignupEvent {}

class SignupSubmitted extends SignupEvent {
  String firstName;
  String lastName;
  String email;
  String password;

  SignupSubmitted({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  List<Object> get props => [firstName, lastName, email, password];
}

class SignupSucessEvent extends SignupEvent {}
