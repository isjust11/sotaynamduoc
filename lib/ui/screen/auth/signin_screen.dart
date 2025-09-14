import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sotaynamduoc/blocs/auth/auth_cubit.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/injection_container.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

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

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
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
          // Đăng nhập thành công, chuyển sang màn hình chính hoặc hiển thị thông báo
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: CustomSnackBar<AuthCubit>().build(context)),
          );
          Navigator.pushReplacementNamed(context, '/mainScreen');
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text((state).data ?? 'Đăng nhập thất bại!')),
          );
        } else if (state is LoadingState) {
          CustomSnackBar<AuthCubit>(fontSize: 16).build(context);
        }
      },
      child: BaseScreen(
        loadingWidget: SizedBox.shrink(),
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
                        textController: _usernameController,
                        obscureText: false,
                        hintText: AppLocalizations.current.userName,
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimens.SIZE_16,
                        borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
                      ),
                      SizedBox(height: AppDimens.SIZE_16),
                      CustomTextInput(
                        textController: _passwordController,
                        obscureText: true,
                        hintText: AppLocalizations.current.password,
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimens.SIZE_16,
                        borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
                      ),
                      SizedBox(height: AppDimens.SIZE_12),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<AuthCubit>(context).doForgotPassword(
                            userName: _usernameController.text,
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
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).doLogin(
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

                      // Nút đăng nhập Google
                      _buildSocialLoginButton(
                        text: AppLocalizations.current.loginWithGoogle,
                        backgroundColor: AppColors.white,
                        textColor: AppColors.textDark,
                        borderColor: AppColors.inputBorderLight,
                        iconPath: Assets.icons.icGoogle,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Google login - Coming soon!'),
                            ),
                          );
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Facebook login - Coming soon!'),
                            ),
                          );
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
                              Navigator.pushNamed(context, '/signupScreen');
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
