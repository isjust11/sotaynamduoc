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

  /// `Số tay nam dược`
  String get appName {
    return Intl.message('Số tay nam dược', name: 'appName', desc: '', args: []);
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

  /// `Phiên làm việc đã hệt hạn. Vui lòng đăng nhập lại`
  String get tokenExpiredMessage {
    return Intl.message(
      'Phiên làm việc đã hệt hạn. Vui lòng đăng nhập lại',
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

  /// `Xong`
  String get done {
    return Intl.message('Xong', name: 'done', desc: '', args: []);
  }

  /// `Bỏ qua`
  String get skip {
    return Intl.message('Bỏ qua', name: 'skip', desc: '', args: []);
  }

  /// `Xác thực uy tín`
  String get authenticateTrust {
    return Intl.message(
      'Xác thực uy tín',
      name: 'authenticateTrust',
      desc: '',
      args: [],
    );
  }

  /// `Tin cậy toàn cầu`
  String get globalTrust {
    return Intl.message(
      'Tin cậy toàn cầu',
      name: 'globalTrust',
      desc: '',
      args: [],
    );
  }

  /// `Truy xuất chuỗi cung ứng`
  String get supplyChainTraceability {
    return Intl.message(
      'Truy xuất chuỗi cung ứng',
      name: 'supplyChainTraceability',
      desc: '',
      args: [],
    );
  }

  /// `Định danh hàng hóa`
  String get productIdentification {
    return Intl.message(
      'Định danh hàng hóa',
      name: 'productIdentification',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập bằng tài khoản Định danh điện tử cấp bởi Bộ Công an dành cho Công dân`
  String get loginWithPublicSecurityAccount {
    return Intl.message(
      'Đăng nhập bằng tài khoản Định danh điện tử cấp bởi Bộ Công an dành cho Công dân',
      name: 'loginWithPublicSecurityAccount',
      desc: '',
      args: [],
    );
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

  /// `chi tiết`
  String get detail {
    return Intl.message('chi tiết', name: 'detail', desc: '', args: []);
  }

  /// `Đã tải hết phản ánh.`
  String get allFeedbackLoaded {
    return Intl.message(
      'Đã tải hết phản ánh.',
      name: 'allFeedbackLoaded',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiết thông báo`
  String get notificationDetail {
    return Intl.message(
      'Chi tiết thông báo',
      name: 'notificationDetail',
      desc: '',
      args: [],
    );
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
