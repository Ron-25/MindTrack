import 'package:equatable/equatable.dart';
import 'package:mind_track/features/habits/domain/entities/habit_tracker.dart';

class HabitState extends Equatable {
  const HabitState({
    this.isLoading = false,
    this.isSaving = false,
    this.habits = const <HabitTracker>[],
    this.errorMessage,
    this.successMessage,
  });

  final bool isLoading;
  final bool isSaving;
  final List<HabitTracker> habits;
  final String? errorMessage;
  final String? successMessage;

  HabitState copyWith({
    bool? isLoading,
    bool? isSaving,
    List<HabitTracker>? habits,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return HabitState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      habits: habits ?? this.habits,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccess
          ? null
          : (successMessage ?? this.successMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[
    isLoading,
    isSaving,
    habits,
    errorMessage,
    successMessage,
  ];
}
