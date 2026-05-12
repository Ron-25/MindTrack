import 'package:get_it/get_it.dart';
import 'package:mind_track/core/local_database/app_database.dart';
import 'package:mind_track/features/login/presentation/blocs/login_bloc.dart';

class Injector {
  Injector._();

  static final GetIt _locator = GetIt.instance;
  static void init() {
    _other();
    _registerRepository();
    _registerUseCase();
    _registerBlocs();
  }

  static T get<T extends Object>() => _locator<T>();

  static void registerSingleton<T extends Object>(T instance) {
    _locator.registerSingleton<T>(instance);
  }

  static void registerLazySingleton<T extends Object>(T Function() factory) {
    _locator.registerLazySingleton<T>(factory);
  }

  static void registerFactory<T extends Object>(T Function() factory) {
    _locator.registerFactory<T>(factory);
  }

  static void reset() {
    _locator.reset();
  }

  static void _other() {
    registerLazySingleton<AppDatabase>(() => AppDatabase());
  }

  static void _registerRepository() {
    // Register repositories here
  }

  static void _registerUseCase() {
    // Register use cases here
  }

  static void _registerBlocs() {
    registerLazySingleton<LoginBloc>(() => LoginBloc());
  }
}
