import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../features/authenticate/views/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.SPLASH:
        return GetPageRoute(
          page: () => const SplashScreen(),
          // bindings: [LoginBinding()],
        );
    }
    return null;
  }
}
