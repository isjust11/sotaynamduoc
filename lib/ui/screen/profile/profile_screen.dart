import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/blocs/cubit.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/network/api_constant.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/routes.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthCubit>().getProfile();
    return BaseScreen(
      customAppBar: BaseAppBar(
        title: AppLocalizations.current.myProfile,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.updateProfileScreen);
            },
            icon: Icon(
              Icons.edit,
              color: AppColors.white,
              size: AppDimens.SIZE_16,
            ),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<AuthCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadedState) {
          UserModel userModel = state.data;
          return _buildUserInfo(userModel);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildUserInfo(UserModel userModel) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header với gradient background
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: AppColors.baseColor),
            child: Stack(
              children: [
                // SVG background
                Positioned.fill(
                  child: SvgPicture.asset(
                    Assets.images.checkeredPattern,
                    fit: BoxFit.cover,
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.all(AppDimens.SIZE_24),
                  child: Row(
                    children: [
                      // Avatar với border và shadow
                      Container(
                        width: AppDimens.SIZE_100,
                        height: AppDimens.SIZE_100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: userModel.picture != null
                              ? BaseNetworkImage(
                                  url:
                                      ApiConstant.storageHost +
                                      (userModel.picture ?? ''),
                                  fit: BoxFit.cover,
                                  showShimmer: false,
                                )
                              : Container(
                                  color: AppColors.border.withValues(
                                    alpha: 0.3,
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    size: AppDimens.SIZE_60,
                                    color: AppColors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: AppDimens.SIZE_16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextLabel(
                            userModel.fullName ?? '',
                            color: AppColors.white,
                            fontSize: AppDimens.SIZE_20,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: AppDimens.SIZE_4),
                          // Email
                          CustomTextLabel(
                            userModel.email ?? '',
                            color: AppColors.white.withValues(alpha: 0.9),
                            fontSize: AppDimens.SIZE_14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),

                      // Tên user
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Card thông tin chi tiết
          Container(
            margin: const EdgeInsets.all(AppDimens.SIZE_8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.SIZE_12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thông tin cơ bản
                  _buildInfoCard(
                    AppLocalizations.current.username,
                    userModel.username ?? '',
                    Icons.person_outline,
                  ),
                  _buildInfoCard(
                    AppLocalizations.current.roles,
                    userModel.roles.map((e) => e.name).join(', '),
                    Icons.admin_panel_settings_outlined,
                  ),
                  _buildInfoCard(
                    AppLocalizations.current.permissions,
                    userModel.permissions.map((e) => e.name).join(', '),
                    Icons.security_outlined,
                  ),
                  _buildInfoCard(
                    AppLocalizations.current.birthDate,
                    userModel.birthDate ?? '',
                    Icons.calendar_today_outlined,
                  ),
                  _buildInfoCard(
                    AppLocalizations.current.address,
                    userModel.address ?? '',
                    Icons.location_on_outlined,
                  ),
                  _buildInfoCard(
                    AppLocalizations.current.facebookLink,
                    userModel.facebookLink ?? '',
                    Icons.facebook_outlined,
                  ),
                  _buildInfoCard(
                    AppLocalizations.current.instagramLink,
                    userModel.instagramLink ?? '',
                    Icons.link_outlined,
                  ),
                  _buildInfoCard(
                    AppLocalizations.current.twitterLink,
                    userModel.twitterLink ?? '',
                    Icons.link_outlined,
                  ),
                  _buildInfoCard(
                    AppLocalizations.current.linkedinLink,
                    userModel.linkedinLink ?? '',
                    Icons.link_outlined,
                  ),
                  _buildInfoCard(
                    AppLocalizations.current.phoneNumber,
                    userModel.phoneNumber ?? '',
                    Icons.phone_outlined,
                  ),

                  const SizedBox(height: AppDimens.SIZE_20),

                  _buildInfoCard(
                    AppLocalizations.current.createdAt,
                    userModel.createdAt ?? '',
                    Icons.calendar_today_outlined,
                  ),
                  _buildInfoCard(
                    AppLocalizations.current.updatedAt,
                    userModel.updatedAt ?? '',
                    Icons.update_outlined,
                  ),
                  _buildInfoCard(
                    AppLocalizations.current.lastLogin,
                    userModel.lastLogin != null
                        ? DateFormat(
                            'dd/MM/yyyy HH:mm',
                          ).format(DateTime.parse(userModel.lastLogin ?? ''))
                        : AppLocalizations.current.noInfo,
                    Icons.login_outlined,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.SIZE_12),
      padding: const EdgeInsets.all(AppDimens.SIZE_8),
      decoration: BoxDecoration(
        color: AppColors.baseColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
        border: Border.all(
          color: AppColors.baseColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimens.SIZE_8),
            decoration: BoxDecoration(
              color: AppColors.secondaryBrand.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
            ),
            child: Icon(
              icon,
              color: AppColors.secondaryBrand,
              size: AppDimens.SIZE_20,
            ),
          ),
          const SizedBox(width: AppDimens.SIZE_12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextLabel(
                  title,
                  color: AppColors.baseColor,
                  fontSize: AppDimens.SIZE_12,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: AppDimens.SIZE_4),
                CustomTextLabel(
                  value.isEmpty ? AppLocalizations.current.noInfo : value,
                  color: AppColors.baseColor,
                  fontSize: AppDimens.SIZE_14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
