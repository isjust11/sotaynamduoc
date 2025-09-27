import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'locales/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('vi'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Số tay nam dược'**
  String get appName;

  /// No description provided for @error_common.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again later'**
  String get error_common;

  /// No description provided for @error_connection.
  ///
  /// In en, this message translates to:
  /// **'Network connection error'**
  String get error_connection;

  /// No description provided for @dropdown_loading.
  ///
  /// In en, this message translates to:
  /// **'Retrieving data...'**
  String get dropdown_loading;

  /// No description provided for @inputUserName.
  ///
  /// In en, this message translates to:
  /// **'Enter username'**
  String get inputUserName;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'Login name'**
  String get userName;

  /// No description provided for @plsInputUserName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your username'**
  String get plsInputUserName;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @tokenExpiredMessage.
  ///
  /// In en, this message translates to:
  /// **'The session has expired. Please log in again'**
  String get tokenExpiredMessage;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @news.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;

  /// No description provided for @viewMore.
  ///
  /// In en, this message translates to:
  /// **'View More'**
  String get viewMore;

  /// No description provided for @photo.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get photo;

  /// No description provided for @detail.
  ///
  /// In en, this message translates to:
  /// **'detail'**
  String get detail;

  /// No description provided for @warningList.
  ///
  /// In en, this message translates to:
  /// **'Warning List'**
  String get warningList;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @generalNotification.
  ///
  /// In en, this message translates to:
  /// **'General Notification'**
  String get generalNotification;

  /// No description provided for @successNotification.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get successNotification;

  /// No description provided for @infoNotification.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get infoNotification;

  /// No description provided for @unread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get unread;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @markAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark as read'**
  String get markAsRead;

  /// No description provided for @markAllAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get markAllAsRead;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get noNotifications;

  /// No description provided for @newNotification.
  ///
  /// In en, this message translates to:
  /// **'New notification'**
  String get newNotification;

  /// No description provided for @allNotificationsLoaded.
  ///
  /// In en, this message translates to:
  /// **'All notifications loaded'**
  String get allNotificationsLoaded;

  /// No description provided for @noNotificationsYet.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get noNotificationsYet;

  /// No description provided for @newsDetail.
  ///
  /// In en, this message translates to:
  /// **'News detail'**
  String get newsDetail;

  /// No description provided for @newsList.
  ///
  /// In en, this message translates to:
  /// **'News list'**
  String get newsList;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @library.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get library;

  /// No description provided for @medicine.
  ///
  /// In en, this message translates to:
  /// **'Medicine'**
  String get medicine;

  /// No description provided for @teacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get teacher;

  /// No description provided for @herbal.
  ///
  /// In en, this message translates to:
  /// **'Herbal'**
  String get herbal;

  /// No description provided for @featuredMedicine.
  ///
  /// In en, this message translates to:
  /// **'Featured medicine'**
  String get featuredMedicine;

  /// No description provided for @searchNews.
  ///
  /// In en, this message translates to:
  /// **'Search news'**
  String get searchNews;

  /// No description provided for @endOfList.
  ///
  /// In en, this message translates to:
  /// **'End of list'**
  String get endOfList;

  /// No description provided for @folkMedicineName.
  ///
  /// In en, this message translates to:
  /// **'Medicine name'**
  String get folkMedicineName;

  /// No description provided for @folkMedicineDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get folkMedicineDescription;

  /// No description provided for @folkMedicineIngredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get folkMedicineIngredients;

  /// No description provided for @folkMedicinePreparation.
  ///
  /// In en, this message translates to:
  /// **'Preparation'**
  String get folkMedicinePreparation;

  /// No description provided for @folkMedicineUsage.
  ///
  /// In en, this message translates to:
  /// **'Usage'**
  String get folkMedicineUsage;

  /// No description provided for @folkMedicineNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get folkMedicineNote;

  /// No description provided for @herbalDetail.
  ///
  /// In en, this message translates to:
  /// **'Herbal detail'**
  String get herbalDetail;

  /// No description provided for @viewCount.
  ///
  /// In en, this message translates to:
  /// **'View count'**
  String get viewCount;

  /// No description provided for @likeCount.
  ///
  /// In en, this message translates to:
  /// **'Like count'**
  String get likeCount;

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noDataAvailable;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successfully!'**
  String get loginSuccess;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get loginWithGoogle;

  /// No description provided for @loginWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Login with Facebook'**
  String get loginWithFacebook;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @plsInputEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter email'**
  String get plsInputEmail;

  /// No description provided for @plsInputFullName.
  ///
  /// In en, this message translates to:
  /// **'Please enter full name'**
  String get plsInputFullName;

  /// No description provided for @plsInputPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get plsInputPhoneNumber;

  /// No description provided for @plsInputPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get plsInputPassword;

  /// No description provided for @plsInputConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm password'**
  String get plsInputConfirmPassword;

  /// No description provided for @passwordNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordNotMatch;

  /// No description provided for @registerSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration successful!'**
  String get registerSuccess;

  /// No description provided for @registerWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Register with Google'**
  String get registerWithGoogle;

  /// No description provided for @registerWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Register with Facebook'**
  String get registerWithFacebook;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Email invalid'**
  String get emailInvalid;

  /// No description provided for @googleRegistrationComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Google registration - Coming soon!'**
  String get googleRegistrationComingSoon;

  /// No description provided for @facebookRegistrationComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Facebook registration - Coming soon!'**
  String get facebookRegistrationComingSoon;

  /// No description provided for @passwordMin.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMin;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed!'**
  String get loginFailed;

  /// No description provided for @usernameMin.
  ///
  /// In en, this message translates to:
  /// **'Username must be at least 3 characters'**
  String get usernameMin;

  /// No description provided for @usernameMax.
  ///
  /// In en, this message translates to:
  /// **'Username must be less than 50 characters'**
  String get usernameMax;

  /// No description provided for @usernameSpecial.
  ///
  /// In en, this message translates to:
  /// **'Username must contain only letters, numbers, dots, underscores and hyphens'**
  String get usernameSpecial;

  /// No description provided for @passwordMax.
  ///
  /// In en, this message translates to:
  /// **'Password must be less than 100 characters'**
  String get passwordMax;

  /// No description provided for @pleaseEnterUsername.
  ///
  /// In en, this message translates to:
  /// **'Please enter username'**
  String get pleaseEnterUsername;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get pleaseEnterPassword;

  /// No description provided for @pleaseCheckLoginInfo.
  ///
  /// In en, this message translates to:
  /// **'Please check login information'**
  String get pleaseCheckLoginInfo;

  /// No description provided for @verifyAccount.
  ///
  /// In en, this message translates to:
  /// **'Verify account'**
  String get verifyAccount;

  /// No description provided for @weHaveSentThePinTo.
  ///
  /// In en, this message translates to:
  /// **'We have sent the PIN 4 digits to:'**
  String get weHaveSentThePinTo;

  /// No description provided for @newPinHasBeenSent.
  ///
  /// In en, this message translates to:
  /// **'New PIN has been sent!'**
  String get newPinHasBeenSent;

  /// No description provided for @verificationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Verification successful!'**
  String get verificationSuccess;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend PIN'**
  String get resend;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again later'**
  String get somethingWentWrong;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @chooseAppAppearance.
  ///
  /// In en, this message translates to:
  /// **'Choose app appearance'**
  String get chooseAppAppearance;

  /// No description provided for @manageNotifications.
  ///
  /// In en, this message translates to:
  /// **'Manage notifications'**
  String get manageNotifications;

  /// No description provided for @biometricLogin.
  ///
  /// In en, this message translates to:
  /// **'Biometric Login'**
  String get biometricLogin;

  /// No description provided for @useFingerprintOrFaceID.
  ///
  /// In en, this message translates to:
  /// **'Use fingerprint or face ID'**
  String get useFingerprintOrFaceID;

  /// No description provided for @updateYourInfo.
  ///
  /// In en, this message translates to:
  /// **'Update your info'**
  String get updateYourInfo;

  /// No description provided for @privacySettings.
  ///
  /// In en, this message translates to:
  /// **'Privacy settings'**
  String get privacySettings;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @changeAppLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change app language'**
  String get changeAppLanguage;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// No description provided for @getHelpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Get help and support'**
  String get getHelpAndSupport;

  /// No description provided for @sendFeedback.
  ///
  /// In en, this message translates to:
  /// **'Send feedback'**
  String get sendFeedback;

  /// No description provided for @shareYourThoughts.
  ///
  /// In en, this message translates to:
  /// **'Share your thoughts'**
  String get shareYourThoughts;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About app'**
  String get aboutApp;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @loginWithBiometric.
  ///
  /// In en, this message translates to:
  /// **'Login with Biometric'**
  String get loginWithBiometric;

  /// No description provided for @setupBiometric.
  ///
  /// In en, this message translates to:
  /// **'Setup Biometric'**
  String get setupBiometric;

  /// No description provided for @setupBiometricDesc.
  ///
  /// In en, this message translates to:
  /// **'Would you like to setup biometric login for faster authentication?'**
  String get setupBiometricDesc;

  /// No description provided for @setup.
  ///
  /// In en, this message translates to:
  /// **'Setup'**
  String get setup;

  /// No description provided for @biometricSetupSuccess.
  ///
  /// In en, this message translates to:
  /// **'Biometric setup successful'**
  String get biometricSetupSuccess;

  /// No description provided for @biometricNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric not available'**
  String get biometricNotAvailable;

  /// No description provided for @enterCredentials.
  ///
  /// In en, this message translates to:
  /// **'Enter Credentials'**
  String get enterCredentials;

  /// No description provided for @pleaseEnterCredentials.
  ///
  /// In en, this message translates to:
  /// **'Please enter your credentials'**
  String get pleaseEnterCredentials;

  /// No description provided for @biometricDisabled.
  ///
  /// In en, this message translates to:
  /// **'Biometric login disabled'**
  String get biometricDisabled;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcomeTo;

  /// No description provided for @pullToRefresh.
  ///
  /// In en, this message translates to:
  /// **'Pull to refresh'**
  String get pullToRefresh;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get error;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @empty.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get empty;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @googlePlayServicesNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Google Play Services is not available. Please try on a real device or install Google Play Services in LDPlayer.'**
  String get googlePlayServicesNotAvailable;

  /// No description provided for @googleSignInSuccess.
  ///
  /// In en, this message translates to:
  /// **'Google sign in successfully'**
  String get googleSignInSuccess;

  /// No description provided for @googleSignInFailed.
  ///
  /// In en, this message translates to:
  /// **'Google sign in failed'**
  String get googleSignInFailed;

  /// No description provided for @googleNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Google network error'**
  String get googleNetworkError;

  /// No description provided for @googleInvalidClient.
  ///
  /// In en, this message translates to:
  /// **'Google invalid client'**
  String get googleInvalidClient;

  /// No description provided for @googleDeveloperError.
  ///
  /// In en, this message translates to:
  /// **'Google developer error'**
  String get googleDeveloperError;

  /// No description provided for @googleTimeout.
  ///
  /// In en, this message translates to:
  /// **'Google timeout'**
  String get googleTimeout;

  /// No description provided for @userCancelledGoogleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Google sign in cancelled'**
  String get userCancelledGoogleSignIn;

  /// No description provided for @facebookLoginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Facebook sign in successfully'**
  String get facebookLoginSuccess;

  /// No description provided for @facebookLoginFailed.
  ///
  /// In en, this message translates to:
  /// **'Facebook sign in failed'**
  String get facebookLoginFailed;

  /// No description provided for @facebookNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Facebook network error'**
  String get facebookNetworkError;

  /// No description provided for @facebookInvalidClient.
  ///
  /// In en, this message translates to:
  /// **'Facebook invalid client'**
  String get facebookInvalidClient;

  /// No description provided for @facebookDeveloperError.
  ///
  /// In en, this message translates to:
  /// **'Facebook developer error'**
  String get facebookDeveloperError;

  /// No description provided for @facebookTimeout.
  ///
  /// In en, this message translates to:
  /// **'Facebook timeout'**
  String get facebookTimeout;

  /// No description provided for @userCancelledFacebookSignIn.
  ///
  /// In en, this message translates to:
  /// **'Facebook sign in cancelled'**
  String get userCancelledFacebookSignIn;

  /// No description provided for @facebookAccessTokenIsNull.
  ///
  /// In en, this message translates to:
  /// **'Facebook access token is null'**
  String get facebookAccessTokenIsNull;

  /// No description provided for @facebookAccessTokenFormatInvalid.
  ///
  /// In en, this message translates to:
  /// **'Facebook access token format invalid'**
  String get facebookAccessTokenFormatInvalid;

  /// No description provided for @facebookAccessTokenValidationFailed.
  ///
  /// In en, this message translates to:
  /// **'Facebook access token validation failed'**
  String get facebookAccessTokenValidationFailed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
