import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/auth/auth_cubit.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';
import 'package:sotaynamduoc/injection_container.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

class ConfirmPinScreen extends StatelessWidget {
  final String email;
  final String phone;

  const ConfirmPinScreen({super.key, required this.email, required this.phone});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => AuthCubit(repository: getIt.get<AuthRepository>()),
      child: ConfirmPinBody(email: email, phone: phone),
    );
  }
}

class ConfirmPinBody extends StatefulWidget {
  final String email;
  final String phone;

  const ConfirmPinBody({super.key, required this.email, required this.phone});

  @override
  _ConfirmPinBodyState createState() => _ConfirmPinBodyState();
}

class _ConfirmPinBodyState extends State<ConfirmPinBody> {
  final List<TextEditingController> _pinControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  String _pinCode = '';

  @override
  void initState() {
    super.initState();
    _setupFocusListeners();
  }

  void _setupFocusListeners() {
    for (int i = 0; i < 4; i++) {
      _pinControllers[i].addListener(() {
        if (_pinControllers[i].text.length == 1) {
          if (i < 3) {
            _focusNodes[i + 1].requestFocus();
          } else {
            _focusNodes[i].unfocus();
          }
        }
      });

      _focusNodes[i].addListener(() {
        if (!_focusNodes[i].hasFocus && _pinControllers[i].text.isEmpty) {
          if (i > 0) {
            _focusNodes[i - 1].requestFocus();
          }
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _pinControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _updatePinCode() {
    setState(() {
      _pinCode = _pinControllers.map((controller) => controller.text).join();
    });
  }

  void _verifyPin() {
    if (_pinCode.length == 4) {
      // TODO: Gọi API xác thực mã PIN
      BlocProvider.of<AuthCubit>(
        context,
      ).verifyPin(email: widget.email, pin: _pinCode);
    }
  }

  void _resendPin() {
    BlocProvider.of<AuthCubit>(context).resendPin(email: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, BaseState>(
      listener: (context, state) {
        if (state is LoadedState) {
          // Kiểm tra xem đây có phải là response từ resendPin không
          if (state.data != null && state.data.toString().contains('resend')) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Mã PIN mới đã được gửi!'),
                backgroundColor: Colors.green,
              ),
            );
          } else {
            // Xác thực thành công
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Xác thực thành công!'),
                backgroundColor: Colors.green,
              ),
            );
            // Chuyển về trang đăng nhập hoặc trang chính
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text((state).data ?? 'Thao tác thất bại!'),
              backgroundColor: Colors.red,
            ),
          );
          // Xóa mã PIN khi xác thực thất bại
          for (var controller in _pinControllers) {
            controller.clear();
          }
          _focusNodes[0].requestFocus();
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

                    _buildPinInputs(),
                    SizedBox(height: AppDimens.SIZE_32),

                    _buildVerifyButton(),
                    SizedBox(height: AppDimens.SIZE_24),

                    _buildResendButton(),
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
        // Icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.baseColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.email_outlined,
            size: 40,
            color: AppColors.baseColor,
          ),
        ),
        SizedBox(height: AppDimens.SIZE_24),

        // Title
        CustomTextLabel(
          'Xác thực tài khoản',
          fontSize: AppDimens.SIZE_24,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
        ),
        SizedBox(height: AppDimens.SIZE_12),

        // Description
        CustomTextLabel(
          'Chúng tôi đã gửi mã PIN 4 chữ số đến:',
          fontSize: AppDimens.SIZE_16,
          fontWeight: FontWeight.w500,
          color: AppColors.textMediumGrey,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppDimens.SIZE_8),

        CustomTextLabel(
          widget.email,
          fontSize: AppDimens.SIZE_16,
          fontWeight: FontWeight.w600,
          color: AppColors.baseColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPinInputs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return Container(
          width: 60,
          height: 60,
          child: TextFormField(
            controller: _pinControllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: TextStyle(
              fontSize: AppDimens.SIZE_24,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
                borderSide: BorderSide(
                  color: AppColors.inputBorderLight,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
                borderSide: BorderSide(
                  color: AppColors.inputBorderLight,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
                borderSide: BorderSide(color: AppColors.baseColor, width: 2),
              ),
              filled: true,
              fillColor: AppColors.white,
            ),
            onChanged: (value) {
              _updatePinCode();
              if (value.length == 1 && index < 3) {
                _focusNodes[index + 1].requestFocus();
              }
            },
            onTap: () {
              _pinControllers[index].selection = TextSelection.fromPosition(
                TextPosition(offset: _pinControllers[index].text.length),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildVerifyButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _pinCode.length == 4
            ? AppColors.baseColor
            : AppColors.inputBorderLight,
        foregroundColor: _pinCode.length == 4
            ? AppColors.white
            : AppColors.textMediumGrey,
        padding: EdgeInsets.symmetric(vertical: AppDimens.SIZE_16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
        ),
      ),
      child: CustomTextLabel(
        'Xác thực',
        fontSize: AppDimens.SIZE_16,
        fontWeight: FontWeight.w600,
        color: _pinCode.length == 4
            ? AppColors.white
            : AppColors.textMediumGrey,
      ),
      onPressed: _pinCode.length == 4 ? _verifyPin : null,
    );
  }

  Widget _buildResendButton() {
    return TextButton(
      onPressed: _resendPin,
      child: CustomTextLabel(
        'Gửi lại mã PIN',
        fontSize: AppDimens.SIZE_14,
        fontWeight: FontWeight.w600,
        color: AppColors.baseColor,
      ),
    );
  }

  Widget _buildBackToLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextLabel(
          'Đã có tài khoản? ',
          fontSize: AppDimens.SIZE_14,
          fontWeight: FontWeight.w500,
          color: AppColors.textMediumGrey,
        ),
        InkWell(
          onTap: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          child: CustomTextLabel(
            'Đăng nhập',
            fontSize: AppDimens.SIZE_14,
            fontWeight: FontWeight.w600,
            color: AppColors.baseColor,
          ),
        ),
      ],
    );
  }
}
