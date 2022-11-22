import 'dart:async';
import 'dart:convert';
import 'package:denuka/user.dart';
import 'package:http/http.dart' as http;

enum LoginStatus { unknown, authenticated, unauthenticated }

class LoginRepository {
  Future<User> logInWithEmailAndPassword({
    //assign to User
    required String email,
    required String password,
  }) async {
    // final msg = jsonEncode("{'email': $email, password: $password}");
    try {
      Uri url = Uri.parse('http://localhost:6000/api/login');
      final http.Response response = await http.post(url,
          headers: <String, String>{
            // 'Context-Type': 'application/json;charSet=UTF-8',
            "content-type": "application/json",
            // "Access-Control-Allow-Origin": "*"
          },
          body: jsonEncode({
            "email": email,
            "password": password,
          }));

      Map<String, dynamic> jsonResponse = json.decode(response.body);

      User finalUser = User(
        id: jsonResponse['data'] != null ? jsonResponse['data']['id'] : '',
        email:
            jsonResponse['data'] != null ? jsonResponse['data']['email'] : '',
        name: jsonResponse['data'] != null
            ? jsonResponse['data']['firstName']
            : '',
      );

      return finalUser;
    } catch (_) {
      throw Exception();
    }
  }
}
