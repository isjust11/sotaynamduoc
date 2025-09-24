import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/domain/data/models/user_model.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/ui/widget/base_screen.dart';
import 'package:sotaynamduoc/ui/widget/custom_text_label.dart';
import 'package:sotaynamduoc/routes.dart';
import 'package:sotaynamduoc/blocs/cubit.dart';
import 'package:sotaynamduoc/services/biometric_auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:sotaynamduoc/services/biometric_test_helper.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _notificationsEnabled = true;
  bool _biometricEnabled = false;
  bool _biometricAvailable = false;

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getProfile();
    _loadBiometricStatus();
  }

  Future<void> _loadBiometricStatus() async {
    final capability = await BiometricAuthService.checkBiometricCapability();
    final enabled = await BiometricAuthService.isBiometricEnabledInApp();

    setState(() {
      _biometricAvailable = capability == BiometricCapability.available;
      _biometricEnabled = enabled;
    });
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
              const SizedBox(height: AppDimens.SIZE_12),
              _buildQuickActions(),
              const SizedBox(height: AppDimens.SIZE_12),
              _buildSettingsSection(context),
              const SizedBox(height: AppDimens.SIZE_12),
              _buildSupportSection(),
              const SizedBox(height: AppDimens.SIZE_12),
              _buildLogoutButton(context),
              const SizedBox(height: AppDimens.SIZE_12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(UserModel? user) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.SIZE_18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondaryBrand,
            AppColors.secondaryBrand.withValues(alpha: 0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryBrand.withValues(alpha: 0.3),
            blurRadius: AppDimens.SIZE_20,
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
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: AppDimens.SIZE_10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: AppDimens.SIZE_30,
              backgroundColor: AppColors.statusTextLight,
              backgroundImage:
                  (user?.picture != null && user!.picture!.isNotEmpty)
                  ? NetworkImage(user.picture!)
                  : null,
              child: SvgPicture.asset(
                (user?.picture == null || user!.picture!.isEmpty)
                    ? Assets.icons.icAvatar
                    : user.picture!,
                width: AppDimens.SIZE_30,
                height: AppDimens.SIZE_30,
              ),
            ),
          ),
          const SizedBox(width: AppDimens.SIZE_20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextLabel(
                  user?.fullName ?? user?.username ?? '---',
                  fontWeight: FontWeight.bold,
                  fontSize: AppDimens.SIZE_18,
                  color: AppColors.white,
                ),
                const SizedBox(height: 6),
                CustomTextLabel(
                  user?.username ?? '',
                  fontSize: AppDimens.SIZE_14,
                  color: AppColors.white.withValues(alpha: 0.9),
                ),
                const SizedBox(height: AppDimens.SIZE_8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.SIZE_12),
      child: Row(
        children: [
          Expanded(
            child: _buildQuickActionCard(
              icon: Icons.edit,
              title: AppLocalizations.current.editProfile,
              subtitle: AppLocalizations.current.updateYourInfo,
              color: Colors.blue,
              onTap: () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildQuickActionCard(
              icon: Icons.security,
              title: AppLocalizations.current.security,
              subtitle: AppLocalizations.current.privacySettings,
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
        padding: const EdgeInsets.all(AppDimens.SIZE_12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: AppDimens.SIZE_10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimens.SIZE_12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
              ),
              child: Icon(icon, color: color, size: AppDimens.SIZE_24),
            ),
            const SizedBox(height: AppDimens.SIZE_12),
            CustomTextLabel(
              title,
              fontWeight: FontWeight.w600,
              fontSize: AppDimens.SIZE_14,
              color: AppColors.colorTitle,
            ),
            const SizedBox(height: AppDimens.SIZE_4),
            CustomTextLabel(
              subtitle,
              fontSize: AppDimens.SIZE_12,
              color: AppColors.textMediumGrey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.SIZE_12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.SIZE_20),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.05),
            blurRadius: AppDimens.SIZE_10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSettingItem(
            icon: Icons.language,
            title: AppLocalizations.current.language,
            subtitle: AppLocalizations.current.changeAppLanguage,
            trailing: _buildLanguageDropdown(context),
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.palette,
            title: AppLocalizations.current.theme,
            subtitle: AppLocalizations.current.chooseAppAppearance,
            trailing: _buildThemeDropdown(context),
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.notifications,
            title: AppLocalizations.current.notifications,
            subtitle: AppLocalizations.current.manageNotifications,
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              activeThumbColor: AppColors.secondaryBrand,
            ),
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.fingerprint,
            title: AppLocalizations.current.biometricLogin,
            subtitle: _getBiometricSubtitle(),
            trailing: Switch(
              value: _biometricEnabled,
              onChanged: _biometricAvailable ? _onBiometricToggle : null,
              activeThumbColor: AppColors.secondaryBrand,
            ),
          ),
          // Debug section chỉ hiển thị trong debug mode
          if (kDebugMode) ...[
            _buildDivider(),
            _buildSettingItem(
              icon: Icons.bug_report,
              title: 'Debug: Test Secure Storage',
              subtitle:
                  'Test flutter_secure_storage and biometric capabilities',
              trailing: IconButton(
                icon: Icon(Icons.play_arrow, color: AppColors.secondaryBrand),
                onPressed: () async {
                  await BiometricTestHelper.runAllTests();
                  _showSuccessMessage(
                    'Debug test completed. Check console logs.',
                  );
                },
              ),
            ),
          ],
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
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSettingItem(
            icon: Icons.help_outline,
            title: AppLocalizations.current.helpCenter,
            subtitle: AppLocalizations.current.getHelpAndSupport,
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.feedback,
            title: AppLocalizations.current.sendFeedback,
            subtitle: AppLocalizations.current.shareYourThoughts,
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.info_outline,
            title: AppLocalizations.current.aboutApp,
            subtitle: AppLocalizations.current.version,
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
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
      borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.SIZE_20,
          vertical: AppDimens.SIZE_12,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimens.SIZE_8),
              decoration: BoxDecoration(
                color: AppColors.secondaryBrand.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColors.secondaryBrand,
                size: AppDimens.SIZE_20,
              ),
            ),
            const SizedBox(width: AppDimens.SIZE_16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextLabel(
                    title,
                    fontWeight: FontWeight.w600,
                    fontSize: AppDimens.SIZE_16,
                    color: AppColors.colorTitle,
                  ),
                  const SizedBox(height: 2),
                  CustomTextLabel(
                    subtitle,
                    fontSize: AppDimens.SIZE_14,
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
      color: Colors.grey.withValues(alpha: 0.2),
    );
  }

  Widget _buildLanguageDropdown(BuildContext context) {
    return BlocBuilder<LanguageCubit, String>(
      builder: (context, lang) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.SIZE_12),
          decoration: BoxDecoration(
            color: AppColors.secondaryBrand.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.secondaryBrand.withValues(alpha: 0.3),
            ),
          ),
          child: DropdownButton<String>(
            value: lang,
            underline: const SizedBox(),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.secondaryBrand,
            ),
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
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.SIZE_12),
      decoration: BoxDecoration(
        color: AppColors.secondaryBrand.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.secondaryBrand.withValues(alpha: 0.3),
        ),
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
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.SIZE_12),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade400,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(AppDimens.SIZE_50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
          ),
          elevation: 0,
          shadowColor: Colors.red.withValues(alpha: 0.3),
        ),
        icon: const Icon(Icons.logout, size: AppDimens.SIZE_24),
        label: Text(
          AppLocalizations.current.logout,
          style: const TextStyle(
            fontSize: AppDimens.SIZE_16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: _onLogout,
      ),
    );
  }

  String _getBiometricSubtitle() {
    if (!_biometricAvailable) {
      return AppLocalizations.current.biometricNotAvailable;
    }
    return AppLocalizations.current.useFingerprintOrFaceID;
  }

  Future<void> _onBiometricToggle(bool value) async {
    if (value) {
      _showBiometricSetupDialog();
    } else {
      _disableBiometric();
    }
  }

  void _showBiometricSetupDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.fingerprint,
                color: AppColors.secondaryBrand,
                size: AppDimens.SIZE_24,
              ),
              SizedBox(width: AppDimens.SIZE_8),
              Expanded(
                child: CustomTextLabel(
                  AppLocalizations.current.setupBiometric,
                  fontSize: AppDimens.SIZE_18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.colorTitle,
                ),
              ),
            ],
          ),
          content: CustomTextLabel(
            AppLocalizations.current.setupBiometricDesc,
            fontSize: AppDimens.SIZE_14,
            color: AppColors.textMediumGrey,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: CustomTextLabel(
                AppLocalizations.current.cancel,
                fontSize: AppDimens.SIZE_14,
                fontWeight: FontWeight.w600,
                color: AppColors.textMediumGrey,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryBrand,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await _enableBiometric();
              },
              child: CustomTextLabel(
                AppLocalizations.current.setup,
                fontSize: AppDimens.SIZE_14,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _enableBiometric() async {
    try {
      final authCubit = context.read<AuthCubit>();

      // Kiểm tra xem có thông tin đăng nhập đã lưu không
      final credentials = await BiometricAuthService.getStoredCredentials();

      if (credentials == null) {
        // Hiển thị dialog để nhập thông tin đăng nhập
        _showCredentialsDialog();
        return;
      }

      // Bật sinh trắc học với thông tin đăng nhập hiện có
      await authCubit.toggleBiometric(true);

      setState(() {
        _biometricEnabled = true;
      });

      _showSuccessMessage(AppLocalizations.current.biometricSetupSuccess);
    } catch (e) {
      _showErrorMessage(e.toString());
    }
  }

  void _showCredentialsDialog() {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomTextLabel(
            AppLocalizations.current.enterCredentials,
            fontSize: AppDimens.SIZE_18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorTitle,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.current.userName,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: AppDimens.SIZE_16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.current.password,
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: CustomTextLabel(
                AppLocalizations.current.cancel,
                fontSize: AppDimens.SIZE_14,
                fontWeight: FontWeight.w600,
                color: AppColors.textMediumGrey,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryBrand,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
                ),
              ),
              onPressed: () async {
                final username = usernameController.text.trim();
                final password = passwordController.text.trim();

                if (username.isEmpty || password.isEmpty) {
                  _showErrorMessage(
                    AppLocalizations.current.pleaseEnterCredentials,
                  );
                  return;
                }

                Navigator.of(context).pop();
                await _setupBiometricWithCredentials(username, password);
              },
              child: CustomTextLabel(
                AppLocalizations.current.setup,
                fontSize: AppDimens.SIZE_14,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _setupBiometricWithCredentials(
    String username,
    String password,
  ) async {
    try {
      final authCubit = context.read<AuthCubit>();
      await authCubit.toggleBiometric(
        true,
        username: username,
        password: password,
      );

      setState(() {
        _biometricEnabled = true;
      });

      _showSuccessMessage(AppLocalizations.current.biometricSetupSuccess);
    } catch (e) {
      _showErrorMessage(e.toString());
    }
  }

  Future<void> _disableBiometric() async {
    try {
      final authCubit = context.read<AuthCubit>();
      await authCubit.toggleBiometric(false);

      setState(() {
        _biometricEnabled = false;
      });

      _showSuccessMessage(AppLocalizations.current.biometricDisabled);
    } catch (e) {
      _showErrorMessage(e.toString());
    }
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomTextLabel(message, color: AppColors.white),
        backgroundColor: AppColors.successGreen,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomTextLabel(message, color: AppColors.white),
        backgroundColor: AppColors.errorRed,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
