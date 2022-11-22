import 'package:equatable/equatable.dart';

class ApponintmentModel extends Equatable {
  const ApponintmentModel(
      {required this.userId,
      required this.date,
      required this.appointmentName,
      required this.time,
      required this.location});

  final String? userId;
  final String? date;
  final String? appointmentName;
  final String? time;
  final String? location;

  static ApponintmentModel fromJson(Map<String, dynamic> json) {
    return ApponintmentModel(
        userId: json['data']['userId'],
        date: json['data']['date'],
        appointmentName: json['data']['appointmentName'],
        time: json['data']['time'],
        location: json['data']['location']);
  }

  @override
  List<Object?> get props => [userId, date, appointmentName, time, location];
}
