import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:mind_track/core/local_database/app_database.dart';
import 'package:mind_track/core/local_database/daos/daily_moods_dao.dart';
import 'package:mind_track/core/network/api_client.dart';
import 'package:mind_track/core/services/device_intent_service.dart';
import 'package:mind_track/core/services/token_storage_service.dart';
import 'package:mind_track/features/daily_mood/data/datasources/daily_mood_local_datasource.dart';
import 'package:mind_track/features/daily_mood/data/repositories/daily_mood_repository_impl.dart';
import 'package:mind_track/features/daily_mood/domain/repositories/daily_mood_repository.dart';
import 'package:mind_track/features/daily_mood/presentation/viewmodel/daily_mood_viewmodel.dart';
import 'package:mind_track/features/analytics/data/datasources/analytics_remote_datasource.dart';
import 'package:mind_track/features/analytics/data/repositories/analytics_repository_impl.dart';
import 'package:mind_track/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:mind_track/features/analytics/presentation/cubit/analytics_cubit.dart';
import 'package:mind_track/features/coach/data/datasources/coach_remote_datasource.dart';
import 'package:mind_track/features/coach/data/repositories/coach_repository_impl.dart';
import 'package:mind_track/features/coach/domain/repositories/coach_repository.dart';
import 'package:mind_track/features/emotion_tracker/data/datasources/emotion_remote_data_source.dart';
import 'package:mind_track/features/emotion_tracker/data/repositories/emotion_repository_impl.dart';
import 'package:mind_track/features/emotion_tracker/domain/repositories/emotion_repository.dart';
import 'package:mind_track/features/emotion_tracker/presentation/cubit/emotion_cubit.dart';
import 'package:mind_track/features/habits/data/datasources/habit_remote_datasource.dart';
import 'package:mind_track/features/habits/data/repositories/habit_repository_impl.dart';
import 'package:mind_track/features/habits/domain/repositories/habit_repository.dart';
import 'package:mind_track/features/habits/presentation/cubit/habit_cubit.dart';
import 'package:mind_track/features/home/data/datasources/home_remote_datasource.dart';
import 'package:mind_track/features/home/data/repositories/home_repository_impl.dart';
import 'package:mind_track/features/home/domain/repositories/home_repository.dart';
import 'package:mind_track/features/home/presentation/cubit/home_cubit.dart';
import 'package:mind_track/features/login/data/datasources/auth_remote_datasource.dart';
import 'package:mind_track/features/login/data/repositories/auth_repository_impl.dart';
import 'package:mind_track/features/login/domain/repositories/auth_repository.dart';
import 'package:mind_track/features/login/presentation/blocs/login_bloc.dart';
import 'package:mind_track/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:mind_track/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:mind_track/features/profile/domain/repositories/profile_repository.dart';
import 'package:mind_track/features/profile/presentation/cubit/profile_cubit.dart';

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
    registerLazySingleton<DailyMoodsDao>(
      () => Injector.get<AppDatabase>().dailyMoodsDao,
    );
    registerLazySingleton<TokenStorageService>(
      () => const TokenStorageService(
        FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
        ),
      ),
    );
    registerLazySingleton<ApiClient>(
      () => ApiClient(Injector.get<TokenStorageService>()),
    );
    registerLazySingleton<DeviceIntentService>(
      () => const DeviceIntentService(),
    );
  }

  static void _registerRepository() {
    registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(Injector.get<ApiClient>()),
    );
    registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(Injector.get<AuthRemoteDataSource>()),
    );
    registerLazySingleton<DailyMoodLocalDatasource>(
      () => DailyMoodLocalDatasourceImpl(Injector.get<DailyMoodsDao>()),
    );
    registerLazySingleton<DailyMoodRepository>(
      () => DailyMoodRepositoryImpl(Injector.get<DailyMoodLocalDatasource>()),
    );
    registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(Injector.get<ApiClient>()),
    );
    registerLazySingleton<AnalyticsRemoteDataSource>(
      () => AnalyticsRemoteDataSourceImpl(Injector.get<ApiClient>()),
    );
    registerLazySingleton<CoachRemoteDataSource>(
      () => CoachRemoteDataSourceImpl(Injector.get<ApiClient>()),
    );
    registerLazySingleton<EmotionRemoteDataSource>(
      () => EmotionRemoteDataSourceImpl(Injector.get<ApiClient>()),
    );
    registerLazySingleton<HabitRemoteDataSource>(
      () => HabitRemoteDataSourceImpl(Injector.get<ApiClient>()),
    );
    registerLazySingleton<AnalyticsRepository>(
      () => AnalyticsRepositoryImpl(Injector.get<AnalyticsRemoteDataSource>()),
    );
    registerLazySingleton<CoachRepository>(
      () => CoachRepositoryImpl(Injector.get<CoachRemoteDataSource>()),
    );
    registerLazySingleton<EmotionRepository>(
      () => EmotionRepositoryImpl(Injector.get<EmotionRemoteDataSource>()),
    );
    registerLazySingleton<HabitRepository>(
      () => HabitRepositoryImpl(Injector.get<HabitRemoteDataSource>()),
    );
    registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(Injector.get<HomeRemoteDataSource>()),
    );
    registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(Injector.get<ApiClient>()),
    );
    registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(Injector.get<ProfileRemoteDataSource>()),
    );
  }

  static void _registerUseCase() {
    // Register use cases here
  }

  static void _registerBlocs() {
    registerLazySingleton<LoginBloc>(
      () => LoginBloc(
        authRepository: Injector.get<AuthRepository>(),
        tokenStorageService: Injector.get<TokenStorageService>(),
      ),
    );
    registerFactory<HomeCubit>(
      () => HomeCubit(homeRepository: Injector.get<HomeRepository>()),
    );
    registerFactory<ProfileCubit>(
      () => ProfileCubit(profileRepository: Injector.get<ProfileRepository>()),
    );
    registerFactory<EmotionCubit>(
      () => EmotionCubit(emotionRepository: Injector.get<EmotionRepository>()),
    );
    registerFactory<AnalyticsCubit>(
      () => AnalyticsCubit(
        analyticsRepository: Injector.get<AnalyticsRepository>(),
      ),
    );
    registerFactory<HabitCubit>(
      () => HabitCubit(habitRepository: Injector.get<HabitRepository>()),
    );
    registerFactory<DailyMoodViewModel>(
      () => DailyMoodViewModel(Injector.get<DailyMoodRepository>()),
    );
  }
}
