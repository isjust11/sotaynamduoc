import 'package:flutter/material.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:scale_size/scale_size.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sotaynamduoc/domain/network/api_constant.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/ui/widget/base_screen.dart';

import '../../../../res/colors.dart';
import '../../../widget/base_appbar.dart';
import '../../../widget/base_network_image.dart';
import '../../../widget/custom_text_label.dart';

class LibraryDetailScreen extends StatefulWidget {
  final HerbalModel herbalData;
  
  const LibraryDetailScreen({super.key, required this.herbalData});

  @override
  State<LibraryDetailScreen> createState() => _LibraryDetailScreenState();
}

class _LibraryDetailScreenState extends State<LibraryDetailScreen> {
  bool isLiked = false;
  int currentImageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(

      customAppBar: BaseAppBar(
        title: AppLocalizations.current.herbalDetail,
        showBackButton: true,
        showUndoIcon: true,
        onBackTap: () {
          Navigator.pop(context);
        },
        actions: [
          IconButton(
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: AppColors.white,
            ),
            onPressed: () {
              setState(() {
                isLiked = !isLiked;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.share, color: AppColors.white),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            _buildContentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    final images = widget.herbalData.images ?? [];
    final thumbnail = widget.herbalData.thumbnail;
    
    if (images.isEmpty && thumbnail == null) {
      return Container(
        height: 200.sw,
        width: double.infinity,
        color: AppColors.lightGreyBackground,
        child: Icon(
          Icons.image_not_supported,
          size: 50.sw,
          color: AppColors.disabledGrey,
        ),
      );
    }

    return SizedBox(
      height: 250.sw,
      child: Stack(
        children: [
          // Main image
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentImageIndex = index;
              });
            },
            itemCount: images.isNotEmpty ? images.length : 1,
            itemBuilder: (context, index) {
              String imageUrl = '';
              if (images.isNotEmpty) {
                imageUrl = images[index].url ?? '';
              } else if (thumbnail != null) {
                imageUrl = thumbnail;
              }
              
              return BaseNetworkImage(
                url: ApiConstant.apiHost + imageUrl,
                width: double.infinity,
                height: 250.sw,
                borderRadius: 0,
              );
            },
          ),
          
          // Image indicators
          if (images.length > 1)
            Positioned(
              bottom: 16.sw,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                  (index) => Container(
                    width: 8.sw,
                    height: 8.sw,
                    margin: EdgeInsets.symmetric(horizontal: 4.sw),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentImageIndex == index
                          ? AppColors.white
                          : AppColors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Container(
      padding: EdgeInsets.all(16.sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleSection(),
          SizedBox(height: AppDimens.SIZE_8),
          _buildStatsSection(),
          SizedBox(height: AppDimens.SIZE_8),
          _buildSummarySection(),
          SizedBox(height: AppDimens.SIZE_8),
          _buildScientificInfoSection(),
          SizedBox(height: AppDimens.SIZE_8),
          _buildMedicinalPropertiesSection(),
          SizedBox(height: AppDimens.SIZE_8),
          _buildPreparationMethodsSection(),
          SizedBox(height: AppDimens.SIZE_8),
          _buildDosageSection(),
          SizedBox(height: AppDimens.SIZE_8),
          _buildContraindicationsSection(),
          SizedBox(height: AppDimens.SIZE_8),
          _buildSideEffectsSection(),
          SizedBox(height: AppDimens.SIZE_8),
          _buildDetailedContentSection(),
          SizedBox(height: AppDimens.SIZE_8),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    final title = widget.herbalData.title ?? '';
    final commonNames = widget.herbalData.commonNames;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextLabel(
          title,
          fontSize: 24.sw,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
          maxLines: 3,
        ),
        if (commonNames != null && commonNames.isNotEmpty) ...[
          SizedBox(height: AppDimens.SIZE_8),
          CustomTextLabel(
            'Tên khác: $commonNames',
            fontSize: 14.sw,
            color: AppColors.textMediumGrey,
          ),
        ],
      ],
    );
  }

  Widget _buildStatsSection() {
    final viewCount = widget.herbalData.viewCount ?? 0;
    final likeCount = widget.herbalData.likeCount ?? 0;
    
    return Row(
      children: [
        _buildStatItem(Icons.visibility, '${AppLocalizations.current.viewCount} $viewCount'),
        SizedBox(width: AppDimens.SIZE_8),
        _buildStatItem(Icons.favorite, '${AppLocalizations.current.likeCount} $likeCount'),
        SizedBox(width: AppDimens.SIZE_8),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.sw, color: AppColors.textMediumGrey),
        SizedBox(width: AppDimens.SIZE_4),
        CustomTextLabel(
          text,
          fontSize: 12.sw,
          color: AppColors.textMediumGrey,
        ),
      ],
    );
  }

  Widget _buildSummarySection() {
    final summary = widget.herbalData.summary;
    
    if (summary == null || summary.isEmpty) return SizedBox.shrink();
    
    return _buildInfoCard(
      'Tóm tắt',
      CustomTextLabel(
        summary,
        fontSize: 14.sw,
        color: AppColors.textDark,
      ),
      icon: Icons.description,
    );
  }

  Widget _buildScientificInfoSection() {
    final scientificName = widget.herbalData.scientificName;
    final family = widget.herbalData.family;
    final partsUsed = widget.herbalData.partsUsed;
    final activeCompounds = widget.herbalData.activeCompounds;
    
    if (scientificName == null && family == null && partsUsed == null && activeCompounds == null) {
      return SizedBox.shrink();
    }
    
    return _buildInfoCard(
      'Thông tin khoa học',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (scientificName != null && scientificName.isNotEmpty)
            _buildInfoRow('Tên khoa học:', scientificName),
          if (family != null && family.isNotEmpty)
            _buildInfoRow('Họ:', family),
          if (partsUsed != null && partsUsed.isNotEmpty)
            _buildInfoRow('Bộ phận sử dụng:', partsUsed),
          if (activeCompounds != null && activeCompounds.isNotEmpty)
            _buildInfoRow('Hoạt chất chính:', activeCompounds),
        ],
      ),
      icon: Icons.science,
    );
  }

  Widget _buildMedicinalPropertiesSection() {
    final properties = widget.herbalData.medicinalProperties;
    
    if (properties == null || properties.isEmpty) return SizedBox.shrink();
    
    return _buildInfoCard(
      'Tính chất dược lý',
      CustomTextLabel(
        properties,
        fontSize: 14.sw,
        color: AppColors.textDark,
      ),
      icon: Icons.healing,
    );
  }

  Widget _buildPreparationMethodsSection() {
    final methods = widget.herbalData.preparationMethods;
    
    if (methods == null || methods.isEmpty) return SizedBox.shrink();
    
    return _buildInfoCard(
      'Cách chế biến',
      CustomTextLabel(
        methods,
        fontSize: 14.sw,
        color: AppColors.textDark,
      ),
      icon: Icons.restaurant,
    );
  }

  Widget _buildDosageSection() {
    final dosage = widget.herbalData.dosage;
    
    if (dosage == null || dosage.isEmpty) return SizedBox.shrink();
    
    return _buildInfoCard(
      'Liều lượng sử dụng',
      CustomTextLabel(
        dosage,
        fontSize: 14.sw,
        color: AppColors.textDark,
      ),
      icon: Icons.medication,
    );
  }

  Widget _buildContraindicationsSection() {
    final contraindications = widget.herbalData.contraindications;
    
    if (contraindications == null || contraindications.isEmpty) return SizedBox.shrink();
    
    return _buildInfoCard(
      'Chống chỉ định',
      CustomTextLabel(
        contraindications,
        fontSize: 14.sw,
        color: AppColors.textDark,
      ),
      icon: Icons.warning,
      isWarning: true,
    );
  }

  Widget _buildSideEffectsSection() {
    final sideEffects = widget.herbalData.sideEffects;
    
    if (sideEffects == null || sideEffects.isEmpty) return SizedBox.shrink();
    
    return _buildInfoCard(
      'Tác dụng phụ',
      CustomTextLabel(
        sideEffects,
        fontSize: 14.sw,
        color: AppColors.textDark,
      ),
      icon: Icons.error_outline,
      isWarning: true,
    );
  }

  Widget _buildDetailedContentSection() {
    final content = widget.herbalData.content;
    
    if (content == null || content.isEmpty) return SizedBox.shrink();
    
    return _buildInfoCard(
      'Nội dung chi tiết',
      Html(
        data: content,
        style: {
          "body": Style(
            fontSize: FontSize(14.sw),
            color: AppColors.textDark,
            lineHeight: LineHeight(1.6),
          ),
          "p": Style(
            margin: Margins.only(bottom: 8.sw),
          ),
          "h1, h2, h3, h4, h5, h6": Style(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
            margin: Margins.only(top: 16.sw, bottom: 8.sw),
          ),
        },
      ),
      icon: Icons.article,
    );
  }

  // Widget _buildAuthorSection() {
  //   // final author = widget.herbalData.author;
    
  //   if (author == null) return SizedBox.shrink();
    
  //   final authorName = author?.name ?? 'Tác giả';
  //   final authorAvatar = author?.avatar;
    
  //   return _buildInfoCard(
  //     'Tác giả',
  //     Row(
  //       children: [
  //         if (authorAvatar != null)
  //           Container(
  //             width: 40.sw,
  //             height: 40.sw,
  //             margin: EdgeInsets.only(right: 12.sw),
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(20.sw),
  //               child: BaseNetworkImage(
  //                 url: authorAvatar,
  //                 width: 40.sw,
  //                 height: 40.sw,
  //                 borderRadius: 20.sw,
  //               ),
  //             ),
  //           ),
  //         Expanded(
  //           child: CustomTextLabel(
  //             authorName,
  //             fontSize: 14.sw,
  //             fontWeight: FontWeight.w600,
  //             color: AppColors.textDark,
  //           ),
  //         ),
  //       ],
  //     ),
  //     icon: Icons.person,
  //   );
  // }

  Widget _buildInfoCard(String title, Widget content, {IconData? icon, bool isWarning = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.sw),
      padding: EdgeInsets.all(16.sw),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.sw),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 20.sw,
                  color: isWarning ? AppColors.errorRed : AppColors.primaryBrand,
                ),
                SizedBox(width: 8.sw),
              ],
              Expanded(
                child: CustomTextLabel(
                  title,
                  fontSize: 16.sw,
                  fontWeight: FontWeight.bold,
                  color: isWarning ? AppColors.errorRed : AppColors.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.sw),
          content,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.sw),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.sw,
            child: CustomTextLabel(
              label,
              fontSize: 14.sw,
              fontWeight: FontWeight.w600,
              color: AppColors.textMediumGrey,
            ),
          ),
          Expanded(
            child: CustomTextLabel(
              value,
              fontSize: 14.sw,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}