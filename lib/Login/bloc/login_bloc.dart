import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:denuka/Login/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  //abstract class LoginState {}
  LoginBloc() : super(LoginUnknown()) {
    //LoginUnknown - state

    on<Submitted>(onLoginSubmitted); //submitted - event
    // on<LoginFail>(onLoginFailure);
  }

  FutureOr<void> onLoginSubmitted(
      Submitted event, Emitter<LoginState> emit) async {
    //Emitter after async change the state
    final user = await LoginRepository().logInWithEmailAndPassword(
        email: event.email,
        password: event.password); //email, password in submitted event

    emit(LoginSuccessState(
        user)); //keep the user details inside LoginSuccessState
  }

  // FutureOr<void> onLoginFailure(LoginUnknown event, Emitter<LoginState> emit) {
  //   emit(LoginFailure());
  // }
}
