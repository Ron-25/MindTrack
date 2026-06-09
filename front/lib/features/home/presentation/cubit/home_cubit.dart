import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_track/features/home/domain/entities/home_dashboard.dart';
import 'package:mind_track/features/home/domain/repositories/home_repository.dart';
import 'package:mind_track/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required HomeRepository homeRepository})
    : _homeRepository = homeRepository,
      super(const HomeState());

  final HomeRepository _homeRepository;

  Future<void> loadDashboard() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final HomeDashboard dashboard = await _homeRepository.fetchDashboard();
      emit(
        state.copyWith(
          isLoading: false,
          dashboard: dashboard,
          clearError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: error.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}
