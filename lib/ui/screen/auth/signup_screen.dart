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
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text((state).data ?? 'Đăng ký thất bại!'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is LoadingState) {
          CustomSnackBar<AuthCubit>(fontSize: 16).build(context);
        }
      },
      child: BaseScreen(
        loadingWidget: SizedBox.shrink(),
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations.current.plsInputFullName;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppDimens.SIZE_16),
                      // Email
                      CustomTextInput(
                        textController: _emailController,
                        obscureText: false,
                        hintText: AppLocalizations.current.email,
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimens.SIZE_16,
                        borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations.current.plsInputEmail;
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return AppLocalizations.current.emailInvalid;
                          }
                          return null;
                        },
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations.current.plsInputPhoneNumber;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppDimens.SIZE_16),

                      // Tên đăng nhập
                      CustomTextInput(
                        textController: _usernameController,
                        obscureText: false,
                        hintText: AppLocalizations.current.userName,
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimens.SIZE_16,
                        borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations.current.plsInputUserName;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppDimens.SIZE_16),

                      // Mật khẩu
                      CustomTextInput(
                        textController: _passwordController,
                        obscureText: true,
                        hintText: AppLocalizations.current.password,
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimens.SIZE_16,
                        borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations.current.plsInputPassword;
                          }
                          if (value.length < 6) {
                            return AppLocalizations.current.passwordMin;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppDimens.SIZE_16),

                      // Xác nhận mật khẩu
                      CustomTextInput(
                        textController: _confirmPasswordController,
                        obscureText: true,
                        hintText: AppLocalizations.current.confirmPassword,
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimens.SIZE_16,
                        borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations
                                .current
                                .plsInputConfirmPassword;
                          }
                          if (value != _passwordController.text) {
                            return AppLocalizations.current.passwordNotMatch;
                          }
                          return null;
                        },
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
                          if (_formKey.currentState!.validate()) {
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations
                                    .current
                                    .googleRegistrationComingSoon,
                              ),
                            ),
                          );
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AppLocalizations
                                    .current
                                    .facebookRegistrationComingSoon,
                              ),
                            ),
                          );
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
      height: 48,
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
            SvgPicture.asset(iconPath, width: 20, height: 20),
            SizedBox(width: AppDimens.SIZE_12),
            CustomTextLabel(
              text,
              fontSize: AppDimens.SIZE_16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
