import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/domain/data/models/user_model.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/ui/widget/base_screen.dart';
import 'package:sotaynamduoc/ui/widget/custom_text_label.dart';
import 'package:sotaynamduoc/routes.dart';
import 'package:sotaynamduoc/blocs/cubit.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getProfile();
  }

  void _onLogout() async {
    await context.read<AuthCubit>().doLogout();
    if (!mounted) return;
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        hideAppBar: true,
        colorBg: AppColors.lightBackground,
        body: _buildLayoutSection(context),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {
    return BlocBuilder<AuthCubit, BaseState>(
      bloc: context.read<AuthCubit>(),
      builder: (context, state) {
        UserModel? user;
        if (state is LoadedState) {
          user = state.data;
        } else if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorState) {
          return Center(child: Text(state.data.toString()));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(user),
            const SizedBox(height: 24),
            _buildLanguageSection(context),
             const SizedBox(height: 24),
            _buildThemeSection(context),
            const Spacer(),
            _buildLogoutButton(context),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }

  Widget _buildHeader(UserModel? user) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      color: AppColors.white,
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: AppColors.secondaryBrand,
            backgroundImage:
                (user?.picture != null && user!.picture!.isNotEmpty)
                ? NetworkImage(user.picture!)
                : null,
            child: (user?.picture == null || user!.picture!.isEmpty)
                ? Image.asset(Assets.icons.icAvatar)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextLabel(
                  user?.fullName ?? user?.username ?? '---',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.colorTitle,
                ),
                const SizedBox(height: 4),
                CustomTextLabel(
                  user?.username ?? '',
                  fontSize: 14,
                  color: AppColors.textMediumGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextLabel(
            AppLocalizations.of(context).changeLanguage,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          BlocBuilder<LanguageCubit, String>(
            builder: (context, lang) {
              return DropdownButton<String>(
                value: lang,
                items: const [
                  DropdownMenuItem(value: 'vi', child: Text('Tiếng Việt')),
                  DropdownMenuItem(value: 'en', child: Text('English')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    context.read<LanguageCubit>().changeLanguage(value);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSection(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextLabel(
            AppLocalizations.of(context).theme,
            fontWeight: FontWeight.w600,  
            fontSize: 16,
          ),
          const SizedBox(width: 16),
          DropdownButton<String>(
            value: context.read<ThemeCubit>().state,
            items: const [
              DropdownMenuItem(value: 'light', child: Text('Light')),
              DropdownMenuItem(value: 'dark', child: Text('Dark')),
            ], onChanged: (String? value) { 
            if(value != null){
              context.read<ThemeCubit>().changeTheme(value);
            }              
             },
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryBrand,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.logout, color: Colors.white),
        label: Text(
          AppLocalizations.of(context).logout,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: _onLogout,
      ),
    );
  }
}
