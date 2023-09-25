// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../constants/constants.dart';
// import '../../../controllers/splash_controller.dart';

// class SplashScreen extends GetView<SplashController> {
//   static const String routeName = '/splashScreen';

//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () {
//         if (controller.isConnected.value == false) {
//           return Container();
//         } else {
//           return _buildSplashContent(context);
//           // return AnimatedSplashScreen.withScreenFunction(
//           //   centered: true,
//           //   splash: _buildSplashContent(context),
//           //   splashIconSize: Sizes.HEIGHT_300,
//           //   splashTransition: SplashTransition.fadeTransition,
//           //   backgroundColor: context.scaffoldBackgroundColor,
//           //   screenFunction: () async {
//           //     try {
//           //       // return AuthManager.instance.isLoggedIn
//           //       //     ? const HomePage()
//           //       //     : const AuthLayout();
//           //     } catch (e) {
//           //       // return const GenericErrorIndicator();
//           //     }
//           //   },
//           // );
//         }
//       },
//     );
//   }

//   Column _buildSplashContent(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         Icon(Icons.work),
//         Text(
//           AppStrings.APP_NAME,
//         ),
//       ],
//     );
//   }
// }
