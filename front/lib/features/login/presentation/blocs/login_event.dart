import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);
  final String email;

  @override
  List<Object?> get props => <Object?>[email];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);
  final String password;

  @override
  List<Object?> get props => <Object?>[password];
}

class LoginSuccess extends LoginEvent {
  const LoginSuccess();
}

class SignUpSuccess extends LoginEvent {
  const SignUpSuccess();
}

class SignUpSubmitted extends LoginEvent {
  const SignUpSubmitted({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;

  @override
  List<Object?> get props => <Object?>[name, email, password];
}

class LoginSubmitted extends LoginEvent {}

class LoginStatusReset extends LoginEvent {
  const LoginStatusReset();
}
