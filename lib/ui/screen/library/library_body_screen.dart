import 'package:flutter/material.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

class LibraryBodyScreen extends StatelessWidget {
  const LibraryBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomTextLabel(
        'Library',
        fontSize: AppDimens.SIZE_14,
        fontWeight: FontWeight.w500,
        color: AppColors.textDark,
      ),
    );
  }
}