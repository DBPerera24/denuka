import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:denuka/CreateAppointment/create_appointment_repository.dart';

import '../../app.dart';
part 'create_appointment_event.dart';
part 'create_appointment_state.dart';

class CreateAppointmentBloc
    extends Bloc<CreateAppointmentEvent, CreateAppointmentState> {
  CreateAppointmentBloc() : super(AppInit()) {
    on<AppSubmitted>(onAppSubmitted);
  }

  FutureOr<void> onAppSubmitted(
      AppSubmitted event, Emitter<CreateAppointmentState> emit) async {
    final app = await AppRepository().createAppointment(
      userId: event.userId.toString(),
      appointmentName: event.appointmentName,
      location: event.location,
      date: event.date,
      time: event.time,
    );

    emit(CreateAppSuccessState());
  }
}
