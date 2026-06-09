import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mind_track/core/services/token_storage_service.dart';
import 'package:mind_track/features/login/domain/entities/auth_token.dart';
import 'package:mind_track/features/login/domain/exceptions/auth_exception.dart';
import 'package:mind_track/features/login/domain/repositories/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends HydratedBloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthRepository authRepository,
    required TokenStorageService tokenStorageService,
  })  : _authRepository = authRepository,
        _tokenStorage = tokenStorageService,
        super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<SignUpSuccess>(_onSignUpSuccess);
    on<LoginSuccess>(_onLoginSuccess);
    on<LoginStatusReset>(_onStatusReset);
  }

  final AuthRepository _authRepository;
  final TokenStorageService _tokenStorage;

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      isSubmitting: true,
      isFailure: false,
      isSuccess: false,
      logIn: false,
      signUp: false,
      clearError: true,
    ));
    try {
      final AuthToken token = await _authRepository.login(
        email: state.email,
        password: state.password,
      );
      await _tokenStorage.saveTokens(
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
      );
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: true,
        logIn: true,
        signUp: false,
        clearError: true,
      ));
    } on AuthException catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        isFailure: true,
        logIn: false,
        signUp: false,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(
        isSubmitting: false,
        isFailure: true,
        logIn: false,
        signUp: false,
        errorMessage: 'Error de conexión. Verifica tu red.',
      ));
    }
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      isSubmitting: true,
      isFailure: false,
      isSuccess: false,
      logIn: false,
      signUp: false,
      clearError: true,
    ));
    try {
      final AuthToken token = await _authRepository.register(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      await _tokenStorage.saveTokens(
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
      );
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: true,
        signUp: true,
        logIn: false,
        clearError: true,
      ));
    } on AuthException catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        isFailure: true,
        logIn: false,
        signUp: false,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(
        isSubmitting: false,
        isFailure: true,
        logIn: false,
        signUp: false,
        errorMessage: 'Error de conexión. Verifica tu red.',
      ));
    }
  }

  Future<void> _onSignUpSuccess(
    SignUpSuccess event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      logIn: false,
      signUp: false,
    ));
    await Future<void>.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(signUp: true, logIn: false));
  }

  void _onLoginSuccess(LoginSuccess event, Emitter<LoginState> emit) {
    emit(state.copyWith(logIn: true, signUp: false));
  }

  void _onStatusReset(LoginStatusReset event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      logIn: false,
      signUp: false,
      clearError: true,
    ));
  }

  @override
  LoginState? fromJson(Map<String, dynamic> json) {
    return LoginState(email: json['email'] as String? ?? '');
  }

  @override
  Map<String, dynamic>? toJson(LoginState state) {
    return <String, dynamic>{'email': state.email};
  }
}
