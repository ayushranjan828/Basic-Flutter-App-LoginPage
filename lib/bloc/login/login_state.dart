enum FormStatus { initial, invalid, submitting, success, failure }

class LoginState {
  final String email;
  final String password;
  final bool emailValid;
  final bool passwordValid;
  final FormStatus status;
  final String? message;

  LoginState({
    required this.email,
    required this.password,
    required this.emailValid,
    required this.passwordValid,
    required this.status,
    this.message,
  });

  factory LoginState.initial() => LoginState(
    email: '',
    password: '',
    emailValid: true,
    passwordValid: true,
    status: FormStatus.initial,
    message: null,
  );

  LoginState copyWith({
    String? email,
    String? password,
    bool? emailValid,
    bool? passwordValid,
    FormStatus? status,
    String? message,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailValid: emailValid ?? this.emailValid,
      passwordValid: passwordValid ?? this.passwordValid,
      status: status ?? this.status,
      message: message,
    );
  }
}
