import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/auth/auth_cubit.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/blocs/news/news.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/screen/home/home_body.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? user;
  
  void _navigateToNotificationList(BuildContext context) {
    Navigator.pushNamed(context, Routes.newsListScreen);
  }

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      onBackPress: null,
      body: HomeBody(),
      floatingButton: null,
      bottomNavigationBar: null,
      hiddenIconBack: true,
      customAppBar: BaseAppBar(
        title: '',
        showBackButton: false,
        customTitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
              BlocBuilder<AuthCubit, BaseState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return SizedBox(
                      width: AppDimens.SIZE_40,
                      height: AppDimens.SIZE_40,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                      ),
                    );
                  } else if (state is ErrorState) {
                    return CircleAvatar(
                      radius: AppDimens.SIZE_20,
                      backgroundColor: AppColors.inputBorderLight,
                      child: Icon(Icons.error, color: AppColors.white, size: AppDimens.SIZE_20),
                    );
                  }
                  final user = state is LoadedState ? state.data : null;
                  if (user?.picture == null) {
                    return CircleAvatar(
                      radius: AppDimens.SIZE_20,
                      backgroundColor: AppColors.inputBorderLight,
                      child: Icon(Icons.person, color: AppColors.white, size: AppDimens.SIZE_20),
                    );
                  }
                  return CircleAvatar(
                    radius: AppDimens.SIZE_20,
                    backgroundColor: AppColors.inputBorderLight,
                    child: ClipOval(
                      child: Image.network(
                        user.picture ?? '',
                        width: AppDimens.SIZE_40,
                        height: AppDimens.SIZE_40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.person, color: AppColors.white, size: AppDimens.SIZE_20);
                        },
                      ),
                    ),
                  );
                }
              ),
              SizedBox(width: AppDimens.SIZE_10),
              BlocBuilder<AuthCubit, BaseState>(
                builder: (context, state) {
                  final user = state is LoadedState ? state.data : null;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextLabel(AppLocalizations.current.hello, color: AppColors.white, fontSize: AppDimens.SIZE_12, fontWeight: FontWeight.w400),
                      SizedBox(height: AppDimens.SIZE_4),
                      CustomTextLabel(
                        user?.fullName ?? user?.username ?? 'Guest',
                        color: AppColors.white,
                        fontSize: AppDimens.SIZE_16,
                        fontWeight: FontWeight.w500
                      ),
                    ],
                  );
                }
              )
            ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _navigateToNotificationList(context);
            },
            
            icon: Icon(Icons.notifications_none, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}