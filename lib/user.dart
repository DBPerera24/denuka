import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.email,
    this.name,
  });

  final String? email;
  final int id;
  final String? name;

  @override
  List<Object?> get props => [email, id, name];
  static User fromJson(
      Map<String, dynamic> json, String message, String? spID) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
    );
  }
}
