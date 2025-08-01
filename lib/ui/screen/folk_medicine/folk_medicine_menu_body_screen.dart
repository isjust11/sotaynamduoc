import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/blocs/cubit.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/ui/screen/screen.dart';
import 'package:sotaynamduoc/ui/widget/custom_text_label.dart';

class FolkMedicineMenuBodyScreen extends StatefulWidget {
  const FolkMedicineMenuBodyScreen({super.key});

  @override
  State<FolkMedicineMenuBodyScreen> createState() => _FolkMedicineMenuBodyScreenState();
}

class _FolkMedicineMenuBodyScreenState extends State<FolkMedicineMenuBodyScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getCategories(
      categoryTypeCode: 'FolkMedicine',
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<CategoryCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadedState<List<CategoryModel>>) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: AppDimens.SIZE_8,
              crossAxisSpacing: AppDimens.SIZE_8,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.SIZE_8,
              vertical: AppDimens.SIZE_8,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              return _buildItem(state.data[index]);
            },
          );
        }
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ErrorState) {
          return Center(child: Text(state.data.toString()));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildItem(CategoryModel category) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => FolkMedicineListScreen(categoryId: category.id ?? '')));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.SIZE_8,
          vertical: AppDimens.SIZE_12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: category.icon != ''
                  ? Image.network(category.icon ?? "")
                  : SvgPicture.asset(
                      Assets.icons.icBaithuoc,
                      fit: BoxFit.contain,
                      colorFilter: const ColorFilter.mode(AppColors.secondaryBrand, BlendMode.srcIn),
                      width: AppDimens.SIZE_40,
                      height: AppDimens.SIZE_40,
                    ),
            ),
            const SizedBox(height: AppDimens.SIZE_8),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomTextLabel(
                    category.name ?? "",
                    fontSize: AppDimens.SIZE_12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  ),
                  const SizedBox(height: AppDimens.SIZE_4),
                  CustomTextLabel(
                    category.description ?? "",
                    fontSize: AppDimens.SIZE_10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
