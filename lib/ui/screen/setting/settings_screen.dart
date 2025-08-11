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
  bool _notificationsEnabled = true;
  bool _biometricEnabled = false;
  bool _autoBackup = true;

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
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(user),
              const SizedBox(height: 24),
              _buildQuickActions(),
              const SizedBox(height: 24),
              _buildSettingsSection(context),
              const SizedBox(height: 24),
              _buildAccountSection(context),
              const SizedBox(height: 24),
              _buildSupportSection(),
              const SizedBox(height: 24),
              _buildLogoutButton(context),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(UserModel? user) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondaryBrand,
            AppColors.secondaryBrand.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryBrand.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              backgroundImage:
                  (user?.picture != null && user!.picture!.isNotEmpty)
                  ? NetworkImage(user.picture!)
                  : null,
              child: (user?.picture == null || user!.picture!.isEmpty)
                  ? Image.asset(Assets.icons.icAvatar, width: 40, height: 40)
                  : null,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextLabel(
                  user?.fullName ?? user?.username ?? '---',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,
                ),
                const SizedBox(height: 6),
                CustomTextLabel(
                  user?.username ?? '',
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const CustomTextLabel(
                    'Premium Member',
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildQuickActionCard(
              icon: Icons.edit,
              title: 'Edit Profile',
              subtitle: 'Update your info',
              color: Colors.blue,
              onTap: () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildQuickActionCard(
              icon: Icons.security,
              title: 'Security',
              subtitle: 'Privacy settings',
              color: Colors.green,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            CustomTextLabel(
              title,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.colorTitle,
            ),
            const SizedBox(height: 4),
            CustomTextLabel(
              subtitle,
              fontSize: 12,
              color: AppColors.textMediumGrey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSectionHeader('App Settings', Icons.settings),
          _buildSettingItem(
            icon: Icons.language,
            title: 'Language',
            subtitle: 'Change app language',
            trailing: _buildLanguageDropdown(context),
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.palette,
            title: 'Theme',
            subtitle: 'Choose app appearance',
            trailing: _buildThemeDropdown(context),
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Manage notifications',
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              activeColor: AppColors.secondaryBrand,
            ),
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.fingerprint,
            title: 'Biometric Login',
            subtitle: 'Use fingerprint or face ID',
            trailing: Switch(
              value: _biometricEnabled,
              onChanged: (value) {
                setState(() {
                  _biometricEnabled = value;
                });
              },
              activeColor: AppColors.secondaryBrand,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSectionHeader('Account', Icons.person),
          _buildSettingItem(
            icon: Icons.backup,
            title: 'Auto Backup',
            subtitle: 'Backup data automatically',
            trailing: Switch(
              value: _autoBackup,
              onChanged: (value) {
                setState(() {
                  _autoBackup = value;
                });
              },
              activeColor: AppColors.secondaryBrand,
            ),
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.storage,
            title: 'Storage',
            subtitle: 'Manage app storage',
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.history,
            title: 'Activity History',
            subtitle: 'View your activity',
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSupportSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSectionHeader('Support', Icons.help),
          _buildSettingItem(
            icon: Icons.help_outline,
            title: 'Help Center',
            subtitle: 'Get help and support',
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.feedback,
            title: 'Send Feedback',
            subtitle: 'Share your thoughts',
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.info_outline,
            title: 'About App',
            subtitle: 'Version 1.0.0',
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.secondaryBrand.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.secondaryBrand, size: 20),
          ),
          const SizedBox(width: 12),
          CustomTextLabel(
            title,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.colorTitle,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.secondaryBrand.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColors.secondaryBrand, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextLabel(
                    title,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.colorTitle,
                  ),
                  const SizedBox(height: 2),
                  CustomTextLabel(
                    subtitle,
                    fontSize: 14,
                    color: AppColors.textMediumGrey,
                  ),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 1,
      color: Colors.grey.withOpacity(0.2),
    );
  }

  Widget _buildLanguageDropdown(BuildContext context) {
    return BlocBuilder<LanguageCubit, String>(
      builder: (context, lang) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.secondaryBrand.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.secondaryBrand.withOpacity(0.3)),
          ),
          child: DropdownButton<String>(
            value: lang,
            underline: const SizedBox(),
            icon: Icon(Icons.keyboard_arrow_down, color: AppColors.secondaryBrand),
            items: const [
              DropdownMenuItem(value: 'vi', child: Text('Tiếng Việt')),
              DropdownMenuItem(value: 'en', child: Text('English')),
            ],
            onChanged: (value) {
              if (value != null) {
                context.read<LanguageCubit>().changeLanguage(value);
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildThemeDropdown(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.secondaryBrand.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.secondaryBrand.withOpacity(0.3)),
      ),
      child: DropdownButton<String>(
        value: context.read<ThemeCubit>().state,
        underline: const SizedBox(),
        icon: Icon(Icons.keyboard_arrow_down, color: AppColors.secondaryBrand),
        items: const [
          DropdownMenuItem(value: 'light', child: Text('Light')),
          DropdownMenuItem(value: 'dark', child: Text('Dark')),
        ],
        onChanged: (String? value) {
          if (value != null) {
            context.read<ThemeCubit>().changeTheme(value);
          }
        },
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade400,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          shadowColor: Colors.red.withOpacity(0.3),
        ),
        icon: const Icon(Icons.logout, size: 24),
        label: Text(
          AppLocalizations.current.logout,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: _onLogout,
      ),
    );
  }
}
