import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../exports/views_exports.dart';
import 'app_routes.dart';

class AppPages {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.SPLASH:
        return GetPageRoute(
          page: () => const SplashScreen(),
          bindings: [],
        );
      // case AppRoutes.SLIDER:
      //   return GetPageRoute(
      //     page: () => IntroScreen(),
      //   );
      // case AppRoutes.LOGIN:
      //   return GetPageRoute(
      //     page: () => LoginScreen(),
      //   );
      // case AppRoutes.SIGNUP:
      //   return GetPageRoute(
      //     page: () => SignupScreen(),
      //   );
    }
    return null;
  }
}
