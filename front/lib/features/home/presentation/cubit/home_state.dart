import 'package:equatable/equatable.dart';
import 'package:mind_track/features/home/domain/entities/home_dashboard.dart';

class HomeState extends Equatable {
  const HomeState({this.isLoading = false, this.dashboard, this.errorMessage});

  final bool isLoading;
  final HomeDashboard? dashboard;
  final String? errorMessage;

  HomeState copyWith({
    bool? isLoading,
    HomeDashboard? dashboard,
    String? errorMessage,
    bool clearError = false,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      dashboard: dashboard ?? this.dashboard,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[isLoading, dashboard, errorMessage];
}
