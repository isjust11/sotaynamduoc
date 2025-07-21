import 'package:flutter/material.dart';
import 'package:sotaynamduoc/gen/fonts.gen.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/utils/common.dart';

class CustomTextLabel extends StatelessWidget {
  final dynamic title;
  final double? fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final int maxLines;
  final double? fontHeight;
  final bool formatCurrency;
  final String? fontFamily;
  final bool isRequired;

  const CustomTextLabel(this.title,
      {Key? key,
      this.fontSize,
      this.fontWeight = FontWeight.normal,
      this.color = Colors.black,
      this.textAlign = TextAlign.start,
      this.maxLines = 50,
      this.fontHeight,
      this.fontFamily,
      this.formatCurrency = false,
      this.isRequired = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isRequired == true) {
      return Row(
        children: [
          renderContent(),
          SizedBox(width: 3),
          Text(
            "*",
            textAlign: textAlign,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines,
            style: TextStyle(
              fontFamily: fontFamily ?? FontFamily.inter,
              height: fontHeight,
              fontSize: fontSize ?? 14,
              fontWeight: fontWeight,
              color: AppColors.colorError,
            ),
          )
        ],
      );
    }

    return renderContent();
  }

  renderContent() {
    return Text(
      (formatCurrency ? Common.formatPrice(title ?? "") : title?.toString() ?? "").trim(),
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyle(
          fontFamily: fontFamily ?? FontFamily.inter,
          height: fontHeight ?? 22.27 / 19,
          fontSize: fontSize ?? 14,
          fontWeight: fontWeight,
          color: color),
    );
  }

  static renderBaseTitle({String? title, FontWeight? fontWeight, bool isRequired = false, Color? titleColor}) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: CustomTextLabel(
        title,
        color: titleColor ?? AppColors.colorTitle,
        fontSize: 14,
        isRequired: isRequired,
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
    );
  }
}

class ErrorTextWidget extends StatelessWidget {
  final String? errorText;
  final Color? errorTextColor;
  final EdgeInsets? margin;

  const ErrorTextWidget({Key? key, this.errorText, this.errorTextColor, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error,
            size: AppDimens.SIZE_13,
            color: this.errorTextColor ?? Colors.red,
          ),
          SizedBox(width: 2),
          Expanded(
            child: CustomTextLabel(errorText, color: this.errorTextColor ?? Colors.red, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
