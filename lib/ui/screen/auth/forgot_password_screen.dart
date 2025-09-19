import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/auth/auth_cubit.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';
import 'package:sotaynamduoc/injection_container.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/ui/screen/auth/confirm_pin_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => AuthCubit(repository: getIt.get<AuthRepository>()),
      child: const _ForgotPasswordBody(),
    );
  }
}

class _ForgotPasswordBody extends StatefulWidget {
  const _ForgotPasswordBody();

  @override
  State<_ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<_ForgotPasswordBody> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendCode() {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text.trim();
    BlocProvider.of<AuthCubit>(context).resendPin(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, BaseState>(
      listener: (context, state) {
        if (state is LoadedState) {
          // On successful send, go to confirm pin
          final email = _emailController.text.trim();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ConfirmPinScreen(email: email, phone: ''),
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.SIZE_24),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildHeader(),
                    SizedBox(height: AppDimens.SIZE_32),
                    _buildForm(),
                    SizedBox(height: AppDimens.SIZE_24),
                    _buildSendButton(),
                    SizedBox(height: AppDimens.SIZE_24),
                    _buildBackToLogin(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.baseColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.lock_reset, size: 40, color: AppColors.baseColor),
        ),
        SizedBox(height: AppDimens.SIZE_24),
        CustomTextLabel(
          AppLocalizations.current.forgotPassword,
          fontSize: AppDimens.SIZE_24,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
        ),
        SizedBox(height: AppDimens.SIZE_12),
        // Optional helper text
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextInput(
            textController: _emailController,
            hintText: 'email@example.com',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icon(
              Icons.email_outlined,
              color: AppColors.textMediumGrey,
            ),
            validator: (value) {
              final v = (value ?? '').trim();
              if (v.isEmpty) return AppLocalizations.current.plsInputEmail;
              final emailRegex = RegExp(r'^\S+@\S+\.\S+$');
              if (!emailRegex.hasMatch(v))
                return AppLocalizations.current.emailInvalid;
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.baseColor,
        foregroundColor: AppColors.white,
        padding: EdgeInsets.symmetric(vertical: AppDimens.SIZE_16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
        ),
      ),
      onPressed: _sendCode,
      child: CustomTextLabel(
        AppLocalizations.current.resend,
        fontSize: AppDimens.SIZE_16,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
    );
  }

  Widget _buildBackToLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextLabel(
          AppLocalizations.current.back,
          fontSize: AppDimens.SIZE_14,
          fontWeight: FontWeight.w500,
          color: AppColors.textMediumGrey,
        ),
        InkWell(
          onTap: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          child: CustomTextLabel(
            AppLocalizations.current.login,
            fontSize: AppDimens.SIZE_14,
            fontWeight: FontWeight.w600,
            color: AppColors.baseColor,
          ),
        ),
      ],
    );
  }
}
