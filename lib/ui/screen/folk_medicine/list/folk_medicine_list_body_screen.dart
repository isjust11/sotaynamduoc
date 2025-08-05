import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/blocs/cubit.dart';
import 'package:sotaynamduoc/blocs/folk_medicine/folk_medicine_event.dart';
import 'package:sotaynamduoc/blocs/folk_medicine/folk_medicine_state.dart';
import 'package:sotaynamduoc/domain/data/models/folk_medicine_model.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/ui/screen/screen.dart';
import 'package:sotaynamduoc/ui/widget/card_item.dart';
import 'package:sotaynamduoc/ui/widget/custom_text_label.dart';

class FolkMedicineListBodyScreen extends StatefulWidget {
  final String categoryId;

  const FolkMedicineListBodyScreen({super.key, required this.categoryId});

  @override
  State<FolkMedicineListBodyScreen> createState() =>
      _FolkMedicineListBodyScreenState();
}

class _FolkMedicineListBodyScreenState
    extends State<FolkMedicineListBodyScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    context.read<FolkMedicineBloc>().add(
      LoadFolkMedicineList(categoryId: widget.categoryId),
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _isDisposed = true;
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isDisposed) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final folkMedicineBloc = context.read<FolkMedicineBloc>();
      if (!_isDisposed) {
        folkMedicineBloc.loadMore();
      }
    }
  }

  void _addBlocEvent(FolkMedicineEvent event) {
    if (!_isDisposed) {
      context.read<FolkMedicineBloc>().add(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FolkMedicineBloc, FolkMedicineState>(
      builder: (context, state) {
        if (state is FolkMedicineLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FolkMedicineListLoaded) {
          return _buildFolkMedicineList(state);
        } else if (state is FolkMedicineEmpty) {
          return _buildEmptyState(state.message);
        } else if (state is FolkMedicineError) {
          return _buildErrorState(state.message);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildFolkMedicineList(FolkMedicineListLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        _addBlocEvent(RefreshFolkMedicine(categoryId: widget.categoryId));
      },
      child: ListView.separated(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.SIZE_16,
          vertical: AppDimens.SIZE_4,
        ),
        itemCount:
            state.folkMedicineList.length +
            (state.isLoadingMore ? 1 : 0) +
            (!state.hasMore && state.folkMedicineList.isNotEmpty ? 1 : 0),
        separatorBuilder: (context, index) {
          if (index >= state.folkMedicineList.length) {
            return const SizedBox.shrink();
          }
          return SizedBox(height: AppDimens.SIZE_12);
        },
        itemBuilder: (context, index) {
          if (index == state.folkMedicineList.length && state.isLoadingMore) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: AppDimens.SIZE_12),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (index == state.folkMedicineList.length &&
              !state.hasMore &&
              state.folkMedicineList.isNotEmpty &&
              state.folkMedicineList.length > 10) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: AppDimens.SIZE_24),
              child: Center(
                child: CustomTextLabel(
                  AppLocalizations.current.endOfList,
                  fontSize: AppDimens.SIZE_14,
                  color: AppColors.textDark,
                ),
              ),
            );
          }

          if (index < state.folkMedicineList.length) {
            return _buildFolkMedicineItem(
              context,
              state.folkMedicineList[index],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildFolkMedicineItem(
    BuildContext context,
    FolkMedicineModel folkMedicine,
  ) {
    return CardItem(
      onTap: () => _navigateToDetail(context, folkMedicine),
      title: folkMedicine.title ?? '',
      thumbnail: folkMedicine.thumbnail,
      createdAt: folkMedicine.createdAt,
      summary: folkMedicine.summary,
    );
  }

  Widget _buildEmptyState(String message) {
    return RefreshIndicator(
      onRefresh: () async {
        _addBlocEvent(RefreshFolkMedicine(categoryId: widget.categoryId));
      },
      child: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          Center(
            child: Column(
              children: [
                SvgPicture.asset(
                  Assets.icons.icFolderEmpty,
                  width: 64.sw,
                  height: 64.sw,
                  colorFilter: ColorFilter.mode(
                    AppColors.textDark.withValues(alpha: 0.6),
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(height: AppDimens.SIZE_16),
                CustomTextLabel(
                  message,
                  fontSize: AppDimens.SIZE_16,
                  color: AppColors.textDark.withValues(alpha: 0.6),
                ),
                SizedBox(height: AppDimens.SIZE_8),
                CustomTextLabel(
                  'Kéo xuống để làm mới',
                  fontSize: AppDimens.SIZE_14,
                  color: AppColors.textDark.withValues(alpha: 0.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return RefreshIndicator(
      onRefresh: () async {
        _addBlocEvent(RefreshFolkMedicine(categoryId: widget.categoryId));
      },
      child: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64.sw,
                  color: AppColors.errorRed,
                ),
                SizedBox(height: AppDimens.SIZE_16),
                CustomTextLabel(
                  'Có lỗi xảy ra',
                  fontSize: AppDimens.SIZE_16,
                  color: AppColors.errorRed,
                ),
                SizedBox(height: AppDimens.SIZE_8),
                CustomTextLabel(
                  message,
                  fontSize: AppDimens.SIZE_14,
                  color: AppColors.textDark.withValues(alpha: 0.6),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppDimens.SIZE_16),
                ElevatedButton(
                  onPressed: () {
                    _addBlocEvent(
                      RefreshFolkMedicine(categoryId: widget.categoryId),
                    );
                  },
                  child: const Text('Thử lại'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetail(BuildContext context, FolkMedicineModel folkMedicine) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FolkMedicineDetailScreen(folkMedicine: folkMedicine),
      ),
    );
  }
}
