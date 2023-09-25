// ignore_for_file: constant_identifier_names

part of constants;

class AppAssets {
  static const String _assets = 'assets/';
  static const String _app_icons = '${_assets}app_icons/';
  static const String _errors = '${_assets}errors/';
  static const String _features = '${_assets}features/';
  static const String _lottie = '${_assets}lottie/';

  // Authentication
  static const String _auth = '${_features}authentication/';
  static const String AUTH_BACKGROUND = '${_auth}background.jpg';

  // App Logos
  static const String APP_LOGO_1x = '${_app_icons}2x/Asset 1@2x.png';
  static const String APP_LOGO_2x = '${_app_icons}2x/Asset 1@2x.png';
  static const String APP_LOGO_3x = '${_app_icons}3x/Asset 1@3x.png';
  static const String APP_LOGO_4x = '${_app_icons}4x/Asset 1@4x.png';

  // Errors
  static const String CONFUSED_FACE = '${_errors}confused_face.png';
  static const String EMPTY_BOX = '${_errors}empty_box.png';
  static const String FRUSTRATED_FACE = '${_errors}frustrated_face.png';
  static const String OFFLINE_TREX = '${_lottie}offline_trex.json';
}
