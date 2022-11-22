import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:denuka/signup_details.dart';
import 'package:equatable/equatable.dart';
import '../../signup_details.dart';
import '../signup_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupSubmitted>(onLoginSignupSubmitted);
  }

  FutureOr<void> onLoginSignupSubmitted(
      SignupSubmitted event, Emitter<SignupState> emit) async {
    //Emitter after async change the state
    final signupDetails = await SignupRepository().signupUser(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        password: event.password);

    emit(SignupSuccessState()); //state changed and move to the login page
  }
}
