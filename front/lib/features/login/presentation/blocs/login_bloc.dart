import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends HydratedBloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>((LoginEmailChanged event, Emitter<LoginState> emit) {
      emit(state.copyWith(email: event.email));
    });
    on<LoginPasswordChanged>((
      LoginPasswordChanged event,
      Emitter<LoginState> emit,
    ) {
      emit(state.copyWith(password: event.password));
    });
    on<LoginSubmitted>((LoginSubmitted event, Emitter<LoginState> emit) async {
      emit(
        state.copyWith(
          signUp: false,
          isSubmitting: true,
          isFailure: false,
          isSuccess: false,
          logIn: false,
        ),
      );
      try {
        await Future<void>.delayed(const Duration(seconds: 1));
        emit(
          state.copyWith(
            isSubmitting: false,
            isSuccess: true,
            isFailure: false,
            logIn: true,
            signUp: false,
          ),
        );
      } catch (_) {
        emit(
          state.copyWith(
            isSubmitting: false,
            isSuccess: false,
            isFailure: true,
            logIn: false,
            signUp: false,
          ),
        );
      }
    });

    on<SignUpSuccess>((SignUpSuccess event, Emitter<LoginState> emit) async {
      emit(
        state.copyWith(
          isSubmitting: false,
          isSuccess: false,
          isFailure: false,
          logIn: false,
          signUp: false,
        ),
      );
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(state.copyWith(signUp: true, logIn: false));
    });

    on<LoginSuccess>((LoginSuccess event, Emitter<LoginState> emit) {
      emit(state.copyWith(logIn: true, signUp: false));
    });

    on<LoginStatusReset>((LoginStatusReset event, Emitter<LoginState> emit) {
      emit(
        state.copyWith(
          isSubmitting: false,
          isSuccess: false,
          isFailure: false,
          logIn: false,
          signUp: false,
        ),
      );
    });
  }

  @override
  LoginState? fromJson(Map<String, dynamic> json) {
    return LoginState(
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      isSubmitting: json['isSubmitting'] as bool? ?? false,
      isSuccess: json['isSuccess'] as bool? ?? false,
      isFailure: json['isFailure'] as bool? ?? false,
      logIn: json['logIn'] as bool? ?? false,
      signUp: json['signUp'] as bool? ?? false,
    );
  }

  @override
  Map<String, dynamic>? toJson(LoginState state) {
    return <String, dynamic>{
      'email': state.email,
      'password': state.password,
      'isSubmitting': state.isSubmitting,
      'isSuccess': state.isSuccess,
      'isFailure': state.isFailure,
      'logIn': state.logIn,
      'signUp': state.signUp,
    };
  }
}
