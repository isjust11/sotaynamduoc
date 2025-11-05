import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base.dart';
import 'package:sotaynamduoc/blocs/utils.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';

class CategoryCubit extends Cubit<BaseState> {
  final CategoryRepository repository;

  CategoryCubit({required this.repository}) : super(InitState());

  Future getCategories({
    String? categoryTypeCode,
    String? sortBy,
    String? sortType,
  }) async {
    try {
      emit(LoadingState());
      List<CategoryModel> categories = await repository
          .getCategoriesByCategoryTypeCode(
            categoryTypeCode ?? "",
            sortBy,
            sortType,
          );
      if (categories.isEmpty) {
        emit(EmptyState());
      } else {
        emit(LoadedState(categories));
      }
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }
}
