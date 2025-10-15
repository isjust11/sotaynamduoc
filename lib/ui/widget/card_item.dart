import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/domain/network/api_constant.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/ui/widget/base_network_image.dart';
import 'package:sotaynamduoc/ui/widget/custom_text_label.dart';
import 'package:sotaynamduoc/utils/common.dart';

class CardItem extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String? thumbnail;
  final String? createdAt;
  final String? summary;
  final Widget? listBottomAction;
  final EdgeInsets? margin;
  const CardItem({
    super.key,
    required this.onTap,
    required this.title,
    this.thumbnail,
    this.createdAt,
    this.summary,
    this.listBottomAction,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
      child: Container(
        margin: margin,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.SIZE_16,
          vertical: AppDimens.SIZE_12,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimens.SIZE_6),
          border: Border.all(
            color: AppColors.textHintGrey.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.textDark.withValues(alpha: 0.1),
              blurRadius: AppDimens.SIZE_4,
              offset: Offset(AppDimens.SIZE_0, AppDimens.SIZE_2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
              child: thumbnail != null
                  ? BaseNetworkImage(
                      height: 80.sh,
                      width: 120.sw,
                      url: ApiConstant.apiHost + (thumbnail ?? ''),
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: AppColors.lightGreyBackground,
                      child: Icon(
                        Icons.image_not_supported,
                        size: 60,
                        color: AppColors.textMediumGrey,
                      ),
                    ),
            ),
            SizedBox(width: AppDimens.SIZE_8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextLabel(
                    title,
                    fontSize: AppDimens.SIZE_14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                    maxLines: 2,
                  ),
                  SizedBox(height: AppDimens.SIZE_4),
                  summary != null && summary!.isNotEmpty
                      ? CustomTextLabel(
                          summary!.trim(),
                          fontSize: AppDimens.SIZE_12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textDark.withValues(alpha: 0.6),
                          maxLines: 2,
                        )
                      : const SizedBox.shrink(),
                  SizedBox(height: AppDimens.SIZE_8),
                  Row(
                    children: [
                      SvgPicture.asset(
                        Assets.icons.icTime,
                        width: AppDimens.SIZE_14,
                        height: AppDimens.SIZE_14,
                      ),
                      const SizedBox(width: AppDimens.SIZE_2),
                      CustomTextLabel(
                        Common.formatDate(
                          createdAt,
                          format: 'dd/MM/yyyy HH:mm',
                        ),
                        fontSize: AppDimens.SIZE_12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textDark.withValues(alpha: 0.6),
                        maxLines: 1,
                      ),
                    ],
                  ),
                  if (listBottomAction != null) listBottomAction!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
