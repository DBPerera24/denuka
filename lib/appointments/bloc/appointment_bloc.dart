import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:denuka/CreateAppointment/models/appointment_model.dart';
import 'package:denuka/user.dart';
import 'package:equatable/equatable.dart';

import '../appointment_repository.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc() : super(AppointmentInitial()) {
    on<AppointmentListEvent>(onAppSubmitted);
  }

  FutureOr<void> onAppSubmitted(
      AppointmentListEvent event, Emitter<AppointmentState> emit) async {
    final subAppointment =
        await AppointmentRepository().getAppointment(userId: event.userId);

    emit(AppointmentList(
        subAppointment)); //pass value of user to LoginSuccessState
  }
}
