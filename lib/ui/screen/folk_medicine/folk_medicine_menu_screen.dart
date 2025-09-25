import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base.dart';
import 'package:sotaynamduoc/blocs/cubit.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/ui/screen/folk_medicine/folk_medicine_menu_body_screen.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

class FolkMedicineMenuScreen extends StatelessWidget {
  const FolkMedicineMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      stateWidget: CustomLoading<CategoryCubit>(
        loadingType: LoadingType.threeArchedCircle,
        loadingState: (state) => state is LoadingState,
        errorState: (state) => state is ErrorState,
        onRefresh: () => context.read<CategoryCubit>().getCategories(
          categoryTypeCode: 'FolkMedicine',
        ),
        message: context.read<CategoryCubit>().state is LoadingState
            ? AppLocalizations.current.loading
            : context.read<CategoryCubit>().state is ErrorState
            ? (context.read<CategoryCubit>().state as ErrorState).data
                  .toString()
            : AppLocalizations.current.empty,
      ),
      customAppBar: BaseAppBar(
        title: AppLocalizations.current.featuredMedicine.toUpperCase(),
        showBackButton: false,
        backgroundColor: AppColors.secondaryBrand,
      ),
      body: FolkMedicineMenuBodyScreen(),
    );
  }
}
