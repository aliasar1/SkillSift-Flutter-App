import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:skillsift_flutter_app/routes/app_pages.dart';

import 'constants/constants.dart';
import 'routes/app_routes.dart';
import 'widgets/custom_widgets/dismiss_keyboard.dart';

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
    return DismissKeyboard(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.APP_NAME,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: AppColors.secondaryColorDark),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.SPLASH,
        onGenerateRoute: AppPages.onGenerateRoute,
        defaultTransition: Transition.zoom,
        smartManagement: SmartManagement.full,
      ),
    );
  }
}
