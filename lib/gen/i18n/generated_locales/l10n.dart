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

  /// `Đang lưu...`
  String get saving {
    return Intl.message('Đang lưu...', name: 'saving', desc: '', args: []);
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

  /// `Cập nhật thông tin`
  String get updateYourInfo {
    return Intl.message(
      'Cập nhật thông tin',
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

  /// `Nhớ đăng nhập`
  String get rememberMe {
    return Intl.message(
      'Nhớ đăng nhập',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Google Play Services không khả dụng. Vui lòng thử trên thiết bị thật hoặc cài đặt Google Play Services trong LDPlayer.`
  String get googlePlayServicesNotAvailable {
    return Intl.message(
      'Google Play Services không khả dụng. Vui lòng thử trên thiết bị thật hoặc cài đặt Google Play Services trong LDPlayer.',
      name: 'googlePlayServicesNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập bằng Google thành công`
  String get googleSignInSuccess {
    return Intl.message(
      'Đăng nhập bằng Google thành công',
      name: 'googleSignInSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập bằng Google thất bại`
  String get googleSignInFailed {
    return Intl.message(
      'Đăng nhập bằng Google thất bại',
      name: 'googleSignInFailed',
      desc: '',
      args: [],
    );
  }

  /// `Lỗi kết nối mạng`
  String get googleNetworkError {
    return Intl.message(
      'Lỗi kết nối mạng',
      name: 'googleNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `Client ID không hợp lệ`
  String get googleInvalidClient {
    return Intl.message(
      'Client ID không hợp lệ',
      name: 'googleInvalidClient',
      desc: '',
      args: [],
    );
  }

  /// `Lỗi phát triển`
  String get googleDeveloperError {
    return Intl.message(
      'Lỗi phát triển',
      name: 'googleDeveloperError',
      desc: '',
      args: [],
    );
  }

  /// `Thời gian đăng nhập hết hạn`
  String get googleTimeout {
    return Intl.message(
      'Thời gian đăng nhập hết hạn',
      name: 'googleTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập bằng Google đã bị hủy`
  String get userCancelledGoogleSignIn {
    return Intl.message(
      'Đăng nhập bằng Google đã bị hủy',
      name: 'userCancelledGoogleSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập bằng Facebook thành công`
  String get facebookLoginSuccess {
    return Intl.message(
      'Đăng nhập bằng Facebook thành công',
      name: 'facebookLoginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập bằng Facebook thất bại`
  String get facebookLoginFailed {
    return Intl.message(
      'Đăng nhập bằng Facebook thất bại',
      name: 'facebookLoginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Lỗi kết nối mạng`
  String get facebookNetworkError {
    return Intl.message(
      'Lỗi kết nối mạng',
      name: 'facebookNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `Client ID không hợp lệ`
  String get facebookInvalidClient {
    return Intl.message(
      'Client ID không hợp lệ',
      name: 'facebookInvalidClient',
      desc: '',
      args: [],
    );
  }

  /// `Lỗi phát triển`
  String get facebookDeveloperError {
    return Intl.message(
      'Lỗi phát triển',
      name: 'facebookDeveloperError',
      desc: '',
      args: [],
    );
  }

  /// `Thời gian đăng nhập hết hạn`
  String get facebookTimeout {
    return Intl.message(
      'Thời gian đăng nhập hết hạn',
      name: 'facebookTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập bằng Facebook đã bị hủy`
  String get userCancelledFacebookSignIn {
    return Intl.message(
      'Đăng nhập bằng Facebook đã bị hủy',
      name: 'userCancelledFacebookSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Access token Facebook không được trả về`
  String get facebookAccessTokenIsNull {
    return Intl.message(
      'Access token Facebook không được trả về',
      name: 'facebookAccessTokenIsNull',
      desc: '',
      args: [],
    );
  }

  /// `Format access token Facebook không hợp lệ`
  String get facebookAccessTokenFormatInvalid {
    return Intl.message(
      'Format access token Facebook không hợp lệ',
      name: 'facebookAccessTokenFormatInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Validation access token Facebook thất bại`
  String get facebookAccessTokenValidationFailed {
    return Intl.message(
      'Validation access token Facebook thất bại',
      name: 'facebookAccessTokenValidationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Mẹo vặt`
  String get tips {
    return Intl.message('Mẹo vặt', name: 'tips', desc: '', args: []);
  }

  /// `Bạn có biết?`
  String get youKnow {
    return Intl.message('Bạn có biết?', name: 'youKnow', desc: '', args: []);
  }

  /// `Khám phá`
  String get discovery {
    return Intl.message('Khám phá', name: 'discovery', desc: '', args: []);
  }

  /// `Hôm nay bạn thấy thế nào?`
  String get todayYouFeel {
    return Intl.message(
      'Hôm nay bạn thấy thế nào?',
      name: 'todayYouFeel',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có thể tìm tên bài thuốc, triệu chứng bệnh ...`
  String get youCanSearch {
    return Intl.message(
      'Bạn có thể tìm tên bài thuốc, triệu chứng bệnh ...',
      name: 'youCanSearch',
      desc: '',
      args: [],
    );
  }

  /// `Quyền riêng tư và Bảo mật`
  String get privacyAndSecurity {
    return Intl.message(
      'Quyền riêng tư và Bảo mật',
      name: 'privacyAndSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Phản hồi`
  String get feedback {
    return Intl.message('Phản hồi', name: 'feedback', desc: '', args: []);
  }

  /// `Chúng tôi rất mong nhận được ý kiến đóng góp từ bạn để cải thiện ứng dụng.`
  String get feedbackDescription {
    return Intl.message(
      'Chúng tôi rất mong nhận được ý kiến đóng góp từ bạn để cải thiện ứng dụng.',
      name: 'feedbackDescription',
      desc: '',
      args: [],
    );
  }

  /// `Loại phản hồi`
  String get feedbackType {
    return Intl.message(
      'Loại phản hồi',
      name: 'feedbackType',
      desc: '',
      args: [],
    );
  }

  /// `Mức độ ưu tiên`
  String get feedbackPriority {
    return Intl.message(
      'Mức độ ưu tiên',
      name: 'feedbackPriority',
      desc: '',
      args: [],
    );
  }

  /// `Tiêu đề`
  String get feedbackTitle {
    return Intl.message('Tiêu đề', name: 'feedbackTitle', desc: '', args: []);
  }

  /// `Nội dung`
  String get feedbackContent {
    return Intl.message(
      'Nội dung',
      name: 'feedbackContent',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get feedbackEmail {
    return Intl.message('Email', name: 'feedbackEmail', desc: '', args: []);
  }

  /// `Số điện thoại`
  String get feedbackPhone {
    return Intl.message(
      'Số điện thoại',
      name: 'feedbackPhone',
      desc: '',
      args: [],
    );
  }

  /// `Họ và tên`
  String get feedbackName {
    return Intl.message('Họ và tên', name: 'feedbackName', desc: '', args: []);
  }

  /// `Gửi ẩn danh`
  String get feedbackAnonymous {
    return Intl.message(
      'Gửi ẩn danh',
      name: 'feedbackAnonymous',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin cá nhân sẽ không được hiển thị`
  String get feedbackAnonymousDescription {
    return Intl.message(
      'Thông tin cá nhân sẽ không được hiển thị',
      name: 'feedbackAnonymousDescription',
      desc: '',
      args: [],
    );
  }

  /// `Gửi phản hồi thành công! Cảm ơn bạn đã đóng góp ý kiến.`
  String get feedbackSuccess {
    return Intl.message(
      'Gửi phản hồi thành công! Cảm ơn bạn đã đóng góp ý kiến.',
      name: 'feedbackSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Gửi phản hồi thất bại! Vui lòng thử lại sau.`
  String get feedbackError {
    return Intl.message(
      'Gửi phản hồi thất bại! Vui lòng thử lại sau.',
      name: 'feedbackError',
      desc: '',
      args: [],
    );
  }

  /// `Lỗi`
  String get feedbackErrorTitle {
    return Intl.message('Lỗi', name: 'feedbackErrorTitle', desc: '', args: []);
  }

  /// `Vui lòng thử lại sau.`
  String get feedbackErrorDescription {
    return Intl.message(
      'Vui lòng thử lại sau.',
      name: 'feedbackErrorDescription',
      desc: '',
      args: [],
    );
  }

  /// `Thử lại`
  String get feedbackErrorButton {
    return Intl.message(
      'Thử lại',
      name: 'feedbackErrorButton',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin liên hệ`
  String get feedbackContact {
    return Intl.message(
      'Thông tin liên hệ',
      name: 'feedbackContact',
      desc: '',
      args: [],
    );
  }

  /// `Tùy chọn`
  String get feedbackOptions {
    return Intl.message(
      'Tùy chọn',
      name: 'feedbackOptions',
      desc: '',
      args: [],
    );
  }

  /// `Gửi phản hồi`
  String get feedbackSend {
    return Intl.message(
      'Gửi phản hồi',
      name: 'feedbackSend',
      desc: '',
      args: [],
    );
  }

  /// `Tiêu đề là bắt buộc`
  String get feedbackTitleRequired {
    return Intl.message(
      'Tiêu đề là bắt buộc',
      name: 'feedbackTitleRequired',
      desc: '',
      args: [],
    );
  }

  /// `Tiêu đề phải có ít nhất 5 ký tự`
  String get feedbackTitleMinLength {
    return Intl.message(
      'Tiêu đề phải có ít nhất 5 ký tự',
      name: 'feedbackTitleMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Nội dung là bắt buộc`
  String get feedbackContentRequired {
    return Intl.message(
      'Nội dung là bắt buộc',
      name: 'feedbackContentRequired',
      desc: '',
      args: [],
    );
  }

  /// `Nội dung phải có ít nhất 10 ký tự`
  String get feedbackContentMinLength {
    return Intl.message(
      'Nội dung phải có ít nhất 10 ký tự',
      name: 'feedbackContentMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Email không hợp lệ`
  String get feedbackEmailInvalid {
    return Intl.message(
      'Email không hợp lệ',
      name: 'feedbackEmailInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại không hợp lệ`
  String get feedbackPhoneInvalid {
    return Intl.message(
      'Số điện thoại không hợp lệ',
      name: 'feedbackPhoneInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Hồ sơ của tôi`
  String get myProfile {
    return Intl.message('Hồ sơ của tôi', name: 'myProfile', desc: '', args: []);
  }

  /// `Số điện thoại`
  String get phone {
    return Intl.message('Số điện thoại', name: 'phone', desc: '', args: []);
  }

  /// `Địa chỉ`
  String get address {
    return Intl.message('Địa chỉ', name: 'address', desc: '', args: []);
  }

  /// `Thành phố`
  String get city {
    return Intl.message('Thành phố', name: 'city', desc: '', args: []);
  }

  /// `Tên đăng nhập`
  String get username {
    return Intl.message('Tên đăng nhập', name: 'username', desc: '', args: []);
  }

  /// `Ngày tạo`
  String get createdAt {
    return Intl.message('Ngày tạo', name: 'createdAt', desc: '', args: []);
  }

  /// `Ngày cập nhật`
  String get updatedAt {
    return Intl.message('Ngày cập nhật', name: 'updatedAt', desc: '', args: []);
  }

  /// `Vai trò`
  String get roles {
    return Intl.message('Vai trò', name: 'roles', desc: '', args: []);
  }

  /// `Quyền`
  String get permissions {
    return Intl.message('Quyền', name: 'permissions', desc: '', args: []);
  }

  /// `Lần đăng nhập cuối`
  String get lastLogin {
    return Intl.message(
      'Lần đăng nhập cuối',
      name: 'lastLogin',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật hồ sơ`
  String get updateProfile {
    return Intl.message(
      'Cập nhật hồ sơ',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Lưu`
  String get save {
    return Intl.message('Lưu', name: 'save', desc: '', args: []);
  }

  /// `Đổi ảnh đại diện`
  String get changeAvatar {
    return Intl.message(
      'Đổi ảnh đại diện',
      name: 'changeAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Chọn ảnh`
  String get selectImage {
    return Intl.message('Chọn ảnh', name: 'selectImage', desc: '', args: []);
  }

  /// `Máy ảnh`
  String get camera {
    return Intl.message('Máy ảnh', name: 'camera', desc: '', args: []);
  }

  /// `Thư viện ảnh`
  String get gallery {
    return Intl.message('Thư viện ảnh', name: 'gallery', desc: '', args: []);
  }

  /// `Cập nhật hồ sơ thành công`
  String get profileUpdated {
    return Intl.message(
      'Cập nhật hồ sơ thành công',
      name: 'profileUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật hồ sơ thất bại`
  String get profileUpdateFailed {
    return Intl.message(
      'Cập nhật hồ sơ thất bại',
      name: 'profileUpdateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập họ và tên`
  String get pleaseEnterFullName {
    return Intl.message(
      'Vui lòng nhập họ và tên',
      name: 'pleaseEnterFullName',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập email hợp lệ`
  String get pleaseEnterValidEmail {
    return Intl.message(
      'Vui lòng nhập email hợp lệ',
      name: 'pleaseEnterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập số điện thoại`
  String get pleaseEnterPhoneNumber {
    return Intl.message(
      'Vui lòng nhập số điện thoại',
      name: 'pleaseEnterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập địa chỉ`
  String get pleaseEnterAddress {
    return Intl.message(
      'Vui lòng nhập địa chỉ',
      name: 'pleaseEnterAddress',
      desc: '',
      args: [],
    );
  }

  /// `dd/MM/yyyy`
  String get pleaseEnterBirthDate {
    return Intl.message(
      'dd/MM/yyyy',
      name: 'pleaseEnterBirthDate',
      desc: '',
      args: [],
    );
  }

  /// `Ngày sinh không hợp lệ`
  String get birthDateUncorectFormat {
    return Intl.message(
      'Ngày sinh không hợp lệ',
      name: 'birthDateUncorectFormat',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập liên kết Facebook`
  String get pleaseEnterFacebookLink {
    return Intl.message(
      'Vui lòng nhập liên kết Facebook',
      name: 'pleaseEnterFacebookLink',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập liên kết Instagram`
  String get pleaseEnterInstagramLink {
    return Intl.message(
      'Vui lòng nhập liên kết Instagram',
      name: 'pleaseEnterInstagramLink',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập liên kết Twitter`
  String get pleaseEnterTwitterLink {
    return Intl.message(
      'Vui lòng nhập liên kết Twitter',
      name: 'pleaseEnterTwitterLink',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập liên kết LinkedIn`
  String get pleaseEnterLinkedinLink {
    return Intl.message(
      'Vui lòng nhập liên kết LinkedIn',
      name: 'pleaseEnterLinkedinLink',
      desc: '',
      args: [],
    );
  }

  /// `Ngày sinh`
  String get birthDate {
    return Intl.message('Ngày sinh', name: 'birthDate', desc: '', args: []);
  }

  /// `Liên kết Facebook`
  String get facebookLink {
    return Intl.message(
      'Liên kết Facebook',
      name: 'facebookLink',
      desc: '',
      args: [],
    );
  }

  /// `Liên kết Instagram`
  String get instagramLink {
    return Intl.message(
      'Liên kết Instagram',
      name: 'instagramLink',
      desc: '',
      args: [],
    );
  }

  /// `Liên kết Twitter`
  String get twitterLink {
    return Intl.message(
      'Liên kết Twitter',
      name: 'twitterLink',
      desc: '',
      args: [],
    );
  }

  /// `Liên kết LinkedIn`
  String get linkedinLink {
    return Intl.message(
      'Liên kết LinkedIn',
      name: 'linkedinLink',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập số điện thoại hợp lệ`
  String get pleaseEnterValidPhoneNumber {
    return Intl.message(
      'Vui lòng nhập số điện thoại hợp lệ',
      name: 'pleaseEnterValidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Tiểu sử`
  String get biography {
    return Intl.message('Tiểu sử', name: 'biography', desc: '', args: []);
  }

  /// `Sự nghiệp`
  String get career {
    return Intl.message('Sự nghiệp', name: 'career', desc: '', args: []);
  }

  /// `Thành tựu`
  String get achievements {
    return Intl.message('Thành tựu', name: 'achievements', desc: '', args: []);
  }

  /// `Đóng góp`
  String get contributions {
    return Intl.message('Đóng góp', name: 'contributions', desc: '', args: []);
  }

  /// `Tác phẩm`
  String get works {
    return Intl.message('Tác phẩm', name: 'works', desc: '', args: []);
  }

  /// `Triết lý`
  String get philosophy {
    return Intl.message('Triết lý', name: 'philosophy', desc: '', args: []);
  }

  /// `Di sản`
  String get legacy {
    return Intl.message('Di sản', name: 'legacy', desc: '', args: []);
  }

  /// `Trích dẫn`
  String get quotes {
    return Intl.message('Trích dẫn', name: 'quotes', desc: '', args: []);
  }

  /// `Giai thoại`
  String get anecdotes {
    return Intl.message('Giai thoại', name: 'anecdotes', desc: '', args: []);
  }

  /// `Danh hiệu`
  String get honors {
    return Intl.message('Danh hiệu', name: 'honors', desc: '', args: []);
  }

  /// `Tưởng niệm`
  String get memorials {
    return Intl.message('Tưởng niệm', name: 'memorials', desc: '', args: []);
  }

  /// `Tài liệu tham khảo`
  String get references {
    return Intl.message(
      'Tài liệu tham khảo',
      name: 'references',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin cơ bản`
  String get basicInfo {
    return Intl.message(
      'Thông tin cơ bản',
      name: 'basicInfo',
      desc: '',
      args: [],
    );
  }

  /// `Nơi sinh`
  String get birthPlace {
    return Intl.message('Nơi sinh', name: 'birthPlace', desc: '', args: []);
  }

  /// `Nơi mất`
  String get deathPlace {
    return Intl.message('Nơi mất', name: 'deathPlace', desc: '', args: []);
  }

  /// `Thời đại`
  String get era {
    return Intl.message('Thời đại', name: 'era', desc: '', args: []);
  }

  /// `Triều đại`
  String get dynasty {
    return Intl.message('Triều đại', name: 'dynasty', desc: '', args: []);
  }

  /// `Chuyên môn`
  String get specialty {
    return Intl.message('Chuyên môn', name: 'specialty', desc: '', args: []);
  }

  /// `Học trò`
  String get students {
    return Intl.message('Học trò', name: 'students', desc: '', args: []);
  }

  /// `Bí danh`
  String get alias {
    return Intl.message('Bí danh', name: 'alias', desc: '', args: []);
  }

  /// `Không có tên`
  String get noName {
    return Intl.message('Không có tên', name: 'noName', desc: '', args: []);
  }

  /// `Thông tin khoa học`
  String get scientificInfo {
    return Intl.message(
      'Thông tin khoa học',
      name: 'scientificInfo',
      desc: '',
      args: [],
    );
  }

  /// `Tính chất dược lý`
  String get medicinalProperties {
    return Intl.message(
      'Tính chất dược lý',
      name: 'medicinalProperties',
      desc: '',
      args: [],
    );
  }

  /// `Cách chế biến`
  String get preparationMethods {
    return Intl.message(
      'Cách chế biến',
      name: 'preparationMethods',
      desc: '',
      args: [],
    );
  }

  /// `Liều lượng sử dụng`
  String get dosage {
    return Intl.message(
      'Liều lượng sử dụng',
      name: 'dosage',
      desc: '',
      args: [],
    );
  }

  /// `Chống chỉ định`
  String get contraindications {
    return Intl.message(
      'Chống chỉ định',
      name: 'contraindications',
      desc: '',
      args: [],
    );
  }

  /// `Tên khoa học`
  String get scientificName {
    return Intl.message(
      'Tên khoa học',
      name: 'scientificName',
      desc: '',
      args: [],
    );
  }

  /// `Họ`
  String get family {
    return Intl.message('Họ', name: 'family', desc: '', args: []);
  }

  /// `Bộ phận sử dụng`
  String get partsUsed {
    return Intl.message(
      'Bộ phận sử dụng',
      name: 'partsUsed',
      desc: '',
      args: [],
    );
  }

  /// `Hoạt chất chính`
  String get activeCompounds {
    return Intl.message(
      'Hoạt chất chính',
      name: 'activeCompounds',
      desc: '',
      args: [],
    );
  }

  /// `Chưa có thông tin đăng nhập để bật sinh trắc học`
  String get noLoginInfo {
    return Intl.message(
      'Chưa có thông tin đăng nhập để bật sinh trắc học',
      name: 'noLoginInfo',
      desc: '',
      args: [],
    );
  }

  /// `Sáng`
  String get light {
    return Intl.message('Sáng', name: 'light', desc: '', args: []);
  }

  /// `Tối`
  String get dark {
    return Intl.message('Tối', name: 'dark', desc: '', args: []);
  }

  /// `Không có thông tin`
  String get noInfo {
    return Intl.message(
      'Không có thông tin',
      name: 'noInfo',
      desc: '',
      args: [],
    );
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
