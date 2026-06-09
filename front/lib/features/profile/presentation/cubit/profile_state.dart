import 'package:equatable/equatable.dart';
import 'package:mind_track/features/profile/domain/entities/profile_settings_data.dart';

class ProfileState extends Equatable {
  const ProfileState({this.isLoading = false, this.profile, this.errorMessage});

  final bool isLoading;
  final ProfileSettingsData? profile;
  final String? errorMessage;

  ProfileState copyWith({
    bool? isLoading,
    ProfileSettingsData? profile,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      profile: profile ?? this.profile,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[isLoading, profile, errorMessage];
}
