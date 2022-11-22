part of 'create_appointment_bloc.dart';

abstract class CreateAppointmentState {}

class AppInit extends CreateAppointmentState {}

class CreateAppSuccessState extends CreateAppointmentState {}

class CreateAppFailureState extends CreateAppointmentState {}
