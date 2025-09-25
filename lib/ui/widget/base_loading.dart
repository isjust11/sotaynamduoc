import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
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
  final bool Function(BaseState state)? loadingState;
  final bool Function(BaseState state)? errorState;
  final bool Function(BaseState state)? emptyState;
  final Function()? onRefresh;

  const CustomLoading({
    super.key,
    this.message,
    this.showMessage = true,
    this.backgroundColor = const Color.fromRGBO(0, 0, 0, 0.4),
    this.indicatorColor = AppColors.baseColor,
    this.size,
    this.loadingType = LoadingType.threeArchedCircle,
    this.loadingState,
    this.errorState,
    this.emptyState,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBlocResult<T, BaseState>(
      message: AppLocalizations.current.loading,
      showMessage: showMessage,
      backgroundColor: backgroundColor,
      indicatorColor: indicatorColor,
      size: size,
      loadingType: loadingType,
      loadingState: (state) => state is LoadingState,
      errorState: (state) => state is ErrorState,
      emptyState: (state) => state is EmptyState,
      onRefresh: onRefresh,
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
class CustomBlocResult<B extends StateStreamable<S>, S>
    extends StatelessWidget {
  final String? message;
  final bool showMessage;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final double? size;
  final LoadingType loadingType;
  final bool Function(S state) loadingState;
  final bool Function(S state)? errorState;
  final bool Function(S state)? emptyState;
  final Function()? onRefresh;
  const CustomBlocResult({
    super.key,
    this.message,
    this.showMessage = true,
    this.backgroundColor,
    this.indicatorColor,
    this.size,
    this.loadingType = LoadingType.bouncingBall,
    required this.loadingState,
    this.errorState,
    this.emptyState,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      builder: (_, state) {
        if (loadingState(state)) {
          return _buildLoadingOverlay(context);
        }
        if (errorState != null && errorState!(state)) {
          return _buildErrorContent(context);
        }
        if (emptyState != null && emptyState!(state)) {
          return _buildEmptyContent(context);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildEmptyContent(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh?.call();
      },
      child: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          Center(
            child: Column(
              children: [
                SvgPicture.asset(
                  Assets.icons.icFolderEmpty,
                  width: 64.sw,
                  height: 64.sw,
                  colorFilter: ColorFilter.mode(
                    AppColors.textDark.withValues(alpha: 0.6),
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(height: AppDimens.SIZE_16),
                CustomTextLabel(
                  AppLocalizations.current.empty,
                  fontSize: AppDimens.SIZE_16,
                  color: AppColors.textDark.withValues(alpha: 0.6),
                ),
                SizedBox(height: AppDimens.SIZE_8),
                CustomTextLabel(
                  AppLocalizations.current.pullToRefresh,
                  fontSize: AppDimens.SIZE_14,
                  color: AppColors.textDark.withValues(alpha: 0.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorContent(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => onRefresh?.call(),
      child: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64.sw,
                  color: AppColors.errorRed,
                ),
                SizedBox(height: AppDimens.SIZE_16),
                CustomTextLabel(
                  AppLocalizations.current.error,
                  fontSize: AppDimens.SIZE_16,
                  color: AppColors.errorRed,
                ),
                SizedBox(height: AppDimens.SIZE_8),
                CustomTextLabel(
                  message ?? AppLocalizations.current.error,
                  fontSize: AppDimens.SIZE_14,
                  color: AppColors.textDark.withValues(alpha: 0.6),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppDimens.SIZE_16),
                ElevatedButton(
                  onPressed: () {
                    onRefresh?.call();
                  },
                  child: CustomTextLabel(
                    AppLocalizations.current.tryAgain,
                    fontSize: AppDimens.SIZE_14,
                    color: AppColors.colorTitle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
        color: AppColors.white.withValues(alpha: 0.7),
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
    final displayMessage = AppLocalizations.current.loading;
    return CustomTextLabel(
      displayMessage,
      fontSize: AppDimens.SIZE_14,
      fontWeight: FontWeight.w500,
      color: AppColors.textDark,
      textAlign: TextAlign.center,
    );
  }
}
