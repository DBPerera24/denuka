import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../signup_details.dart';

class SignupRepository {
  Future<SignupDetails> signupUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      Uri url = Uri.parse('http://localhost:6000/api/user');
      final http.Response response = await http.post(url,
          headers: <String, String>{
            // 'Context-Type': 'application/json;charSet=UTF-8',
            "content-type": "application/json",
            // "Access-Control-Allow-Origin": "*"
          },
          body: jsonEncode({
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": password,
          }));

      Map<String, dynamic> jsonResponse = json.decode(response.body);

      SignupDetails Signup = SignupDetails(
        firstName: jsonResponse['data'] != null
            ? jsonResponse['data']['firstName']
            : '',
        lastName: jsonResponse['data'] != null
            ? jsonResponse['data']['lastName']
            : '',
        email:
            jsonResponse['data'] != null ? jsonResponse['data']['email'] : '',
        password: jsonResponse['data'] != null
            ? jsonResponse['data']['password']
            : '',
      );

      return Signup;
    } catch (_) {
      throw Exception();
    }
  }
}
