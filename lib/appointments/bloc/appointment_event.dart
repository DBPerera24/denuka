part of 'appointment_bloc.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class AppointmentListEvent extends AppointmentEvent {
  String userId;
  AppointmentListEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}
