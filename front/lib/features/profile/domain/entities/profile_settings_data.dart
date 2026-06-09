import 'package:equatable/equatable.dart';

class ProfileSettingsData extends Equatable {
  const ProfileSettingsData({
    required this.name,
    required this.email,
    this.avatarUrl,
    this.languageCode,
    this.notificationsEnabled = false,
  });

  final String name;
  final String email;
  final String? avatarUrl;
  final String? languageCode;
  final bool notificationsEnabled;

  @override
  List<Object?> get props => <Object?>[
    name,
    email,
    avatarUrl,
    languageCode,
    notificationsEnabled,
  ];
}
