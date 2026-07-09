import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_track/features/analytics/domain/entities/analytics_snapshot.dart';
import 'package:mind_track/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:mind_track/features/analytics/presentation/cubit/analytics_state.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  AnalyticsCubit({required AnalyticsRepository analyticsRepository})
    : _analyticsRepository = analyticsRepository,
      super(const AnalyticsState());

  final AnalyticsRepository _analyticsRepository;

  Future<void> loadSnapshot() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final AnalyticsSnapshot snapshot = await _analyticsRepository
          .fetchSnapshot();
      emit(
        state.copyWith(isLoading: false, snapshot: snapshot, clearError: true),
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
