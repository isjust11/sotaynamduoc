import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/ui/widget/custom_text_label.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoading<T extends Cubit<BaseState>> extends StatelessWidget {
  final String? message;
  final bool showMessage;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final double? size;
  final LoadingType loadingType;

  const CustomLoading({
    super.key,
    this.message,
    this.showMessage = true,
    this.backgroundColor,
    this.indicatorColor,
    this.size,
    this.loadingType = LoadingType.bouncingBall,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBlocLoading<T, BaseState>(
      message: message,
      showMessage: showMessage,
      backgroundColor: backgroundColor,
      indicatorColor: indicatorColor,
      size: size,
      loadingType: loadingType,
      loadingState: (state) => state is LoadingState,
    );
  }
}

enum LoadingType {
  waveDots,
  inkDrop,
  twistingDots,
  threeRotatingDots,
  staggeredDotsWave,
  fourRotatingDots,
  fallingDot,
  discreteCircle,
  threeArchedCircle,
  bouncingBall,
  flickr,
  hexagonDots,
  beat,
  twoRotatingArc,
  horizontalRotatingDots,
  newtonCradle,
  stretchedDots,
  halfTriangleDot,
  dotsTriangle,
}

// Custom Circular Loading Indicator with smooth animation

/// CustomLoading widget that works with both Bloc and Cubit
/// Usage with Bloc:
/// CustomBlocLoading<NewsBloc, NewsState>(
///   loadingState: (state) => state is NewsLoading,
///   message: 'Đang tải tin tức...',
/// )
///
/// Usage with Cubit:
/// CustomBlocLoading<AuthCubit, BaseState>(
///   loadingState: (state) => state is LoadingState,
///   message: 'Đang xử lý...',
/// )
class CustomBlocLoading<B extends StateStreamable<S>, S>
    extends StatelessWidget {
  final String? message;
  final bool showMessage;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final double? size;
  final LoadingType loadingType;
  final bool Function(S state) loadingState;

  const CustomBlocLoading({
    super.key,
    this.message,
    this.showMessage = true,
    this.backgroundColor,
    this.indicatorColor,
    this.size,
    this.loadingType = LoadingType.bouncingBall,
    required this.loadingState,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      builder: (_, state) {
        if (loadingState(state)) {
          return _buildLoadingOverlay(context);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoadingOverlay(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {}, // Prevent interaction
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.black.withValues(alpha: 0.3),
          ),
          child: Center(child: _buildLoadingContent(context)),
        ),
      ),
    );
  }

  Widget _buildLoadingContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.SIZE_16),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppDimens.SIZE_18),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.1),
            blurRadius: AppDimens.SIZE_16,
            offset: const Offset(0, AppDimens.SIZE_4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIndicator(),
          if (showMessage) ...[
            const SizedBox(height: AppDimens.SIZE_16),
            _buildMessage(context),
          ],
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    switch (loadingType) {
      case LoadingType.waveDots:
        return LoadingAnimationWidget.waveDots(
          color: indicatorColor ?? AppColors.baseColor,
          size: size ?? AppDimens.SIZE_32,
        );
      case LoadingType.inkDrop:
        return LoadingAnimationWidget.inkDrop(
          color: indicatorColor ?? AppColors.baseColor,
          size: size ?? AppDimens.SIZE_32,
        );
      case LoadingType.twistingDots:
        return LoadingAnimationWidget.twistingDots(
          leftDotColor: indicatorColor ?? AppColors.baseColor,
          rightDotColor: indicatorColor ?? AppColors.baseColor,
          size: size ?? AppDimens.SIZE_32,
        );
      case LoadingType.threeRotatingDots:
        return LoadingAnimationWidget.threeRotatingDots(
          color: indicatorColor ?? AppColors.baseColor,
          size: size ?? AppDimens.SIZE_32,
        );
      case LoadingType.staggeredDotsWave:
        return LoadingAnimationWidget.staggeredDotsWave(
          color: indicatorColor ?? AppColors.baseColor,
          size: size ?? AppDimens.SIZE_32,
        );
      case LoadingType.fourRotatingDots:
        return LoadingAnimationWidget.fourRotatingDots(
          color: indicatorColor ?? AppColors.baseColor,
          size: size ?? AppDimens.SIZE_32,
        );
      case LoadingType.fallingDot:
        return LoadingAnimationWidget.fallingDot(
          color: indicatorColor ?? AppColors.baseColor,
          size: size ?? AppDimens.SIZE_32,
        );
      case LoadingType.discreteCircle:
        return LoadingAnimationWidget.discreteCircle(
          color: indicatorColor ?? AppColors.baseColor,
          size: size ?? AppDimens.SIZE_32,
        );
      case LoadingType.threeArchedCircle:
        return LoadingAnimationWidget.threeArchedCircle(
          color: indicatorColor ?? AppColors.baseColor,
          size: size ?? AppDimens.SIZE_32,
        );
      case LoadingType.bouncingBall:
        return LoadingAnimationWidget.bouncingBall(
          color: indicatorColor ?? AppColors.baseColor,
          size: size ?? AppDimens.SIZE_32,
        );
      case LoadingType.flickr:
        return LoadingAnimationWidget.flickr(
          leftDotColor: indicatorColor ?? AppColors.baseColor,
          rightDotColor: indicatorColor ?? AppColors.focusBorder,
          size: size ?? AppDimens.SIZE_32,
        );
      case LoadingType.hexagonDots:
        return LoadingAnimationWidget.hexagonDots(
          color: indicatorColor ?? AppColors.baseColor,
          size: size ?? AppDimens.SIZE_32,
        );
      case LoadingType.beat:
        return LoadingAnimationWidget.beat(
          color: indicatorColor ?? AppColors.baseColor,
          size: size ?? AppDimens.SIZE_32,
        );
      case LoadingType.twoRotatingArc:
        return LoadingAnimationWidget.twoRotatingArc(
          color: indicatorColor ?? AppColors.baseColor,
          size: size ?? AppDimens.SIZE_32,
        );
      case LoadingType.horizontalRotatingDots:
        return LoadingAnimationWidget.horizontalRotatingDots(
          color: indicatorColor ?? AppColors.baseColor,
          size: size ?? AppDimens.SIZE_32,
        );
      case LoadingType.newtonCradle:
        return LoadingAnimationWidget.newtonCradle(
          color: indicatorColor ?? AppColors.baseColor,
          size: size ?? AppDimens.SIZE_32,
        );
      case LoadingType.stretchedDots:
        return LoadingAnimationWidget.stretchedDots(
          color: indicatorColor ?? AppColors.baseColor,
          size: size ?? AppDimens.SIZE_32,
        );
      case LoadingType.halfTriangleDot:
        return LoadingAnimationWidget.halfTriangleDot(
          color: indicatorColor ?? AppColors.baseColor,
          size: size ?? AppDimens.SIZE_32,
        );
      case LoadingType.dotsTriangle:
        return LoadingAnimationWidget.dotsTriangle(
          color: indicatorColor ?? AppColors.baseColor,
          size: size ?? AppDimens.SIZE_32,
        );
    }
  }

  Widget _buildMessage(BuildContext context) {
    final displayMessage = message ?? AppLocalizations.current.dropdown_loading;
    return CustomTextLabel(
      displayMessage,
      fontSize: AppDimens.SIZE_14,
      fontWeight: FontWeight.w500,
      color: AppColors.textDark,
      textAlign: TextAlign.center,
    );
  }
}
