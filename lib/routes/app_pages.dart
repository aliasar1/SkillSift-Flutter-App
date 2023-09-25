import 'package:flutter/material.dart';
import 'package:skillsift_flutter_app/routes/routes.dart';
import 'package:get/get.dart';

import '../features/splash/views/splash_screen.dart';

class AppPages {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case AppRoutes.AUTH_LAYOUT:
      //   return GetPageRoute(
      //     page: () => const AuthLayout(),
      //   );

      // case AppRoutes.OFFLINE:
      //   return GetPageRoute(
      //     page: () => const OfflineScreen(),
      //   );
      case AppRoutes.SPLASH:
        return GetPageRoute(
          page: () => const SplashScreen(),
          // bindings: [LoginBinding()],
        );
      // case AppRoutes.LOGIN:
      //   return GetPageRoute(
      //     page: () => const LoginScreen(),
      //     binding: LoginBinding(),
      //   );
      // case AppRoutes.FORGOT_PASS:
      //   return GetPageRoute(
      //     page: () => const ForgotPassword(),
      //     binding: ForgotPassBinding(),
      //   );

      // case AppRoutes.HOME:
      //   return GetPageRoute(
      //     page: () => const HomePage(),
      //   );
    }
    return null;
  }
}
