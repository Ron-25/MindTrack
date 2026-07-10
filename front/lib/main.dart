import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mind_track/app/injector.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mind_track/app/l10n/app_localitazion_setup.dart';
import 'package:mind_track/app/l10n/locale_controller.dart';
import 'package:mind_track/app/navigation_service.dart';
import 'package:mind_track/app/routes/app_router.dart';
import 'package:mind_track/app/routes/route_names.dart';
import 'package:mind_track/app/theme/app_colors.dart';
import 'package:mind_track/app/theme/app_theme.dart';
import 'package:mind_track/app/theme/theme_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  await ThemeController.instance.load();
  await LocaleController.instance.load();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.background,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  Injector.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.instance,
      builder: (BuildContext context, ThemeMode themeMode, Widget? child) {
        return ValueListenableBuilder<Locale?>(
          valueListenable: LocaleController.instance,
          builder: (BuildContext context, Locale? locale, Widget? child) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              title: "MindTrack",
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              locale: locale,
              localizationsDelegates:
                  AppLocalizationsSetup.localizationsDelegates,
              supportedLocales: AppLocalizationsSetup.supportedLocales,
              initialRoute: RouteNames.splash,
              onGenerateRoute: AppRouter.onGenerateRoute,
              builder: (BuildContext context, Widget? child) {
                return ToastificationWrapper(
                  child: child ?? const SizedBox.shrink(),
                );
              },
            );
          },
        );
      },
    );
  }
}
