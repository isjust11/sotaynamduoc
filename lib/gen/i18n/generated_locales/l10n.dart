// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Sổ tay nam dược`
  String get appName {
    return Intl.message('Sổ tay nam dược', name: 'appName', desc: '', args: []);
  }

  /// `Đã có lỗi xảy ra. Vui lòng thử lại sau`
  String get error_common {
    return Intl.message(
      'Đã có lỗi xảy ra. Vui lòng thử lại sau',
      name: 'error_common',
      desc: '',
      args: [],
    );
  }

  /// `Lỗi kết nối mạng`
  String get error_connection {
    return Intl.message(
      'Lỗi kết nối mạng',
      name: 'error_connection',
      desc: '',
      args: [],
    );
  }

  /// `Đang lấy dữ liệu ...`
  String get dropdown_loading {
    return Intl.message(
      'Đang lấy dữ liệu ...',
      name: 'dropdown_loading',
      desc: '',
      args: [],
    );
  }

  /// `Nhập tên đăng nhập`
  String get inputUserName {
    return Intl.message(
      'Nhập tên đăng nhập',
      name: 'inputUserName',
      desc: '',
      args: [],
    );
  }

  /// `Tên đăng nhập`
  String get userName {
    return Intl.message('Tên đăng nhập', name: 'userName', desc: '', args: []);
  }

  /// `Vui lòng nhập tên đăng nhập`
  String get plsInputUserName {
    return Intl.message(
      'Vui lòng nhập tên đăng nhập',
      name: 'plsInputUserName',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập`
  String get login {
    return Intl.message('Đăng nhập', name: 'login', desc: '', args: []);
  }

  /// `Phiên làm việc đã hết hạn. Vui lòng đăng nhập lại`
  String get tokenExpiredMessage {
    return Intl.message(
      'Phiên làm việc đã hết hạn. Vui lòng đăng nhập lại',
      name: 'tokenExpiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Đổi ngôn ngữ`
  String get changeLanguage {
    return Intl.message(
      'Đổi ngôn ngữ',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Đồng ý`
  String get agree {
    return Intl.message('Đồng ý', name: 'agree', desc: '', args: []);
  }

  /// `Đang tải...`
  String get loading {
    return Intl.message('Đang tải...', name: 'loading', desc: '', args: []);
  }

  /// `Xong`
  String get done {
    return Intl.message('Xong', name: 'done', desc: '', args: []);
  }

  /// `Bỏ qua`
  String get skip {
    return Intl.message('Bỏ qua', name: 'skip', desc: '', args: []);
  }

  /// `Xin chào`
  String get hello {
    return Intl.message('Xin chào', name: 'hello', desc: '', args: []);
  }

  /// `Trang chủ`
  String get home {
    return Intl.message('Trang chủ', name: 'home', desc: '', args: []);
  }

  /// `Lịch sử`
  String get history {
    return Intl.message('Lịch sử', name: 'history', desc: '', args: []);
  }

  /// `Cài đặt`
  String get settings {
    return Intl.message('Cài đặt', name: 'settings', desc: '', args: []);
  }

  /// `Bài viết`
  String get news {
    return Intl.message('Bài viết', name: 'news', desc: '', args: []);
  }

  /// `Xem thêm`
  String get viewMore {
    return Intl.message('Xem thêm', name: 'viewMore', desc: '', args: []);
  }

  /// `Ảnh`
  String get photo {
    return Intl.message('Ảnh', name: 'photo', desc: '', args: []);
  }

  /// `Xem tất cả`
  String get viewAll {
    return Intl.message('Xem tất cả', name: 'viewAll', desc: '', args: []);
  }

  /// `Chi tiết`
  String get detail {
    return Intl.message('Chi tiết', name: 'detail', desc: '', args: []);
  }

  /// `Thông báo`
  String get notification {
    return Intl.message('Thông báo', name: 'notification', desc: '', args: []);
  }

  /// `Thông báo chung`
  String get generalNotification {
    return Intl.message(
      'Thông báo chung',
      name: 'generalNotification',
      desc: '',
      args: [],
    );
  }

  /// `Chưa đọc`
  String get unread {
    return Intl.message('Chưa đọc', name: 'unread', desc: '', args: []);
  }

  /// `Đã đọc`
  String get read {
    return Intl.message('Đã đọc', name: 'read', desc: '', args: []);
  }

  /// `Đánh dấu đã đọc`
  String get markAsRead {
    return Intl.message(
      'Đánh dấu đã đọc',
      name: 'markAsRead',
      desc: '',
      args: [],
    );
  }

  /// `Đánh dấu tất cả đã đọc`
  String get markAllAsRead {
    return Intl.message(
      'Đánh dấu tất cả đã đọc',
      name: 'markAllAsRead',
      desc: '',
      args: [],
    );
  }

  /// `Không có thông báo`
  String get noNotifications {
    return Intl.message(
      'Không có thông báo',
      name: 'noNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Đã tải hết thông báo`
  String get allNotificationsLoaded {
    return Intl.message(
      'Đã tải hết thông báo',
      name: 'allNotificationsLoaded',
      desc: '',
      args: [],
    );
  }

  /// `Chưa có thông báo nào`
  String get noNotificationsYet {
    return Intl.message(
      'Chưa có thông báo nào',
      name: 'noNotificationsYet',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiết tin tức`
  String get newsDetail {
    return Intl.message(
      'Chi tiết tin tức',
      name: 'newsDetail',
      desc: '',
      args: [],
    );
  }

  /// `Danh sách tin tức`
  String get newsList {
    return Intl.message(
      'Danh sách tin tức',
      name: 'newsList',
      desc: '',
      args: [],
    );
  }

  /// `Giao diện`
  String get theme {
    return Intl.message('Giao diện', name: 'theme', desc: '', args: []);
  }

  /// `Thư viện`
  String get library {
    return Intl.message('Thư viện', name: 'library', desc: '', args: []);
  }

  /// `Bài thuốc`
  String get medicine {
    return Intl.message('Bài thuốc', name: 'medicine', desc: '', args: []);
  }

  /// `Thầy thuốc`
  String get teacher {
    return Intl.message('Thầy thuốc', name: 'teacher', desc: '', args: []);
  }

  /// `Thảo dược`
  String get herbal {
    return Intl.message('Thảo dược', name: 'herbal', desc: '', args: []);
  }

  /// `Bài thuốc nổi bật`
  String get featuredMedicine {
    return Intl.message(
      'Bài thuốc nổi bật',
      name: 'featuredMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Tìm bài viết...`
  String get searchNews {
    return Intl.message(
      'Tìm bài viết...',
      name: 'searchNews',
      desc: '',
      args: [],
    );
  }

  /// `Đã tải hết danh sách`
  String get endOfList {
    return Intl.message(
      'Đã tải hết danh sách',
      name: 'endOfList',
      desc: '',
      args: [],
    );
  }

  /// `Tên thuốc`
  String get folkMedicineName {
    return Intl.message(
      'Tên thuốc',
      name: 'folkMedicineName',
      desc: '',
      args: [],
    );
  }

  /// `Mô tả`
  String get folkMedicineDescription {
    return Intl.message(
      'Mô tả',
      name: 'folkMedicineDescription',
      desc: '',
      args: [],
    );
  }

  /// `Nguyên liệu`
  String get folkMedicineIngredients {
    return Intl.message(
      'Nguyên liệu',
      name: 'folkMedicineIngredients',
      desc: '',
      args: [],
    );
  }

  /// `Cách chế biến`
  String get folkMedicinePreparation {
    return Intl.message(
      'Cách chế biến',
      name: 'folkMedicinePreparation',
      desc: '',
      args: [],
    );
  }

  /// `Cách sử dụng`
  String get folkMedicineUsage {
    return Intl.message(
      'Cách sử dụng',
      name: 'folkMedicineUsage',
      desc: '',
      args: [],
    );
  }

  /// `Ghi chú`
  String get folkMedicineNote {
    return Intl.message(
      'Ghi chú',
      name: 'folkMedicineNote',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiết thảo dược`
  String get herbalDetail {
    return Intl.message(
      'Chi tiết thảo dược',
      name: 'herbalDetail',
      desc: '',
      args: [],
    );
  }

  /// `Lượt xem`
  String get viewCount {
    return Intl.message('Lượt xem', name: 'viewCount', desc: '', args: []);
  }

  /// `Lượt thích`
  String get likeCount {
    return Intl.message('Lượt thích', name: 'likeCount', desc: '', args: []);
  }

  /// `Không có dữ liệu`
  String get noDataAvailable {
    return Intl.message(
      'Không có dữ liệu',
      name: 'noDataAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Thử lại`
  String get retry {
    return Intl.message('Thử lại', name: 'retry', desc: '', args: []);
  }

  /// `Đăng xuất`
  String get logout {
    return Intl.message('Đăng xuất', name: 'logout', desc: '', args: []);
  }

  /// `Chia sẻ`
  String get share {
    return Intl.message('Chia sẻ', name: 'share', desc: '', args: []);
  }

  /// `Quay lại`
  String get back {
    return Intl.message('Quay lại', name: 'back', desc: '', args: []);
  }

  /// `Đóng`
  String get close {
    return Intl.message('Đóng', name: 'close', desc: '', args: []);
  }

  /// `Đăng nhập thành công!`
  String get loginSuccess {
    return Intl.message(
      'Đăng nhập thành công!',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu`
  String get password {
    return Intl.message('Mật khẩu', name: 'password', desc: '', args: []);
  }

  /// `Quên mật khẩu?`
  String get forgotPassword {
    return Intl.message(
      'Quên mật khẩu?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký`
  String get register {
    return Intl.message('Đăng ký', name: 'register', desc: '', args: []);
  }

  /// `Đăng nhập bằng Google`
  String get loginWithGoogle {
    return Intl.message(
      'Đăng nhập bằng Google',
      name: 'loginWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập bằng Facebook`
  String get loginWithFacebook {
    return Intl.message(
      'Đăng nhập bằng Facebook',
      name: 'loginWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `hoặc`
  String get or {
    return Intl.message('hoặc', name: 'or', desc: '', args: []);
  }

  /// `Chưa có tài khoản?`
  String get dontHaveAccount {
    return Intl.message(
      'Chưa có tài khoản?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Đã có tài khoản?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Đã có tài khoản?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký`
  String get signUp {
    return Intl.message('Đăng ký', name: 'signUp', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Xác nhận mật khẩu`
  String get confirmPassword {
    return Intl.message(
      'Xác nhận mật khẩu',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Họ và tên`
  String get fullName {
    return Intl.message('Họ và tên', name: 'fullName', desc: '', args: []);
  }

  /// `Số điện thoại`
  String get phoneNumber {
    return Intl.message(
      'Số điện thoại',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập email`
  String get plsInputEmail {
    return Intl.message(
      'Vui lòng nhập email',
      name: 'plsInputEmail',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập họ và tên`
  String get plsInputFullName {
    return Intl.message(
      'Vui lòng nhập họ và tên',
      name: 'plsInputFullName',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập số điện thoại`
  String get plsInputPhoneNumber {
    return Intl.message(
      'Vui lòng nhập số điện thoại',
      name: 'plsInputPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập mật khẩu`
  String get plsInputPassword {
    return Intl.message(
      'Vui lòng nhập mật khẩu',
      name: 'plsInputPassword',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng xác nhận mật khẩu`
  String get plsInputConfirmPassword {
    return Intl.message(
      'Vui lòng xác nhận mật khẩu',
      name: 'plsInputConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu không khớp`
  String get passwordNotMatch {
    return Intl.message(
      'Mật khẩu không khớp',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký thành công!`
  String get registerSuccess {
    return Intl.message(
      'Đăng ký thành công!',
      name: 'registerSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký bằng Google`
  String get registerWithGoogle {
    return Intl.message(
      'Đăng ký bằng Google',
      name: 'registerWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký bằng Facebook`
  String get registerWithFacebook {
    return Intl.message(
      'Đăng ký bằng Facebook',
      name: 'registerWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Email không hợp lệ`
  String get emailInvalid {
    return Intl.message(
      'Email không hợp lệ',
      name: 'emailInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký bằng Google - Sắp tới!`
  String get googleRegistrationComingSoon {
    return Intl.message(
      'Đăng ký bằng Google - Sắp tới!',
      name: 'googleRegistrationComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký bằng Facebook - Sắp tới!`
  String get facebookRegistrationComingSoon {
    return Intl.message(
      'Đăng ký bằng Facebook - Sắp tới!',
      name: 'facebookRegistrationComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu phải có ít nhất 6 ký tự`
  String get passwordMin {
    return Intl.message(
      'Mật khẩu phải có ít nhất 6 ký tự',
      name: 'passwordMin',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập thất bại!`
  String get loginFailed {
    return Intl.message(
      'Đăng nhập thất bại!',
      name: 'loginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Tên đăng nhập phải có ít nhất 3 ký tự`
  String get usernameMin {
    return Intl.message(
      'Tên đăng nhập phải có ít nhất 3 ký tự',
      name: 'usernameMin',
      desc: '',
      args: [],
    );
  }

  /// `Tên đăng nhập không được quá 20 ký tự`
  String get usernameMax {
    return Intl.message(
      'Tên đăng nhập không được quá 20 ký tự',
      name: 'usernameMax',
      desc: '',
      args: [],
    );
  }

  /// `Tên đăng nhập chỉ được chứa chữ cái, số, dấu chấm, gạch dưới và gạch ngang`
  String get usernameSpecial {
    return Intl.message(
      'Tên đăng nhập chỉ được chứa chữ cái, số, dấu chấm, gạch dưới và gạch ngang',
      name: 'usernameSpecial',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu không được quá 20 ký tự`
  String get passwordMax {
    return Intl.message(
      'Mật khẩu không được quá 20 ký tự',
      name: 'passwordMax',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập tên đăng nhập`
  String get pleaseEnterUsername {
    return Intl.message(
      'Vui lòng nhập tên đăng nhập',
      name: 'pleaseEnterUsername',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập mật khẩu`
  String get pleaseEnterPassword {
    return Intl.message(
      'Vui lòng nhập mật khẩu',
      name: 'pleaseEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng kiểm tra lại thông tin đăng nhập`
  String get pleaseCheckLoginInfo {
    return Intl.message(
      'Vui lòng kiểm tra lại thông tin đăng nhập',
      name: 'pleaseCheckLoginInfo',
      desc: '',
      args: [],
    );
  }

  /// `Xác thực tài khoản`
  String get verifyAccount {
    return Intl.message(
      'Xác thực tài khoản',
      name: 'verifyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Chúng tôi đã gửi mã PIN 4 chữ số đến:`
  String get weHaveSentThePinTo {
    return Intl.message(
      'Chúng tôi đã gửi mã PIN 4 chữ số đến:',
      name: 'weHaveSentThePinTo',
      desc: '',
      args: [],
    );
  }

  /// `Mã PIN mới đã được gửi!`
  String get newPinHasBeenSent {
    return Intl.message(
      'Mã PIN mới đã được gửi!',
      name: 'newPinHasBeenSent',
      desc: '',
      args: [],
    );
  }

  /// `Xác thực thành công!`
  String get verificationSuccess {
    return Intl.message(
      'Xác thực thành công!',
      name: 'verificationSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Gửi lại mã PIN`
  String get resend {
    return Intl.message('Gửi lại mã PIN', name: 'resend', desc: '', args: []);
  }

  /// `Xác thực`
  String get verify {
    return Intl.message('Xác thực', name: 'verify', desc: '', args: []);
  }

  /// `Đã có lỗi xảy ra. Vui lòng thử lại sau`
  String get somethingWentWrong {
    return Intl.message(
      'Đã có lỗi xảy ra. Vui lòng thử lại sau',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Thành công`
  String get success {
    return Intl.message('Thành công', name: 'success', desc: '', args: []);
  }

  /// `Cài đặt ứng dụng`
  String get appSettings {
    return Intl.message(
      'Cài đặt ứng dụng',
      name: 'appSettings',
      desc: '',
      args: [],
    );
  }

  /// `Ngôn ngữ`
  String get language {
    return Intl.message('Ngôn ngữ', name: 'language', desc: '', args: []);
  }

  /// `Chọn giao diện`
  String get chooseAppAppearance {
    return Intl.message(
      'Chọn giao diện',
      name: 'chooseAppAppearance',
      desc: '',
      args: [],
    );
  }

  /// `Quản lý thông báo`
  String get manageNotifications {
    return Intl.message(
      'Quản lý thông báo',
      name: 'manageNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập bằng vân tay`
  String get biometricLogin {
    return Intl.message(
      'Đăng nhập bằng vân tay',
      name: 'biometricLogin',
      desc: '',
      args: [],
    );
  }

  /// `Sử dụng vân tay hoặc Face ID`
  String get useFingerprintOrFaceID {
    return Intl.message(
      'Sử dụng vân tay hoặc Face ID',
      name: 'useFingerprintOrFaceID',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật thông tin của bạn`
  String get updateYourInfo {
    return Intl.message(
      'Cập nhật thông tin của bạn',
      name: 'updateYourInfo',
      desc: '',
      args: [],
    );
  }

  /// `Cài đặt quyền riêng tư`
  String get privacySettings {
    return Intl.message(
      'Cài đặt quyền riêng tư',
      name: 'privacySettings',
      desc: '',
      args: [],
    );
  }

  /// `Bảo mật`
  String get security {
    return Intl.message('Bảo mật', name: 'security', desc: '', args: []);
  }

  /// `Chỉnh sửa hồ sơ`
  String get editProfile {
    return Intl.message(
      'Chỉnh sửa hồ sơ',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Đổi ngôn ngữ`
  String get changeAppLanguage {
    return Intl.message(
      'Đổi ngôn ngữ',
      name: 'changeAppLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Thông báo`
  String get notifications {
    return Intl.message('Thông báo', name: 'notifications', desc: '', args: []);
  }

  /// `Trung tâm hỗ trợ`
  String get helpCenter {
    return Intl.message(
      'Trung tâm hỗ trợ',
      name: 'helpCenter',
      desc: '',
      args: [],
    );
  }

  /// `Nhận hỗ trợ và hướng dẫn`
  String get getHelpAndSupport {
    return Intl.message(
      'Nhận hỗ trợ và hướng dẫn',
      name: 'getHelpAndSupport',
      desc: '',
      args: [],
    );
  }

  /// `Gửi phản hồi`
  String get sendFeedback {
    return Intl.message(
      'Gửi phản hồi',
      name: 'sendFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Chia sẻ suy nghĩ của bạn`
  String get shareYourThoughts {
    return Intl.message(
      'Chia sẻ suy nghĩ của bạn',
      name: 'shareYourThoughts',
      desc: '',
      args: [],
    );
  }

  /// `Về ứng dụng`
  String get aboutApp {
    return Intl.message('Về ứng dụng', name: 'aboutApp', desc: '', args: []);
  }

  /// `Phiên bản`
  String get version {
    return Intl.message('Phiên bản', name: 'version', desc: '', args: []);
  }

  /// `Đăng nhập bằng sinh trắc học`
  String get loginWithBiometric {
    return Intl.message(
      'Đăng nhập bằng sinh trắc học',
      name: 'loginWithBiometric',
      desc: '',
      args: [],
    );
  }

  /// `Thiết lập sinh trắc học`
  String get setupBiometric {
    return Intl.message(
      'Thiết lập sinh trắc học',
      name: 'setupBiometric',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn thiết lập đăng nhập bằng sinh trắc học để đăng nhập nhanh hơn không?`
  String get setupBiometricDesc {
    return Intl.message(
      'Bạn có muốn thiết lập đăng nhập bằng sinh trắc học để đăng nhập nhanh hơn không?',
      name: 'setupBiometricDesc',
      desc: '',
      args: [],
    );
  }

  /// `Thiết lập`
  String get setup {
    return Intl.message('Thiết lập', name: 'setup', desc: '', args: []);
  }

  /// `Thiết lập sinh trắc học thành công`
  String get biometricSetupSuccess {
    return Intl.message(
      'Thiết lập sinh trắc học thành công',
      name: 'biometricSetupSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Sinh trắc học không khả dụng`
  String get biometricNotAvailable {
    return Intl.message(
      'Sinh trắc học không khả dụng',
      name: 'biometricNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Nhập thông tin đăng nhập`
  String get enterCredentials {
    return Intl.message(
      'Nhập thông tin đăng nhập',
      name: 'enterCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập đầy đủ thông tin đăng nhập`
  String get pleaseEnterCredentials {
    return Intl.message(
      'Vui lòng nhập đầy đủ thông tin đăng nhập',
      name: 'pleaseEnterCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Đã tắt đăng nhập bằng sinh trắc học`
  String get biometricDisabled {
    return Intl.message(
      'Đã tắt đăng nhập bằng sinh trắc học',
      name: 'biometricDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Hủy`
  String get cancel {
    return Intl.message('Hủy', name: 'cancel', desc: '', args: []);
  }

  /// `Chào mừng đến`
  String get welcomeTo {
    return Intl.message('Chào mừng đến', name: 'welcomeTo', desc: '', args: []);
  }

  /// `Kéo xuống để làm mới`
  String get pullToRefresh {
    return Intl.message(
      'Kéo xuống để làm mới',
      name: 'pullToRefresh',
      desc: '',
      args: [],
    );
  }

  /// `Có lỗi xảy ra`
  String get error {
    return Intl.message('Có lỗi xảy ra', name: 'error', desc: '', args: []);
  }

  /// `Thử lại`
  String get tryAgain {
    return Intl.message('Thử lại', name: 'tryAgain', desc: '', args: []);
  }

  /// `Không có dữ liệu`
  String get empty {
    return Intl.message('Không có dữ liệu', name: 'empty', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
