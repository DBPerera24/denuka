import 'dart:async';
import 'dart:convert';
import 'package:denuka/app.dart';
import 'package:http/http.dart' as http;

class AppRepository {
  Future<App> createAppointment({
    required String userId,
    required String appointmentName,
    required String location,
    required String date,
    required String time,
  }) async {
    try {
      Uri url = Uri.parse('http://localhost:6000/api/appointment/');
      final http.Response response = await http.post(url,
          headers: <String, String>{
            // 'Context-Type': 'application/json;charSet=UTF-8',
            "content-type": "application/json",
            // "Access-Control-Allow-Origin": "*"
          },
          body: jsonEncode({
            "userId": userId,
            "appointmentName": appointmentName,
            "location": location,
            "date": date,
            "time": time,
          }));

      Map<String, dynamic> jsonResponse = json.decode(response.body);

      App finalApp = App(
        userId: jsonResponse['data'] != null ? jsonResponse['userId'] : '',
        appointmentName:
            jsonResponse['data'] != null ? jsonResponse['appointmentName'] : '',
        location: jsonResponse['data'] != null ? jsonResponse['location'] : '',
        date: jsonResponse['data'] != null ? jsonResponse['date'] : '',
        time: jsonResponse['data'] != null ? jsonResponse['time'] : '',
      );

      return finalApp;
    } catch (_) {
      throw Exception();
    }
  }
}
