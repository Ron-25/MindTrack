import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// Programa la notificación local del recordatorio diario según las
/// preferencias del usuario (hora y activado/desactivado).
class ReminderService {
  ReminderService(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;

  static const int _dailyReminderId = 1001;
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) {
      return;
    }
    tzdata.initializeTimeZones();
    try {
      final String timezoneName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezoneName));
    } catch (_) {
      // Si no se puede resolver la zona horaria se usa la predeterminada.
    }
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        );
    await _plugin.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
    );
    _initialized = true;
  }

  Future<void> _requestPermissions() async {
    final AndroidFlutterLocalNotificationsPlugin? android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await android?.requestNotificationsPermission();

    final IOSFlutterLocalNotificationsPlugin? ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    await ios?.requestPermissions(alert: true, badge: true, sound: true);
  }

  /// Sincroniza la notificación programada con las preferencias: cancela la
  /// existente y, si está activado, programa el aviso diario a [time] "HH:MM".
  Future<void> syncDailyReminder({
    required bool enabled,
    String? time,
  }) async {
    await init();
    await _plugin.cancel(_dailyReminderId);
    if (!enabled) {
      return;
    }
    await _requestPermissions();

    final List<String> parts = (time ?? '20:00').split(':');
    final int hour = int.tryParse(parts.first) ?? 20;
    final int minute = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (!scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      _dailyReminderId,
      '¿Cómo te sientes hoy?',
      'Tómate un minuto para registrar tu emoción en MindTrack.',
      scheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder',
          'Recordatorio diario',
          channelDescription:
              'Aviso diario para registrar tus emociones y hábitos.',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      // Modo inexacto: no requiere el permiso especial de alarmas exactas.
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      // Repite todos los días a la misma hora.
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelAll() async {
    await init();
    await _plugin.cancelAll();
  }
}
