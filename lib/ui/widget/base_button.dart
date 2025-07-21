import 'package:flutter/material.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

class BaseButton extends StatelessWidget {
  final String? title;
  final BoxDecoration? decoration;
  final GestureTapCallback? onTap;
  final Widget? child;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? borderColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final double? width;
  final double? height;
  final bool wrapChild;

  const BaseButton({
    this.child,
    Key? key,
    this.decoration,
    this.onTap,
    this.backgroundColor,
    this.borderRadius,
    this.borderColor = Colors.transparent,
    this.margin,
    this.padding,
    this.alignment,
    this.width,
    this.height,
    this.wrapChild = false,
    this.title,
  }) : super(key: key);










  @override
  Widget build(BuildContext context) {
    BorderRadius? borderRadiusInWell = BorderRadius.circular(0);
    if (borderRadius != null) {
      borderRadiusInWell = BorderRadius.circular(borderRadius!);
    }
    return Container(
      margin: margin ?? EdgeInsets.zero,
      alignment: alignment,
      decoration: decoration ??
          BoxDecoration(
              gradient: backgroundColor == null ? AppColors.baseColorGradient : null,
              color: backgroundColor ?? Colors.white,
              border: Border.all(color: borderColor!),
              borderRadius: BorderRadius.circular(borderRadius ?? 10)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadiusInWell,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            onTap?.call();
          },
          child: Container(
              alignment: wrapChild ? null : Alignment.center,
              width: width,
              height: height,
              padding: padding ?? EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: renderChild()),
        ),
      ),
    );
  }

  renderChild() {
    if (title != null) {
      return CustomTextLabel(
        title,
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: AppColors.white,
      );
    }
    return child ?? Container();
  }
}
