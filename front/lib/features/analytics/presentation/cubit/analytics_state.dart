import 'package:equatable/equatable.dart';
import 'package:mind_track/features/analytics/domain/entities/analytics_snapshot.dart';

class AnalyticsState extends Equatable {
  const AnalyticsState({
    this.isLoading = false,
    this.snapshot,
    this.errorMessage,
  });

  final bool isLoading;
  final AnalyticsSnapshot? snapshot;
  final String? errorMessage;

  AnalyticsState copyWith({
    bool? isLoading,
    AnalyticsSnapshot? snapshot,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AnalyticsState(
      isLoading: isLoading ?? this.isLoading,
      snapshot: snapshot ?? this.snapshot,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[isLoading, snapshot, errorMessage];
}
