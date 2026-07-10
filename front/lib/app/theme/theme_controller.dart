import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeController extends ValueNotifier<ThemeMode> {
  ThemeController._() : super(ThemeMode.system);

  static final ThemeController instance = ThemeController._();
  static const String _storageKey = 'theme_mode';

  void load() {
    final Object? stored = HydratedBloc.storage.read(_storageKey);
    value = stored == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> setDarkMode(bool enabled) async {
    value = enabled ? ThemeMode.dark : ThemeMode.light;
    await HydratedBloc.storage.write(_storageKey, enabled ? 'dark' : 'light');
  }
}
