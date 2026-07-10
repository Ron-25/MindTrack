import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_track/features/profile/domain/entities/profile_settings_data.dart';
import 'package:mind_track/features/profile/domain/repositories/profile_repository.dart';
import 'package:mind_track/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required ProfileRepository profileRepository})
    : _profileRepository = profileRepository,
      super(const ProfileState());

  final ProfileRepository _profileRepository;

  Future<void> loadProfile() async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    try {
      final ProfileSettingsData profile = await _profileRepository
          .fetchProfile();
      emit(
        state.copyWith(isLoading: false, profile: profile, clearError: true),
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

  Future<void> updateProfileName(String name) async {
    emit(state.copyWith(isSaving: true, clearError: true, clearSuccess: true));
    try {
      final ProfileSettingsData profile = await _profileRepository
          .updateProfileName(name);
      emit(
        state.copyWith(
          isSaving: false,
          profile: profile,
          successMessage: 'Perfil actualizado correctamente.',
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

  Future<void> updatePreferences({
    String? languageCode,
    bool? notificationsEnabled,
    String? notificationTime,
  }) async {
    emit(state.copyWith(isSaving: true, clearError: true, clearSuccess: true));
    try {
      final ProfileSettingsData profile = await _profileRepository
          .updatePreferences(
            languageCode: languageCode,
            notificationsEnabled: notificationsEnabled,
            notificationTime: notificationTime,
          );
      emit(
        state.copyWith(
          isSaving: false,
          profile: profile,
          successMessage: 'Preferencias actualizadas.',
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
