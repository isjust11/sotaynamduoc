import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/auth/login_cubit.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/injection_container.dart';
import 'package:sotaynamduoc/routes.dart';
import 'package:sotaynamduoc/screen/components/form_input_field_with_icon.dart';
import 'package:sotaynamduoc/screen/components/logo_graphic_header.dart';
import 'package:sotaynamduoc/screen/components/form_vertical_spacing.dart';
import 'package:sotaynamduoc/screen/components/primary_button.dart';
import 'package:sotaynamduoc/screen/components/label_button.dart';
import 'package:sotaynamduoc/helpers/validator.dart';
import 'package:sotaynamduoc/ui/widget/custom_snack_bar.dart';
import 'package:sotaynamduoc/ui/widget/base_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => LoginCubit(repository: getIt.get<AuthRepository>()),
      child: LoginBody(),
    );
  }
}

class LoginBody extends StatefulWidget {
  LoginBody({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginBody> {
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
    return BlocListener<LoginCubit, BaseState>(
      listener: (context, state) {
        if (state is LoadedState) {
          // Đăng nhập thành công, chuyển sang màn hình chính hoặc hiển thị thông báo
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Đăng nhập thành công!')));
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                (state as ErrorState).data ?? 'Đăng nhập thất bại!',
              ),
            ),
          );
        }
      },
      child: BaseScreen(
        loadingWidget: SizedBox.shrink(),
        messageNotify: CustomSnackBar<LoginCubit>(),
        title: AppLocalizations.current.appName,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.background.image().image,
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      LogoGraphicHeader(),
                      SizedBox(height: 48.0),
                      FormInputFieldWithIcon(
                        controller: _usernameController,
                        iconPrefix: Icons.person,
                        labelText: AppLocalizations.current.userName,
                        validator: Validator().username,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {},
                        onSaved: (value) {},
                      ),
                      FormVerticalSpace(),
                      FormInputFieldWithIcon(
                        controller: _passwordController,
                        iconPrefix: Icons.lock,
                        labelText: 'Mật khẩu',
                        validator: Validator().password,
                        obscureText: true,
                        onChanged: (value) {},
                        onSaved: (value) {},
                        maxLines: 1,
                      ),
                      FormVerticalSpace(),
                      PrimaryButton(
                        labelText: AppLocalizations.current.login,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<LoginCubit>(context).doLogin(
                              userName: _usernameController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                      ),
                      FormVerticalSpace(),
                      LabelButton(
                        labelText: 'Quên mật khẩu?',
                        onPressed: () {
                          Navigator.pushNamed(context, '/reset-password');
                        },
                      ),
                      LabelButton(
                        labelText: 'Đăng ký',
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                      ),
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
}
