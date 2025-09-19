import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sotaynamduoc/blocs/auth/auth_cubit.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
import 'package:sotaynamduoc/injection_container.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/ui/screen/auth/confirm_pin_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => AuthCubit(repository: getIt.get<AuthRepository>()),
      child: SignUpBody(),
    );
  }
}

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final GlobalKey<TextFieldState> _emailFieldKey = GlobalKey<TextFieldState>();
  final GlobalKey<TextFieldState> _usernameFieldKey =
      GlobalKey<TextFieldState>();
  final GlobalKey<TextFieldState> _passwordFieldKey =
      GlobalKey<TextFieldState>();
  final GlobalKey<TextFieldState> _confirmPasswordFieldKey =
      GlobalKey<TextFieldState>();

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, BaseState>(
      listener: (context, state) {
        if (state is LoadedState) {
          // Đăng ký thành công, chuyển đến trang xác thực mã PIN
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmPinScreen(
                email: _emailController.text,
                phone: _phoneController.text,
              ),
            ),
          );
        }
      },
      child: BaseScreen(
        loadingWidget: CustomLoading<AuthCubit>(
          size: AppDimens.SIZE_32,
          loadingType: LoadingType.threeArchedCircle,
          message: AppLocalizations.current.loading,
          backgroundColor: Colors.black.withValues(alpha: 0.4),
          indicatorColor: AppColors.baseColor,
        ),
        messageNotify: CustomSnackBar<AuthCubit>(),
        hideAppBar: true,
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
                      _buildSignUpLabel(),
                      SizedBox(height: AppDimens.SIZE_32),

                      // Họ và tên
                      CustomTextInput(
                        textController: _fullNameController,
                        obscureText: false,
                        hintText: AppLocalizations.current.fullName,
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimens.SIZE_16,
                        borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
                        validator: _validateFullName,
                      ),
                      SizedBox(height: AppDimens.SIZE_16),
                      // Email
                      CustomTextInput(
                        textController: _emailController,
                        key: _emailFieldKey,
                        obscureText: false,
                        isRequired: true,
                        hintText: AppLocalizations.current.email,
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimens.SIZE_16,
                        borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                      ),
                      SizedBox(height: AppDimens.SIZE_16),

                      // Số điện thoại
                      CustomTextInput(
                        textController: _phoneController,
                        obscureText: false,
                        hintText: AppLocalizations.current.phoneNumber,
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimens.SIZE_16,
                        borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
                        keyboardType: TextInputType.phone,
                        validator: _validatePhoneNumber,
                      ),
                      SizedBox(height: AppDimens.SIZE_16),

                      // Tên đăng nhập
                      CustomTextInput(
                        textController: _usernameController,
                        obscureText: false,
                        key: _usernameFieldKey,
                        validator: _validateUsername,
                        isRequired: true,
                        hintText: AppLocalizations.current.userName,
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimens.SIZE_16,
                        borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
                      ),
                      SizedBox(height: AppDimens.SIZE_16),

                      // Mật khẩu
                      CustomTextInput(
                        textController: _passwordController,
                        obscureText: true,
                        key: _passwordFieldKey,
                        hintText: AppLocalizations.current.password,
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimens.SIZE_16,
                        borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
                        validator: _validatePassword,
                        isRequired: true,
                      ),
                      SizedBox(height: AppDimens.SIZE_16),

                      // Xác nhận mật khẩu
                      CustomTextInput(
                        key: _confirmPasswordFieldKey,
                        textController: _confirmPasswordController,
                        obscureText: true,
                        hintText: AppLocalizations.current.confirmPassword,
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimens.SIZE_16,
                        borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
                        validator: _validateConfirmPassword,
                      ),
                      SizedBox(height: AppDimens.SIZE_24),

                      // Nút đăng ký
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
                          AppLocalizations.current.register,
                          fontSize: AppDimens.SIZE_16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                        onPressed: () async {
                          bool isUsernameValid =
                              _usernameFieldKey.currentState?.isValid ?? false;
                          bool isPasswordValid =
                              _passwordFieldKey.currentState?.isValid ?? false;
                          bool isConfirmPasswordValid =
                              _confirmPasswordFieldKey.currentState?.isValid ??
                              false;

                          if (isUsernameValid &&
                              isPasswordValid &&
                              isConfirmPasswordValid) {
                            BlocProvider.of<AuthCubit>(context).doRegister(
                              fullName: _fullNameController.text,
                              email: _emailController.text,
                              phone: _phoneController.text,
                              userName: _usernameController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                      ),
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

                      // Nút đăng ký Google
                      _buildSocialRegisterButton(
                        text: AppLocalizations.current.registerWithGoogle,
                        backgroundColor: AppColors.white,
                        textColor: AppColors.textDark,
                        borderColor: AppColors.inputBorderLight,
                        iconPath: Assets.icons.icGoogle,
                        onPressed: () {
                          context.read<AuthCubit>().doGoogleLogin();
                        },
                      ),
                      SizedBox(height: AppDimens.SIZE_12),

                      // Nút đăng ký Facebook
                      _buildSocialRegisterButton(
                        text: AppLocalizations.current.registerWithFacebook,
                        backgroundColor: Color.fromARGB(255, 38, 93, 164),
                        textColor: AppColors.white,
                        borderColor: Color.fromARGB(255, 6, 38, 77),
                        iconPath: Assets.icons.icFacebook,
                        onPressed: () {
                          context.read<AuthCubit>().doFacebookLogin();
                        },
                      ),
                      SizedBox(height: AppDimens.SIZE_24),

                      // Link đăng nhập
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextLabel(
                            AppLocalizations.current.alreadyHaveAccount,
                            fontSize: AppDimens.SIZE_14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textMediumGrey,
                          ),
                          SizedBox(width: AppDimens.SIZE_4),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: CustomTextLabel(
                              AppLocalizations.current.login,
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

  Widget _buildSignUpLabel() {
    return Center(
      child: CustomTextLabel(
        AppLocalizations.current.register,
        fontSize: AppDimens.SIZE_32,
        fontWeight: FontWeight.w700,
        color: AppColors.baseColor,
      ),
    );
  }

  Widget _buildSocialRegisterButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required Color borderColor,
    required String iconPath,
    required VoidCallback onPressed,
  }) {
    return Container(
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

  // Validation methods
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.current.plsInputUserName;
    }

    if (value.length < 3) {
      return AppLocalizations.current.usernameMin;
    }

    if (value.length > 20) {
      return AppLocalizations.current.usernameMax;
    }

    // Check for valid characters: letters, numbers, dots, underscores, hyphens
    if (!RegExp(r'^[a-zA-Z0-9._-]+$').hasMatch(value)) {
      return AppLocalizations.current.usernameSpecial;
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.current.plsInputPassword;
    }

    if (value.length < 6) {
      return AppLocalizations.current.passwordMin;
    }

    if (value.length > 20) {
      return AppLocalizations.current.passwordMax;
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.current.plsInputConfirmPassword;
    }
    if (value != _passwordController.text) {
      return AppLocalizations.current.passwordNotMatch;
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.current.plsInputPhoneNumber;
    }

    // Remove all non-digit characters for validation
    String cleanPhone = value.replaceAll(RegExp(r'[^\d]'), '');

    // Check if phone number has valid length (10-11 digits for Vietnamese phone numbers)
    if (cleanPhone.length < 10 || cleanPhone.length > 11) {
      return 'Số điện thoại phải có từ 10-11 chữ số';
    }

    // Check if phone number starts with valid Vietnamese prefixes
    if (!RegExp(r'^(0[3|5|7|8|9])').hasMatch(cleanPhone)) {
      return 'Số điện thoại không hợp lệ';
    }

    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.current.plsInputEmail;
    }
    if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(value)) {
      return AppLocalizations.current.emailInvalid;
    }
    return null;
  }

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.current.plsInputFullName;
    }

    // Trim whitespace and check minimum length
    String trimmedValue = value.trim();
    if (trimmedValue.length < 2) {
      return 'Họ và tên phải có ít nhất 2 ký tự';
    }

    if (trimmedValue.length > 50) {
      return 'Họ và tên không được quá 50 ký tự';
    }

    // Check if name contains only letters, spaces, and Vietnamese characters
    if (!RegExp(
      r'^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂÂÊÔưăâêô\s]+$',
    ).hasMatch(trimmedValue)) {
      return 'Họ và tên chỉ được chứa chữ cái và khoảng trắng';
    }

    return null;
  }
}
