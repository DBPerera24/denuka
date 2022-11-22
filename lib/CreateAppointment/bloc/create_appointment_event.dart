part of 'create_appointment_bloc.dart';

abstract class CreateAppointmentEvent {}

class AppSubmitted extends CreateAppointmentEvent {
  String userId;
  String appointmentName;
  String location;
  String date;
  String time;

  AppSubmitted({
    required this.userId,
    required this.appointmentName,
    required this.location,
    required this.date,
    required this.time,
  });

  @override
  List<Object> get props => [userId, appointmentName, location, date, time];
}

class CreateAppSuccessEvent extends CreateAppointmentEvent {}
