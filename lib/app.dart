import 'dart:ffi';
import 'package:equatable/equatable.dart';

class App extends Equatable {
  const App({
    required this.userId,
    this.appointmentName,
    this.location,
    this.date,
    this.time,
  });

  final Int? userId;
  final String? appointmentName;
  final String? location;
  final String? date;
  final String? time;

  @override
  List<Object?> get props => [userId, appointmentName, location, date, time];
  static App fromJson(Map<String, dynamic> json, String message, String? spID) {
    return App(
      userId: json['userId'],
      appointmentName: json['appointmentName'],
      location: json['location'],
      date: json['date'],
      time: json['time'],
    );
  }
}
