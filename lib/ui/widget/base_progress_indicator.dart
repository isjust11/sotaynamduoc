import 'package:flutter/material.dart';
import 'package:sotaynamduoc/res/colors.dart';

class BaseProgressIndicator extends StatelessWidget {
  final double? size;

  const BaseProgressIndicator({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    final loading = CircularProgressIndicator(
      strokeWidth: 3,
      backgroundColor: AppColors.baseColor,
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.baseColorBorderTextField),
    );
    return size == null
        ? loading
        : SizedBox(
            width: size,
            height: size,
            child: loading,
          );
  }
}
