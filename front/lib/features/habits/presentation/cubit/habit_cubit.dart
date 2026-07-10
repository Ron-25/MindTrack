import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/features/habits/domain/entities/habit_tracker.dart';
import 'package:mind_track/features/habits/domain/repositories/habit_repository.dart';
import 'package:mind_track/features/habits/presentation/cubit/habit_state.dart';

class HabitCubit extends Cubit<HabitState> {
  HabitCubit({required HabitRepository habitRepository})
    : _habitRepository = habitRepository,
      super(const HabitState());

  final HabitRepository _habitRepository;

  Future<void> loadHabits() async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    try {
      final List<HabitTracker> habits = await _habitRepository.fetchHabits();
      emit(state.copyWith(isLoading: false, habits: habits, clearError: true));
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: error.toString().replaceFirst('Exception: ', ''),
          clearSuccess: true,
        ),
      );
    }
  }

  Future<void> toggleHabit(HabitTracker habit) async {
    emit(state.copyWith(isSaving: true, clearError: true, clearSuccess: true));
    try {
      await _habitRepository.toggleHabit(
        habit.id,
        completed: !habit.completedToday,
      );
      final List<HabitTracker> habits = await _habitRepository.fetchHabits();
      emit(
        state.copyWith(
          isSaving: false,
          habits: habits,
          successMessage: !habit.completedToday
              ? S.current.msg_habit_done
              : S.current.msg_habit_pending,
          clearError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isSaving: false,
          errorMessage: error.toString().replaceFirst('Exception: ', ''),
          clearSuccess: true,
        ),
      );
    }
  }

  Future<void> createHabit(CreateHabitInput input) async {
    emit(state.copyWith(isSaving: true, clearError: true, clearSuccess: true));
    try {
      await _habitRepository.createHabit(input);
      final List<HabitTracker> habits = await _habitRepository.fetchHabits();
      emit(
        state.copyWith(
          isSaving: false,
          habits: habits,
          successMessage: S.current.msg_habit_created,
          clearError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isSaving: false,
          errorMessage: error.toString().replaceFirst('Exception: ', ''),
          clearSuccess: true,
        ),
      );
    }
  }

  Future<void> updateHabit(String id, UpdateHabitInput input) async {
    emit(state.copyWith(isSaving: true, clearError: true, clearSuccess: true));
    try {
      await _habitRepository.updateHabit(id, input);
      final List<HabitTracker> habits = await _habitRepository.fetchHabits();
      emit(
        state.copyWith(
          isSaving: false,
          habits: habits,
          successMessage: S.current.msg_habit_updated,
          clearError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isSaving: false,
          errorMessage: error.toString().replaceFirst('Exception: ', ''),
          clearSuccess: true,
        ),
      );
    }
  }

  void clearFeedback() {
    emit(state.copyWith(clearError: true, clearSuccess: true));
  }
}
