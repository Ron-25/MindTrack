import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:url_launcher/url_launcher.dart';

class DeviceIntentService {
  const DeviceIntentService();

  static const String _androidPackageName = 'com.example.mind_track';
  static final Uri _privacyPolicyUri = Uri.parse(
    'https://www.termsfeed.com/live/7bc0fdb7-6edb-49f7-bb7c-79cf6c63df2b',
  );

  Future<bool> openNotificationSettings() async {
    if (!Platform.isAndroid) {
      return false;
    }

    // Explicit intent: we target the Android Settings app/component directly.
    const AndroidIntent intent = AndroidIntent(
      action: 'android.settings.APP_NOTIFICATION_SETTINGS',
      package: 'com.android.settings',
      componentName: 'com.android.settings.Settings',
      arguments: <String, dynamic>{
        'android.provider.extra.APP_PACKAGE': _androidPackageName,
        'app_package': _androidPackageName,
      },
    );

    await intent.launch();
    return true;
  }

  Future<bool> openLanguageSettings() async {
    if (!Platform.isAndroid) {
      return false;
    }

    // Explicit intent: we open a specific Settings component for locale options.
    const AndroidIntent intent = AndroidIntent(
      action: 'android.settings.LOCALE_SETTINGS',
      package: 'com.android.settings',
      componentName: 'com.android.settings.Settings',
    );

    await intent.launch();
    return true;
  }

  Future<bool> openPrivacyPolicy() async {
    // Implicit intent: the system resolves which external app/browser can open the URL.
    return launchUrl(_privacyPolicyUri, mode: LaunchMode.externalApplication);
  }
}
