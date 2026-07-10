import 'dart:io';
import 'package:mind_track/app/generated/l10n.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_track/core/services/local_avatar_service.dart';
import 'package:mind_track/features/profile/domain/entities/profile_settings_data.dart';
import 'package:mind_track/features/profile/domain/repositories/profile_repository.dart';
import 'package:mind_track/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required ProfileRepository profileRepository,
    required LocalAvatarService avatarService,
  }) : _profileRepository = profileRepository,
       _avatarService = avatarService,
       super(const ProfileState());

  final ProfileRepository _profileRepository;
  final LocalAvatarService _avatarService;

  Future<void> loadProfile() async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    try {
      final ProfileSettingsData profile = await _profileRepository
          .fetchProfile();
      final File? avatar = await _avatarService.getAvatar();
      emit(
        state.copyWith(
          isLoading: false,
          profile: profile,
          localAvatarPath: avatar?.path,
          clearLocalAvatar: avatar == null,
          clearError: true,
        ),
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

  Future<void> updateAvatar(File image) async {
    emit(state.copyWith(isSaving: true, clearError: true, clearSuccess: true));
    try {
      final File saved = await _avatarService.saveAvatar(image);
      emit(
        state.copyWith(
          isSaving: false,
          localAvatarPath: saved.path,
          successMessage: S.current.msg_photo_updated,
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

  Future<void> removeAvatar() async {
    emit(state.copyWith(isSaving: true, clearError: true, clearSuccess: true));
    try {
      await _avatarService.deleteAvatar();
      emit(
        state.copyWith(
          isSaving: false,
          clearLocalAvatar: true,
          successMessage: S.current.msg_photo_deleted,
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

  Future<void> updateProfileName(String name) async {
    emit(state.copyWith(isSaving: true, clearError: true, clearSuccess: true));
    try {
      final ProfileSettingsData profile = await _profileRepository
          .updateProfileName(name);
      emit(
        state.copyWith(
          isSaving: false,
          profile: profile,
          successMessage: S.current.msg_profile_updated,
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
          successMessage: S.current.msg_prefs_updated,
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
