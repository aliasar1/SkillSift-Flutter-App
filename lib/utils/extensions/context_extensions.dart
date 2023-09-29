part of extensions;

extension ContextExtension on BuildContext {
  MediaQueryData get _mediaQuery => MediaQuery.of(this);
  ThemeData get theme => Theme.of(this);

  // bool get isDark => Get.find<ThemeController>().isDark;

  double get deviceWidth => _mediaQuery.size.width;
  double get deviceHeight => _mediaQuery.size.height;
  bool get isLandscape => _mediaQuery.orientation == Orientation.landscape;
  bool get isPortrait => _mediaQuery.orientation == Orientation.portrait;

  bool get isAndroid => theme.platform == TargetPlatform.android;
  bool get isIOS => theme.platform == TargetPlatform.iOS;

  // Context Colors
  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;
  Color get canvasColor => theme.canvasColor;
  Color get cardColor => theme.cardColor;
  Color get primaryColorDark => theme.disabledColor;
  Color get dividerColor => theme.dividerColor;
  Color get disabledColor => theme.primaryColorDark;
  Color get hoverColor => theme.hoverColor;

  // Material 3 Colors
  Color get background => theme.colorScheme.background;
  Color get onBackground => theme.colorScheme.onBackground;
  Color get secondary => theme.colorScheme.secondary;
  Color get onSecondary => theme.colorScheme.onSecondary;
  Color get surface => theme.colorScheme.surface;
  Color get onSurface => theme.colorScheme.onSurface;
  Color get primary => theme.colorScheme.primary;
  Color get onPrimary => theme.colorScheme.onPrimary;
  Color get errorColor => theme.colorScheme.error;

  Color get fillColor => theme.inputDecorationTheme.fillColor!;
  Color get iconColor1 => theme.iconTheme.color!;
  Color get textColor => theme.textTheme.titleLarge!.color!;
  Color get buttonTextColor => AppColors.almondWhite;
  Color get progressIndicatorColor => theme.progressIndicatorTheme.color!;

  InputDecorationTheme get inputDecorationTheme => theme.inputDecorationTheme;

  InputBorder get enabledBorder => inputDecorationTheme.enabledBorder!;
  InputBorder get focusedBorder => inputDecorationTheme.focusedBorder!;
  InputBorder get errorBorder => inputDecorationTheme.errorBorder!;
  InputBorder get focusedErrorBorder =>
      inputDecorationTheme.focusedErrorBorder!;

  // Context Text Styles
  TextStyle get displayLarge => theme.textTheme.displayLarge!;
  TextStyle get displayMedium => theme.textTheme.displayMedium!;
  TextStyle get displaySmall => theme.textTheme.displaySmall!;

  TextStyle get headlineLarge => theme.textTheme.headlineLarge!;
  TextStyle get headlineMedium => theme.textTheme.headlineMedium!;
  TextStyle get headlineSmall => theme.textTheme.headlineSmall!;

  TextStyle get titleLarge => theme.textTheme.titleLarge!;
  TextStyle get titleMedium => theme.textTheme.titleMedium!;
  TextStyle get titleSmall => theme.textTheme.titleSmall!;

  TextStyle get labelLarge => theme.textTheme.labelLarge!;
  TextStyle get labelMedium => theme.textTheme.labelMedium!;
  TextStyle get labelSmall => theme.textTheme.labelSmall!;

  TextStyle get bodyLarge => theme.textTheme.bodyLarge!;
  TextStyle get bodyMedium => theme.textTheme.bodyMedium!;
  TextStyle get bodySmall => theme.textTheme.bodySmall!;

  double get statusBarHeight => _mediaQuery.padding.top;
  double get appBarHeight => _mediaQuery.padding.top + kToolbarHeight;
}
