// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ic_avatar.svg
  String get icAvatar => 'assets/icons/ic_avatar.svg';

  /// File path: assets/icons/ic_calendar.svg
  String get icCalendar => 'assets/icons/ic_calendar.svg';

  /// File path: assets/icons/ic_close_circle.svg
  String get icCloseCircle => 'assets/icons/ic_close_circle.svg';

  /// File path: assets/icons/ic_complant.svg
  String get icComplant => 'assets/icons/ic_complant.svg';

  /// File path: assets/icons/ic_dot_horizontal.svg
  String get icDotHorizontal => 'assets/icons/ic_dot_horizontal.svg';

  /// File path: assets/icons/ic_history.svg
  String get icHistory => 'assets/icons/ic_history.svg';

  /// File path: assets/icons/ic_home.svg
  String get icHome => 'assets/icons/ic_home.svg';

  /// File path: assets/icons/ic_qrcode.svg
  String get icQrcode => 'assets/icons/ic_qrcode.svg';

  /// File path: assets/icons/ic_ring.svg
  String get icRing => 'assets/icons/ic_ring.svg';

  /// File path: assets/icons/ic_setting.svg
  String get icSetting => 'assets/icons/ic_setting.svg';

  /// List of all assets
  List<String> get values => [
    icAvatar,
    icCalendar,
    icCloseCircle,
    icComplant,
    icDotHorizontal,
    icHistory,
    icHome,
    icQrcode,
    icRing,
    icSetting,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_bar_background.png
  AssetGenImage get appBarBackground =>
      const AssetGenImage('assets/images/app_bar_background.png');

  /// File path: assets/images/background.jpg
  AssetGenImage get background =>
      const AssetGenImage('assets/images/background.jpg');

  /// File path: assets/images/camera.png
  AssetGenImage get camera => const AssetGenImage('assets/images/camera.png');

  /// File path: assets/images/ic_back.png
  AssetGenImage get icBack => const AssetGenImage('assets/images/ic_back.png');

  /// File path: assets/images/ic_back_svg.svg
  String get icBackSvg => 'assets/images/ic_back_svg.svg';

  /// File path: assets/images/ic_bg_splash.png
  AssetGenImage get icBgSplash =>
      const AssetGenImage('assets/images/ic_bg_splash.png');

  /// File path: assets/images/ic_gallery.png
  AssetGenImage get icGallery =>
      const AssetGenImage('assets/images/ic_gallery.png');

  /// File path: assets/images/ic_intro_1.png
  AssetGenImage get icIntro1 =>
      const AssetGenImage('assets/images/ic_intro_1.png');

  /// File path: assets/images/ic_intro_2.png
  AssetGenImage get icIntro2 =>
      const AssetGenImage('assets/images/ic_intro_2.png');

  /// File path: assets/images/ic_qr_code.png
  AssetGenImage get icQrCode =>
      const AssetGenImage('assets/images/ic_qr_code.png');

  /// File path: assets/images/ic_scan_qr.png
  AssetGenImage get icScanQr =>
      const AssetGenImage('assets/images/ic_scan_qr.png');

  /// File path: assets/images/ic_search.svg
  String get icSearch => 'assets/images/ic_search.svg';

  /// File path: assets/images/ic_splash.png
  AssetGenImage get icSplash =>
      const AssetGenImage('assets/images/ic_splash.png');

  /// File path: assets/images/ic_suspected.svg
  String get icSuspected => 'assets/images/ic_suspected.svg';

  /// File path: assets/images/ic_verified.svg
  String get icVerified => 'assets/images/ic_verified.svg';

  /// File path: assets/images/ic_vneid.png
  AssetGenImage get icVneid =>
      const AssetGenImage('assets/images/ic_vneid.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/sample-product.png
  AssetGenImage get sampleProduct =>
      const AssetGenImage('assets/images/sample-product.png');

  /// File path: assets/images/video.png
  AssetGenImage get video => const AssetGenImage('assets/images/video.png');

  /// List of all assets
  List<dynamic> get values => [
    appBarBackground,
    background,
    camera,
    icBack,
    icBackSvg,
    icBgSplash,
    icGallery,
    icIntro1,
    icIntro2,
    icQrCode,
    icScanQr,
    icSearch,
    icSplash,
    icSuspected,
    icVerified,
    icVneid,
    logo,
    sampleProduct,
    video,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
