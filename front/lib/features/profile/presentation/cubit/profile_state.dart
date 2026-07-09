import 'package:equatable/equatable.dart';
import 'package:mind_track/features/profile/domain/entities/profile_settings_data.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.isLoading = false,
    this.isSaving = false,
    this.profile,
    this.errorMessage,
    this.successMessage,
  });

  final bool isLoading;
  final bool isSaving;
  final ProfileSettingsData? profile;
  final String? errorMessage;
  final String? successMessage;

  ProfileState copyWith({
    bool? isLoading,
    bool? isSaving,
    ProfileSettingsData? profile,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      profile: profile ?? this.profile,
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
    profile,
    errorMessage,
    successMessage,
  ];
}
