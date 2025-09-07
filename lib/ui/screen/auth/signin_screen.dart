import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/auth/auth_cubit.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';
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
              padding: EdgeInsets.symmetric(horizontal: AppDimens.SIZE_16),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CustomTextLabel(
                        AppLocalizations.current.login,
                        fontSize: AppDimens.SIZE_24,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 48.0),
                      CustomTextInput(
                        textController: _usernameController,
                        obscureText: true,
                        hintText: 'Tên đăng nhập',
                      ),
                      SizedBox(height: 48.0),
                      ElevatedButton(
                        child: Text('Đăng nhập'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).doLogin(
                              userName: _usernameController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 48.0),
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
