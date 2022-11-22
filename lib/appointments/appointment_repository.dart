import 'dart:convert';
import 'package:http/http.dart' as http;
import '../CreateAppointment/models/appointment_model.dart';

class AppointmentRepository {
  Future<List<ApponintmentModel>> getAppointment(
      {required String userId}) async {
    List<ApponintmentModel> subAppointment = [];
    try {
      Uri url =
          Uri.parse('http://localhost:6000/api/appointmentDetail/$userId');
      final http.Response response = await http.get(
        url,
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8',
          "Access-Control-Allow-Origin": "*"
        },
      );
      var jsonResponse = jsonDecode(response.body);

      final appointment = jsonResponse['data'] as List;
      subAppointment = appointment
          .map<ApponintmentModel>((json) => ApponintmentModel(
              userId: json['userId'],
              date: json['date'],
              appointmentName: json['appointmentName'],
              time: json['time'],
              location: json['location']))
          .toList();
      return subAppointment;
    } catch (_) {
      throw Exception();
    }
  }
}
