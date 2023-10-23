import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';

import 'core/exports/constants_exports.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialization();

  runApp(const MyApp());
}

Future initialization() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/Poppins/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  await Future.wait([
    Firebase.initializeApp(),
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.APP_NAME,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: LightTheme.primaryColor),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.SPLASH,
      onGenerateRoute: AppPages.onGenerateRoute,
      defaultTransition: Transition.zoom,
      smartManagement: SmartManagement.full,
    );
  }
}
