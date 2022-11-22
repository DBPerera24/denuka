import 'package:equatable/equatable.dart';

class SignupDetails extends Equatable {
  const SignupDetails({
    this.email,
    this.firstName,
    this.lastName,
    this.password,
  });

  final String? email;
  final String? firstName;
  final String? lastName;
  final String? password;

  @override
  List<Object?> get props => [email, firstName, lastName, password];

  static SignupDetails fromJson(
      Map<String, dynamic> json, String message, String? spID) {
    return SignupDetails(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
    );
  }
}
