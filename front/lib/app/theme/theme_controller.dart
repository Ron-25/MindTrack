import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ValueNotifier<ThemeMode> {
  ThemeController._() : super(ThemeMode.light);

  static final ThemeController instance = ThemeController._();
  static const String _storageKey = 'theme_mode';

  /// Carga el tema guardado en SharedPreferences. Si no existe, migra el
  /// valor del almacenamiento anterior (HydratedBloc, que vivía en el
  /// directorio temporal y podía perderse).
  Future<void> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stored = prefs.getString(_storageKey);
    if (stored == null) {
      final Object? legacy = HydratedBloc.storage.read(_storageKey);
      if (legacy is String) {
        stored = legacy;
        await prefs.setString(_storageKey, legacy);
      }
    }
    value = stored == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> setDarkMode(bool enabled) async {
    value = enabled ? ThemeMode.dark : ThemeMode.light;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, enabled ? 'dark' : 'light');
  }
}
