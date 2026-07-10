import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/routes/route_names.dart';
import 'package:mind_track/app/theme/app_colors.dart';
import 'package:mind_track/app/theme/theme_controller.dart';
import 'package:mind_track/core/services/device_intent_service.dart';
import 'package:mind_track/core/services/token_storage_service.dart';
import 'package:mind_track/core/utils/toast_utils.dart';
import 'package:mind_track/features/home/presentation/cubit/home_cubit.dart';
import 'package:mind_track/shared/widget/mindtrack_app_bar.dart';
import 'package:mind_track/features/login/presentation/blocs/login_bloc.dart';
import 'package:mind_track/features/login/presentation/blocs/login_event.dart';
import 'package:mind_track/features/profile/domain/entities/profile_settings_data.dart';
import 'package:mind_track/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:mind_track/features/profile/presentation/cubit/profile_state.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final ProfileCubit _profileCubit = Injector.get<ProfileCubit>();
  final DeviceIntentService _deviceIntentService =
      Injector.get<DeviceIntentService>();
  final TokenStorageService _tokenStorage = Injector.get<TokenStorageService>();
  final LoginBloc _loginBloc = Injector.get<LoginBloc>();
  @override
  void initState() {
    super.initState();
    _profileCubit.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    final S translations = S.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: MindTrackAppBar(
        title: translations.profile_title,
        showActions: false,
      ),
      body: SafeArea(
        child: BlocListener<ProfileCubit, ProfileState>(
          bloc: _profileCubit,
          listenWhen: (ProfileState previous, ProfileState current) {
            return previous.errorMessage != current.errorMessage ||
                previous.successMessage != current.successMessage;
          },
          listener: (BuildContext context, ProfileState state) {
            if (state.errorMessage != null) {
              ThToast.error(
                context: context,
                title: 'MindTrack',
                description: state.errorMessage!,
                applyBlurEffect: false,
              );
              _profileCubit.clearFeedback();
              return;
            }
            if (state.successMessage != null) {
              ThToast.success(
                context: context,
                title: 'MindTrack',
                description: state.successMessage!,
                applyBlurEffect: false,
              );
              _profileCubit.clearFeedback();
            }
          },
          child: BlocBuilder<ProfileCubit, ProfileState>(
            bloc: _profileCubit,
            builder: (BuildContext context, ProfileState state) {
              if (state.isLoading && state.profile == null) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.errorMessage != null && state.profile == null) {
                return _ProfileErrorState(
                  message: state.errorMessage!,
                  onRetry: _profileCubit.loadProfile,
                );
              }

              final ProfileSettingsData profile = state.profile!;
              return Stack(
                children: <Widget>[
                  RefreshIndicator(
                    color: AppColors.primary,
                    onRefresh: _profileCubit.loadProfile,
                    child: CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: <Widget>[
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(16, 24, 16, 120),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate(<Widget>[
                              _buildProfileHero(
                                context,
                                profile,
                                state.localAvatarPath,
                              ),
                              const SizedBox(height: 28),
                              _buildSectionLabel(
                                translations.profile_account_settings,
                              ),
                              const SizedBox(height: 12),
                              _SettingsCard(
                                children: <Widget>[
                                  ValueListenableBuilder<ThemeMode>(
                                    valueListenable: ThemeController.instance,
                                    builder:
                                        (
                                          BuildContext context,
                                          ThemeMode mode,
                                          Widget? child,
                                        ) {
                                          final bool isDark =
                                              mode == ThemeMode.dark;
                                          return _SettingsTile(
                                            icon: isDark
                                                ? Icons.dark_mode_rounded
                                                : Icons.light_mode_rounded,
                                            title: 'Modo oscuro',
                                            trailing: Switch.adaptive(
                                              value: isDark,
                                              onChanged: ThemeController
                                                  .instance
                                                  .setDarkMode,
                                            ),
                                            onTap: () => ThemeController
                                                .instance
                                                .setDarkMode(!isDark),
                                          );
                                        },
                                  ),
                                  _SettingsTile(
                                    icon: Icons.tune_rounded,
                                    title: translations.profile_preferences,
                                    onTap: () =>
                                        _editPreferences(context, profile),
                                  ),
                                  _SettingsTile(
                                    icon: Icons.notifications_none_rounded,
                                    title: translations
                                        .profile_notification_settings,
                                    trailingText: profile.notificationsEnabled
                                        ? 'Diario · ${profile.notificationTime ?? '20:00'}'
                                        : 'Desactivados',
                                    onTap: () =>
                                        _editReminder(context, profile),
                                  ),
                                  _SettingsTile(
                                    icon: Icons.language_rounded,
                                    title: translations.profile_language,
                                    trailingText: _languageLabel(
                                      translations,
                                      profile.languageCode,
                                    ),
                                    onTap: () =>
                                        _editPreferences(context, profile),
                                  ),
                                  _SettingsTile(
                                    icon: Icons.lock_outline_rounded,
                                    title:
                                        translations.profile_privacy_security,
                                    onTap: _openPrivacyPolicy,
                                    isLast: true,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 28),
                              OutlinedButton.icon(
                                onPressed: state.isSaving
                                    ? null
                                    : () => _handleLogout(context),
                                icon: const Icon(
                                  Icons.logout_rounded,
                                  color: Color(0xFFEF4444),
                                ),
                                label: Text(
                                  translations.profile_logout,
                                  style: const TextStyle(
                                    color: Color(0xFFEF4444),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 58),
                                  side: const BorderSide(
                                    color: Color(0xFFFECACA),
                                  ),
                                  backgroundColor: const Color(0x80FEF2F2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Center(
                                child: Text(
                                  translations.profile_footer_caption,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF94A3B8),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state.isSaving)
                    const Positioned.fill(
                      child: ColoredBox(
                        color: Color(0x660F172A),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHero(
    BuildContext context,
    ProfileSettingsData profile,
    String? localAvatarPath,
  ) {
    final File? avatarFile = localAvatarPath != null
        ? File(localAvatarPath)
        : null;
    return Column(
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
                gradient: const LinearGradient(
                  colors: <Color>[Color(0xFFD9E0E6), Color(0xFFEEF2F6)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                image: avatarFile != null
                    ? DecorationImage(
                        image: FileImage(avatarFile),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              alignment: Alignment.center,
              child: avatarFile != null
                  ? null
                  : Text(
                      _initials(profile.name),
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF475569),
                      ),
                    ),
            ),
            Positioned(
              right: 4,
              bottom: 4,
              child: GestureDetector(
                onTap: () => _showAvatarPicker(context, avatarFile != null),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.edit_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          profile.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.6,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          profile.email,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () => _editProfileName(context, profile),
          icon: const Icon(Icons.edit_outlined),
          label: const Text('Editar perfil'),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
          color: Color(0xFF94A3B8),
        ),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final S translations = S.of(context);
    await _tokenStorage.clearTokens();
    _loginBloc.add(const LoginStatusReset());
    if (!context.mounted) {
      return;
    }
    ThToast.success(
      context: context,
      title: translations.auth_success_title,
      description: translations.home_logout_success,
      applyBlurEffect: false,
    );
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.signIn,
      (Route<dynamic> route) => false,
    );
  }

  /// Hoja de configuración del recordatorio diario: activarlo y elegir hora.
  Future<void> _editReminder(
    BuildContext context,
    ProfileSettingsData profile,
  ) async {
    bool enabled = profile.notificationsEnabled;
    TimeOfDay selected =
        _parseTime(profile.notificationTime) ??
        const TimeOfDay(hour: 20, minute: 0);

    final bool? save = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (BuildContext sheetContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Recordatorio diario',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Un aviso al día para registrar cómo te sientes.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Activar recordatorio'),
                      value: enabled,
                      activeColor: AppColors.primary,
                      onChanged: (bool value) {
                        setModalState(() => enabled = value);
                      },
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      enabled: enabled,
                      leading: const Icon(Icons.schedule_rounded),
                      title: const Text('Hora del aviso'),
                      trailing: Text(
                        selected.format(context),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: enabled
                              ? AppColors.primary
                              : Theme.of(context).disabledColor,
                        ),
                      ),
                      onTap: !enabled
                          ? null
                          : () async {
                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: selected,
                              );
                              if (picked != null) {
                                setModalState(() => selected = picked);
                              }
                            },
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: _openSystemNotificationSettings,
                        icon: const Icon(Icons.settings_outlined, size: 18),
                        label: const Text(
                          'Ajustes de notificaciones del sistema',
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () =>
                                Navigator.of(sheetContext).pop(false),
                            child: const Text('Cancelar'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
                            onPressed: () =>
                                Navigator.of(sheetContext).pop(true),
                            child: const Text('Guardar'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (save != true) {
      return;
    }
    final String time =
        '${selected.hour.toString().padLeft(2, '0')}:'
        '${selected.minute.toString().padLeft(2, '0')}';
    await _profileCubit.updatePreferences(
      notificationsEnabled: enabled,
      notificationTime: time,
    );
  }

  TimeOfDay? _parseTime(String? value) {
    if (value == null || !value.contains(':')) {
      return null;
    }
    final List<String> parts = value.split(':');
    final int? hour = int.tryParse(parts[0]);
    final int? minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) {
      return null;
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  /// Hoja para elegir/cambiar la foto de perfil, guardada localmente en el
  /// dispositivo (no se envía al backend).
  Future<void> _showAvatarPicker(BuildContext context, bool hasAvatar) async {
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: const Text('Tomar foto'),
                onTap: () =>
                    Navigator.of(sheetContext).pop(ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Elegir de galería'),
                onTap: () =>
                    Navigator.of(sheetContext).pop(ImageSource.gallery),
              ),
              if (hasAvatar)
                ListTile(
                  leading: const Icon(
                    Icons.delete_outline_rounded,
                    color: Color(0xFFEF4444),
                  ),
                  title: const Text(
                    'Eliminar foto',
                    style: TextStyle(color: Color(0xFFEF4444)),
                  ),
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    _profileCubit.removeAvatar();
                  },
                ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
    if (source == null) {
      return;
    }
    final XFile? picked = await ImagePicker().pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 1024,
    );
    if (picked == null) {
      return;
    }
    await _profileCubit.updateAvatar(File(picked.path));
  }

  Future<void> _editProfileName(
    BuildContext context,
    ProfileSettingsData profile,
  ) async {
    final TextEditingController controller = TextEditingController(
      text: profile.name,
    );
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final String? result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Editar nombre',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa un nombre.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() != true) {
                        return;
                      }
                      Navigator.of(context).pop(controller.text.trim());
                    },
                    child: const Text('Guardar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    controller.dispose();
    if (result == null || result == profile.name) {
      return;
    }
    await _profileCubit.updateProfileName(result);
    Injector.get<HomeCubit>().loadDashboard();
  }

  Future<void> _editPreferences(
    BuildContext context,
    ProfileSettingsData profile,
  ) async {
    String selectedLanguage = (profile.languageCode ?? 'en').toLowerCase();
    bool notificationsEnabled = profile.notificationsEnabled;
    final ({String languageCode, bool notificationsEnabled})? result =
        await showModalBottomSheet<
          ({String languageCode, bool notificationsEnabled})
        >(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    MediaQuery.of(context).viewInsets.bottom + 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Preferencias',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Idioma',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      RadioListTile<String>(
                        value: 'es',
                        groupValue: selectedLanguage,
                        onChanged: (String? value) {
                          if (value == null) {
                            return;
                          }
                          setModalState(() => selectedLanguage = value);
                        },
                        title: const Text('Español'),
                      ),
                      RadioListTile<String>(
                        value: 'en',
                        groupValue: selectedLanguage,
                        onChanged: (String? value) {
                          if (value == null) {
                            return;
                          }
                          setModalState(() => selectedLanguage = value);
                        },
                        title: const Text('English'),
                      ),
                      SwitchListTile(
                        value: notificationsEnabled,
                        onChanged: (bool value) {
                          setModalState(() => notificationsEnabled = value);
                        },
                        title: const Text('Notificaciones'),
                        subtitle: const Text(
                          'Activa o desactiva recordatorios de la app.',
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.of(context).pop((
                              languageCode: selectedLanguage,
                              notificationsEnabled: notificationsEnabled,
                            ));
                          },
                          child: const Text('Guardar cambios'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
    if (result == null) {
      return;
    }
    await _profileCubit.updatePreferences(
      languageCode: result.languageCode,
      notificationsEnabled: result.notificationsEnabled,
    );
  }

  /// Intent explícito: abre los ajustes de notificaciones de la app
  /// en Android. En iOS se informa que la opción es solo de Android.
  Future<void> _openSystemNotificationSettings() async {
    final bool launched = await _deviceIntentService.openNotificationSettings();
    if (!mounted) {
      return;
    }
    if (!launched) {
      _showIntentUnavailableToast(S.of(context).profile_intent_android_only);
    }
  }

  Future<void> _openPrivacyPolicy() async {
    final bool launched = await _deviceIntentService.openPrivacyPolicy();
    if (!mounted) {
      return;
    }
    if (!launched) {
      _showIntentUnavailableToast(
        S.of(context).profile_intent_link_unavailable,
      );
    }
  }

  void _showIntentUnavailableToast(String description) {
    ThToast.info(
      context: context,
      title: 'MindTrack',
      description: description,
      applyBlurEffect: false,
    );
  }

  String _initials(String name) {
    final List<String> parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((String part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) {
      return 'MT';
    }
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
        .toUpperCase();
  }

  String _languageLabel(S translations, String? languageCode) {
    switch (languageCode?.toLowerCase()) {
      case 'es':
        return translations.profile_language_spanish;
      case 'en':
      default:
        return translations.profile_language_english;
    }
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.outlineVariant),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0D0F172A),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailingText,
    this.trailing,
    this.isLast = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final String? trailingText;
  final Widget? trailing;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: isLast
          ? const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            )
          : null,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colors.onSurface,
                    ),
                  ),
                ),
                if (trailingText != null) ...<Widget>[
                  Text(
                    trailingText!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                ?trailing,
                if (trailing == null)
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF94A3B8),
                  ),
              ],
            ),
          ),
          if (!isLast)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(height: 1, color: colors.outlineVariant),
            ),
        ],
      ),
    );
  }
}

class _ProfileErrorState extends StatelessWidget {
  const _ProfileErrorState({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.person_off_rounded,
              size: 52,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(S.of(context).home_retry),
            ),
          ],
        ),
      ),
    );
  }
}
