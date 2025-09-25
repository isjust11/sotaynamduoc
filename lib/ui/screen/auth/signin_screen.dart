import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sotaynamduoc/blocs/auth/auth_cubit.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';
import 'package:sotaynamduoc/routes.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/injection_container.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/services/biometric_auth_service.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => AuthCubit(repository: getIt.get<AuthRepository>()),
      child: SignInBody(),
    );
  }
}

class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  final GlobalKey<TextFieldState> _usernameFieldKey =
      GlobalKey<TextFieldState>();
  final GlobalKey<TextFieldState> _passwordFieldKey =
      GlobalKey<TextFieldState>();
  bool _biometricAvailable = false;
  bool _biometricEnabled = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    final capability = await BiometricAuthService.checkBiometricCapability();
    final enabled = await BiometricAuthService.isBiometricEnabledInApp();

    setState(() {
      _biometricAvailable = capability == BiometricCapability.available;
      _biometricEnabled = enabled;
    });
  }

  // Hàm validation cho username
  String? _validateUsername(String value) {
    if (value.isEmpty) {
      return AppLocalizations.current.pleaseEnterUsername;
    }
    if (value.length < 3) {
      return AppLocalizations.current.usernameMin;
    }
    if (value.length > 20) {
      return AppLocalizations.current.usernameMax;
    }
    // Kiểm tra ký tự đặc biệt không được phép
    if (!RegExp(r'^[a-zA-Z0-9._-]+$').hasMatch(value)) {
      return AppLocalizations.current.usernameSpecial;
    }
    return null;
  }

  // Hàm validation cho password
  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return AppLocalizations.current.pleaseEnterPassword;
    }
    if (value.length < 6) {
      return AppLocalizations.current.passwordMin;
    }
    if (value.length > 20) {
      return AppLocalizations.current.passwordMax;
    }
    return null;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, BaseState>(
      listener: (context, state) {
        if (state is LoadedState) {
          Navigator.pushReplacementNamed(context, Routes.mainScreen);
        }
      },
      child: BaseScreen(
        loadingWidget: CustomLoading<AuthCubit>(
          loadingType: LoadingType.threeArchedCircle,
          message: AppLocalizations.current.loading,
          backgroundColor: Colors.black.withValues(alpha: 0.4),
          indicatorColor: AppColors.baseColor,
          size: AppDimens.SIZE_32,
        ),
        messageNotify: CustomSnackBar<AuthCubit>(),
        hideAppBar: true,
        // title: AppLocalizations.current.appName,
        body: Container(
          decoration: BoxDecoration(color: AppColors.white),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimens.SIZE_24),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildLoginLabel(),
                      SizedBox(height: AppDimens.SIZE_40),
                      CustomTextInput(
                        prefixIcon: SvgPicture.asset(
                          Assets.icons.icEmail,
                          width: AppDimens.SIZE_20,
                          height: AppDimens.SIZE_20,
                          color: AppColors.textMediumGrey,
                        ),
                        key: _usernameFieldKey,
                        textController: _usernameController,
                        obscureText: false,
                        hintText: AppLocalizations.current.userName,
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimens.SIZE_16,
                        borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
                        validator: _validateUsername,
                        isRequired: true,
                      ),
                      SizedBox(height: AppDimens.SIZE_16),
                      CustomTextInput(
                        prefixIcon: SvgPicture.asset(
                          Assets.icons.icLockPassword,
                          width: AppDimens.SIZE_20,
                          height: AppDimens.SIZE_20,
                          color: AppColors.textMediumGrey,
                        ),
                        key: _passwordFieldKey,
                        textController: _passwordController,
                        obscureText: true,
                        hintText: AppLocalizations.current.password,
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimens.SIZE_16,
                        borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
                        validator: _validatePassword,
                        isRequired: true,
                      ),
                      SizedBox(height: AppDimens.SIZE_12),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.forgotPasswordScreen,
                          );
                        },
                        child: CustomTextLabel(
                          AppLocalizations.current.forgotPassword,
                          fontSize: AppDimens.SIZE_16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.baseColor,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      SizedBox(height: AppDimens.SIZE_16),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.baseColor,
                          foregroundColor: AppColors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: AppDimens.SIZE_14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimens.SIZE_16,
                            ),
                          ),
                        ),
                        child: CustomTextLabel(
                          AppLocalizations.current.login,
                          fontSize: AppDimens.SIZE_16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                        onPressed: () async {
                          // Kiểm tra validation của các trường input
                          bool isUsernameValid =
                              _usernameFieldKey.currentState?.isValid ?? false;
                          bool isPasswordValid =
                              _passwordFieldKey.currentState?.isValid ?? false;

                          if (isUsernameValid && isPasswordValid) {
                            final authCubit = BlocProvider.of<AuthCubit>(
                              context,
                            );
                            await authCubit.doLogin(
                              userName: _usernameController.text.trim(),
                              password: _passwordController.text.trim(),
                            );

                            // Nếu đăng nhập thành công và sinh trắc học khả dụng, lưu thông tin
                            if (authCubit.state is LoadedState &&
                                _biometricAvailable) {
                              _showBiometricSetupDialog();
                            }
                          }
                        },
                      ),
                      SizedBox(height: AppDimens.SIZE_16),

                      // Nút đăng nhập sinh trắc học
                      if (_biometricAvailable && _biometricEnabled)
                        _buildBiometricLoginButton(),

                      if (_biometricAvailable && _biometricEnabled)
                        SizedBox(height: AppDimens.SIZE_24),

                      // Divider với text "hoặc"
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.dividerGrey,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppDimens.SIZE_16,
                            ),
                            child: CustomTextLabel(
                              AppLocalizations.current.or,
                              fontSize: AppDimens.SIZE_14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textMediumGrey,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColors.dividerGrey,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppDimens.SIZE_24),

                      // Nút đăng nhập Google
                      _buildSocialLoginButton(
                        text: AppLocalizations.current.loginWithGoogle,
                        backgroundColor: AppColors.white,
                        textColor: AppColors.textDark,
                        borderColor: AppColors.inputBorderLight,
                        iconPath: Assets.icons.icGoogle,
                        onPressed: () {
                          context.read<AuthCubit>().doGoogleLogin();
                        },
                      ),
                      SizedBox(height: AppDimens.SIZE_12),

                      // Nút đăng nhập Facebook
                      _buildSocialLoginButton(
                        text: AppLocalizations.current.loginWithFacebook,
                        backgroundColor: Color.fromARGB(
                          255,
                          38,
                          93,
                          164,
                        ), // Facebook blue
                        textColor: AppColors.white,
                        borderColor: Color.fromARGB(255, 6, 38, 77),
                        iconPath: Assets.icons.icFacebook,
                        onPressed: () {
                          context.read<AuthCubit>().doFacebookLogin();
                        },
                      ),
                      SizedBox(height: AppDimens.SIZE_24),

                      // Nút đăng ký
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextLabel(
                            AppLocalizations.current.dontHaveAccount,
                            fontSize: AppDimens.SIZE_14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textMediumGrey,
                          ),
                          SizedBox(width: AppDimens.SIZE_4),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.signupScreen);
                            },
                            child: CustomTextLabel(
                              AppLocalizations.current.register,
                              fontSize: AppDimens.SIZE_14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.baseColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppDimens.SIZE_16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLabel() {
    return Center(
      child: CustomTextLabel(
        AppLocalizations.current.login,
        fontSize: AppDimens.SIZE_32,
        fontWeight: FontWeight.w700,
        color: AppColors.baseColor,
      ),
    );
  }

  Widget _buildSocialLoginButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required Color borderColor,
    required String iconPath,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: AppDimens.SIZE_48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          side: BorderSide(color: borderColor, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SVG Icon
            SvgPicture.asset(
              iconPath,
              width: AppDimens.SIZE_20,
              height: AppDimens.SIZE_20,
            ),
            SizedBox(width: AppDimens.SIZE_12),
            CustomTextLabel(
              text,
              fontSize: AppDimens.SIZE_14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBiometricLoginButton() {
    return SizedBox(
      height: AppDimens.SIZE_48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryBrand,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
          ),
          elevation: 2,
        ),
        onPressed: () {
          context.read<AuthCubit>().doBiometricLogin();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fingerprint,
              size: AppDimens.SIZE_20,
              color: AppColors.white,
            ),
            SizedBox(width: AppDimens.SIZE_12),
            CustomTextLabel(
              AppLocalizations.current.loginWithBiometric,
              fontSize: AppDimens.SIZE_14,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }

  void _showBiometricSetupDialog() {
    if (!_biometricEnabled) {
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
                  AppLocalizations.current.skip,
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
                  await _setupBiometric();
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
  }

  Future<void> _setupBiometric() async {
    if (!mounted) return;

    try {
      final authCubit = context.read<AuthCubit>();
      await authCubit.toggleBiometric(
        true,
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!mounted) return;

      setState(() {
        _biometricEnabled = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomTextLabel(
            AppLocalizations.current.biometricSetupSuccess,
            color: AppColors.white,
          ),
          backgroundColor: AppColors.successGreen,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomTextLabel(e.toString(), color: AppColors.white),
          backgroundColor: AppColors.errorRed,
        ),
      );
    }
  }
}
