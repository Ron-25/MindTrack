import 'package:equatable/equatable.dart';

class ProfileSettingsData extends Equatable {
  const ProfileSettingsData({
    required this.name,
    required this.email,
    this.avatarUrl,
    this.languageCode,
    this.notificationsEnabled = false,
    this.notificationTime,
  });

  final String name;
  final String email;
  final String? avatarUrl;
  final String? languageCode;
  final bool notificationsEnabled;

  /// Hora del recordatorio diario en formato "HH:MM".
  final String? notificationTime;

  ProfileSettingsData copyWith({
    String? name,
    String? email,
    String? avatarUrl,
    String? languageCode,
    bool? notificationsEnabled,
    String? notificationTime,
  }) {
    return ProfileSettingsData(
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      languageCode: languageCode ?? this.languageCode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      notificationTime: notificationTime ?? this.notificationTime,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    name,
    email,
    avatarUrl,
    languageCode,
    notificationsEnabled,
    notificationTime,
  ];
}
