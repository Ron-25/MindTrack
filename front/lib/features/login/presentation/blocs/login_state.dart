import 'package:equatable/equatable.dart';

class LoginState extends Equatable {

	const LoginState({
		this.email = '',
		this.password = '',
		this.isSubmitting = false,
		this.isSuccess = false,
		this.isFailure = false,
    this.logIn = false,
    this.signUp = false,
	});
	final String email;
	final String password;
	final bool isSubmitting;
	final bool isSuccess;
	final bool isFailure;
  final bool logIn;
  final bool signUp;

	LoginState copyWith({
		String? email,
		String? password,
		bool? isSubmitting,
		bool? isSuccess,
		bool? isFailure,
    bool? logIn,
    bool? signUp,
	}) {
		return LoginState(
			email: email ?? this.email,
			password: password ?? this.password,
			isSubmitting: isSubmitting ?? this.isSubmitting,
			isSuccess: isSuccess ?? this.isSuccess,
			isFailure: isFailure ?? this.isFailure,
      logIn: logIn ?? this.logIn,
      signUp: signUp ?? this.signUp,
		);
	}

	@override
	List<Object?> get props => <Object?>[email, password, isSubmitting, isSuccess, isFailure, logIn, signUp];
}
