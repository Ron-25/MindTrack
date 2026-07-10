import 'package:equatable/equatable.dart';
import 'package:mind_track/features/profile/domain/entities/profile_settings_data.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.isLoading = false,
    this.isSaving = false,
    this.profile,
    this.localAvatarPath,
    this.errorMessage,
    this.successMessage,
  });

  final bool isLoading;
  final bool isSaving;
  final ProfileSettingsData? profile;

  /// Ruta del archivo de la foto de perfil guardada localmente en el
  /// dispositivo (null si el usuario no ha elegido ninguna).
  final String? localAvatarPath;
  final String? errorMessage;
  final String? successMessage;

  ProfileState copyWith({
    bool? isLoading,
    bool? isSaving,
    ProfileSettingsData? profile,
    String? localAvatarPath,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
    bool clearLocalAvatar = false,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      profile: profile ?? this.profile,
      localAvatarPath: clearLocalAvatar
          ? null
          : (localAvatarPath ?? this.localAvatarPath),
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
    localAvatarPath,
    errorMessage,
    successMessage,
  ];
}
