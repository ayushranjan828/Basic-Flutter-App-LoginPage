import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onEmailChanged(EmailChanged e, Emitter<LoginState> emit) {
    final email = e.email.trim();
    emit(state.copyWith(email: email, emailValid: _validateEmail(email)));
  }

  void _onPasswordChanged(PasswordChanged e, Emitter<LoginState> emit) {
    final password = e.password;
    emit(state.copyWith(password: password, passwordValid: _validatePassword(password)));
  }

  FutureOr<void> _onLoginSubmitted(LoginSubmitted e, Emitter<LoginState> emit) async {
    final emailOk = _validateEmail(state.email);
    final pwOk = _validatePassword(state.password);

    if (!emailOk || !pwOk) {
      emit(state.copyWith(emailValid: emailOk, passwordValid: pwOk, status: FormStatus.invalid));
      return;
    }

    emit(state.copyWith(status: FormStatus.submitting));
    await Future.delayed(Duration(milliseconds: 900)); // simulate network

    // accept any valid credentials
    emit(state.copyWith(status: FormStatus.success));
  }

  bool _validateEmail(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$');
    return regex.hasMatch(email);
  }

  bool _validatePassword(String password) {
    if (password.length < 8) return false;
    final hasUpper = RegExp(r'[A-Z]').hasMatch(password);
    final hasLower = RegExp(r'[a-z]').hasMatch(password);
    final hasDigit = RegExp(r'\d').hasMatch(password);
    final hasSymbol = RegExp(r'[!@#\\$%^&*(),.?":{}|<>_\-\\/\\[\\];]').hasMatch(password);
    return hasUpper && hasLower && hasDigit && hasSymbol;
  }
}
