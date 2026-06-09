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
    emit(state.copyWith(isLoading: true, clearError: true));
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
}
