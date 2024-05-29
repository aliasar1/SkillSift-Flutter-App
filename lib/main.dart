import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';

import 'app/notifications/views/notifcations_screen.dart';
import 'core/constants/theme/controller/theme_controller.dart';
import 'core/exports/constants_exports.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'core/services/notifications_api.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  await initialization();
  const SystemUiOverlayStyle(statusBarColor: Colors.black);
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future initialization() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/Poppins/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  await Future.wait([
    GetStorage.init(),
  ]);

  Get.put(ThemeController());

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.APP_NAME,
        theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: LightTheme.primaryColor),
        ),
        navigatorKey: navigatorKey,
        darkTheme: ThemeData.dark(),
        themeMode: themeController.themeMode,
        initialRoute: AppRoutes.SPLASH,
        onGenerateRoute: AppPages.onGenerateRoute,
        defaultTransition: Transition.cupertino,
        smartManagement: SmartManagement.full,
        routes: {
          NotificationsScreen.routeName: (context) => NotificationsScreen(),
        },
      ),
    );
  }
}
