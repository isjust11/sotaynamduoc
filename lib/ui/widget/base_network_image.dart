import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sotaynamduoc/ui/widget/base_progress_indicator.dart';

class BaseNetworkImage extends StatelessWidget {
  final String? url;
  final double borderRadius;
  final double? width;
  final double? height;
  final String? errorAssetImage;
  final double? loadingSize;

  const BaseNetworkImage(
      {super.key, this.url, this.borderRadius = 0, this.width, this.height, this.errorAssetImage, this.loadingSize});

  @override
  Widget build(BuildContext context) {
    Widget errorWidget = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      child: SizedBox(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        child: errorAssetImage?.isNotEmpty ?? false
            ? Image.asset(
                errorAssetImage!,
                width: width,
                height: height,
                fit: BoxFit.cover,
              )
            : Icon(Icons.error),
      ),
    );
    return url == null
        ? errorWidget
        : ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: CachedNetworkImage(
              width: width ?? double.infinity,
              height: height ?? double.infinity,
              fit: BoxFit.cover,
              imageUrl: url!,
              placeholder: (context, url) => Center(
                child: BaseProgressIndicator(size: loadingSize ?? 10),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          );
  }
}
