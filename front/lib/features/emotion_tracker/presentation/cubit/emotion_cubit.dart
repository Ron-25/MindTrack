import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/features/emotion_tracker/domain/entities/emotion_entry.dart';
import 'package:mind_track/features/emotion_tracker/domain/repositories/emotion_repository.dart';
import 'package:mind_track/features/emotion_tracker/presentation/cubit/emotion_state.dart';

class EmotionCubit extends Cubit<EmotionState> {
  EmotionCubit({required EmotionRepository emotionRepository})
    : _emotionRepository = emotionRepository,
      super(const EmotionState());

  final EmotionRepository _emotionRepository;

  Future<void> loadEntries({int limit = 100}) async {
    emit(
      state.copyWith(
        isLoading: true,
        clearError: true,
        clearSuccess: true,
        clearLastCreatedEntryId: true,
      ),
    );
    try {
      final List<EmotionEntry> entries = await _emotionRepository.fetchEntries(
        limit: limit,
      );
      emit(
        state.copyWith(isLoading: false, entries: entries, clearError: true),
      );
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

  Future<void> loadComposerData() async {
    emit(
      state.copyWith(
        isLoading: true,
        clearError: true,
        clearSuccess: true,
        clearLastCreatedEntryId: true,
      ),
    );
    try {
      final List<dynamic> results = await Future.wait<dynamic>(
        <Future<dynamic>>[
          _emotionRepository.fetchEmotionTypes(),
          _emotionRepository.fetchTags(),
        ],
      );
      emit(
        state.copyWith(
          isLoading: false,
          emotionTypes: results[0] as List<EmotionTypeOption>,
          tags: results[1] as List<EmotionTag>,
          clearError: true,
        ),
      );
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

  Future<void> loadEntry(String id) async {
    emit(
      state.copyWith(
        isLoading: true,
        clearError: true,
        clearSuccess: true,
        clearSelectedEntry: true,
      ),
    );
    try {
      final EmotionEntry entry = await _emotionRepository.fetchEntry(id);
      emit(
        state.copyWith(
          isLoading: false,
          selectedEntry: entry,
          clearError: true,
        ),
      );
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

  Future<void> createEntry(CreateEmotionEntryInput input) async {
    emit(
      state.copyWith(
        isSaving: true,
        clearError: true,
        clearSuccess: true,
        clearLastCreatedEntryId: true,
      ),
    );
    try {
      final EmotionEntry entry = await _emotionRepository.createEntry(input);
      emit(
        state.copyWith(
          isSaving: false,
          selectedEntry: entry,
          lastCreatedEntryId: entry.id,
          successMessage: S.current.msg_emotion_saved,
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

  Future<void> updateSelectedEntry(UpdateEmotionEntryInput input) async {
    final EmotionEntry? entry = state.selectedEntry;
    if (entry == null) {
      return;
    }
    emit(state.copyWith(isSaving: true, clearError: true, clearSuccess: true));
    try {
      final EmotionEntry updated = await _emotionRepository.updateEntry(
        entry.id,
        input,
      );
      final List<EmotionEntry> updatedEntries = state.entries
          .map((EmotionEntry item) => item.id == updated.id ? updated : item)
          .toList(growable: false);
      emit(
        state.copyWith(
          isSaving: false,
          selectedEntry: updated,
          entries: updatedEntries,
          successMessage: S.current.msg_emotion_updated,
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

  Future<void> deleteSelectedEntry() async {
    final EmotionEntry? entry = state.selectedEntry;
    if (entry == null) {
      return;
    }
    emit(
      state.copyWith(isDeleting: true, clearError: true, clearSuccess: true),
    );
    try {
      await _emotionRepository.deleteEntry(entry.id);
      emit(
        state.copyWith(
          isDeleting: false,
          clearSelectedEntry: true,
          successMessage: S.current.msg_emotion_deleted,
          clearError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isDeleting: false,
          errorMessage: error.toString().replaceFirst('Exception: ', ''),
          clearSuccess: true,
        ),
      );
    }
  }

  Future<void> deleteEntryFromList(String id) async {
    emit(
      state.copyWith(isDeleting: true, clearError: true, clearSuccess: true),
    );
    try {
      await _emotionRepository.deleteEntry(id);
      final List<EmotionEntry> updatedEntries = state.entries
          .where((EmotionEntry entry) => entry.id != id)
          .toList(growable: false);
      emit(
        state.copyWith(
          isDeleting: false,
          entries: updatedEntries,
          successMessage: S.current.msg_emotion_deleted,
          clearError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isDeleting: false,
          errorMessage: error.toString().replaceFirst('Exception: ', ''),
          clearSuccess: true,
        ),
      );
    }
  }

  void clearFeedback() {
    emit(
      state.copyWith(
        clearError: true,
        clearSuccess: true,
        clearLastCreatedEntryId: true,
      ),
    );
  }
}
