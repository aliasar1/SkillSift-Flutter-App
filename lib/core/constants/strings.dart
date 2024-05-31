// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class AppStrings {
  // API
  static const String BASE_URL =
      "https://3d1d-39-34-144-122.ngrok-free.app/api/v1";
  static const String BASE_PARSER_URL = "http://10.0.2.2:5000";

  // strings
  static const String APP_NAME = "SkillSift";
  static const String APP_HOOK_LINE = "Unveiling Talents, Shaping Futures";

  static const String COPYRIGHTS =
      "Copyright © SZABIST 2024. All Rights Reserved.";

  static const String LOG_IN = "Login";
  static const String LOG_IN_2 = "LOGIN";
  static const String LOG_IN_EX = "SECURED LOGIN";
  static const String LOG_OUT = "Logout";
  static const String LOG_OUT_2 = "LOGOUT";

  static const String FORGOT_PASSWORD = "Forgot Password?";
  static const String FORGOT_PASSWORD_2 = "FORGOT PASSWORD ?";
  static const String RESET_PASSWORD = "RESET PASSWORD";

  // hint_text
  static const String FIRST_NAME = "First Name";
  static const String USER_NAME = "Username";
  static const String USER_NAME_2 = "USER NAME";
  static const String LAST_NAME = "Last Name";
  static const String NAME = "Name";
  static const String EMAIL_ADDRESS = "Email Address";
  static const String EMAIL = "Email";
  static const String EMAIL_2 = "EMAIL";
  static const String PASSWORD = "Password";
  static const String PASSWORD_2 = "PASSWORD";

  static const String SEARCH = "Search";
  static const String SEARCH_HINT_TEXT = "Search here ..";
  static const String FILTER = "Filter";

  static const String UPLOAD_IMAGE = "Upload Image";
  static const String CAPTURE_OR_UPLOAD_IMAGE =
      "Take photo from Camera or upload image from Gallery";
  static const String CAPTURE_FROM_CAMERA = "Take Photo from Camera";
  static const String UPLOAD_FROM_GALLERY = "Upload Photo from Gallery";

  // Toggles
  static const String TAXABLE = "Taxable";

  // Buttons

  static const String BACK = "Back";
  static const String DONE = "Done";
  static const String SUBMIT = "Submit";
  static const String CANCEL = "Cancel";
  static const String SAVE = "Save";
  static const String NEXT = "Next";
  static const String PREVIOUS = "Previous";

  // Api Message Strings
  static const String LOADING = 'Loading';
  static const String NO_INTERNET_CONNECTION = 'No internet connection';
  static const String SERVER_NOT_RESPONDING = 'Server not responding';
  static const String SOMETHING_WENT_WRONG = 'Something went wrong';
  static const String API_NOT_FOUND = 'Api not found';
  static const String SERVER_ERROR = 'Server error';

  // Exception Messages
  static const String TRY_AGAIN = 'Try Again';
  static const String TOO_MUCH_FILTERING = 'Too much filtering';
  static const String NO_MATCH_FOUND =
      'We couldn\'t find any results matching your applied filters.';
  static const String TRY_AGAIN_LATER =
      'The application has encountered an unknown error.\n'
      'Please try again later.';
  static const String CONNECTION_TRY_AGAIN =
      'Please check internet connection and try again.';

  // Get Storage Keys
  static const String THEME_BOX_KEY = 'userThemeStore';
  static const String THEME_MODE_KEY = 'isDarkMode';
  static const String THEME_ACCENT_KEY = 'accentColor';

  // Font Names
  static const String MONTSERRAT = 'Montserrat';
  static const String POPPINS = 'Poppins';
  static const String WORK_SANS = 'Work Sans';

  // Get Nested Navigation Keys
  static const int GET_NESTED_AUTH_KEY = 1;

  // Email
  static String RECRUITER_EMAIL = '';
  static String RECRUITER_PASS = '';
  static String EMAIL_MESSAGE = """
Welcome! We're delighted to have you as recruiter. Here are your account credentials:

Email: $RECRUITER_EMAIL
Temporary Password: $RECRUITER_PASS

Please ensure to change your password the first time you log in for security purposes. If you encounter any issues or have questions, feel free to reach out to our support team at Company.
""";
}
