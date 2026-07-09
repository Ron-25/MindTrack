import 'package:equatable/equatable.dart';
import 'package:mind_track/features/emotion_tracker/domain/entities/emotion_entry.dart';

class EmotionState extends Equatable {
  const EmotionState({
    this.isLoading = false,
    this.isSaving = false,
    this.isDeleting = false,
    this.entries = const <EmotionEntry>[],
    this.emotionTypes = const <EmotionTypeOption>[],
    this.tags = const <EmotionTag>[],
    this.selectedEntry,
    this.errorMessage,
    this.successMessage,
    this.lastCreatedEntryId,
  });

  final bool isLoading;
  final bool isSaving;
  final bool isDeleting;
  final List<EmotionEntry> entries;
  final List<EmotionTypeOption> emotionTypes;
  final List<EmotionTag> tags;
  final EmotionEntry? selectedEntry;
  final String? errorMessage;
  final String? successMessage;
  final String? lastCreatedEntryId;

  EmotionState copyWith({
    bool? isLoading,
    bool? isSaving,
    bool? isDeleting,
    List<EmotionEntry>? entries,
    List<EmotionTypeOption>? emotionTypes,
    List<EmotionTag>? tags,
    EmotionEntry? selectedEntry,
    String? errorMessage,
    String? successMessage,
    String? lastCreatedEntryId,
    bool clearError = false,
    bool clearSuccess = false,
    bool clearSelectedEntry = false,
    bool clearLastCreatedEntryId = false,
  }) {
    return EmotionState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      isDeleting: isDeleting ?? this.isDeleting,
      entries: entries ?? this.entries,
      emotionTypes: emotionTypes ?? this.emotionTypes,
      tags: tags ?? this.tags,
      selectedEntry: clearSelectedEntry
          ? null
          : (selectedEntry ?? this.selectedEntry),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccess
          ? null
          : (successMessage ?? this.successMessage),
      lastCreatedEntryId: clearLastCreatedEntryId
          ? null
          : (lastCreatedEntryId ?? this.lastCreatedEntryId),
    );
  }

  @override
  List<Object?> get props => <Object?>[
    isLoading,
    isSaving,
    isDeleting,
    entries,
    emotionTypes,
    tags,
    selectedEntry,
    errorMessage,
    successMessage,
    lastCreatedEntryId,
  ];
}
