import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/blocs/base_list_cubit.dart';
import 'package:sotaynamduoc/blocs/utils.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';

class HerbalCubit extends BaseListCubit<BaseState> {
  final HerbalRepository repository;

  HerbalCubit({required this.repository}) : super(InitState());

  Future<void> getHerbals({
    String? search,
    String? categoryId,
    String? scientificName,
    String? family,
    bool? isActive,
    bool isRefresh = false,
  }) async {
    try {
      if (isRefresh) {
        setDefaultConfig(null);
        emit(LoadingState());
      } else if (state is! LoadingState) {
        emit(LoadingState());
      }

      Map requestParams = getDataRequest({
        if (search != null && search.isNotEmpty) 'search': search,
        if (categoryId != null) 'categoryId': categoryId,
        if (scientificName != null) 'scientificName': scientificName,
        if (family != null) 'family': family,
        if (isActive != null) 'isActive': isActive,
      });

      List<HerbalModel> herbals = await repository.getHerbals(
        page: requestParams['pageNum'],
        limit: requestParams['pageSize'],
        search: search,
        categoryId: categoryId,
        scientificName: scientificName,
        family: family,
        isActive: isActive,
      );

      if (herbals.isEmpty) {
        setEndOfPage();
      } else {
        increasePageNum();
      }

      List<HerbalModel> currentList = getListDataCurrent<HerbalModel>();
      List<HerbalModel> newList = isRefresh ? herbals : [...currentList, ...herbals];
      
      emit(LoadedState(newList));
      finishLoad();
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
      finishLoad();
    }
  }

  Future<void> getHerbalById(String id) async {
    try {
      emit(LoadingState());
      HerbalModel herbal = await repository.getHerbalById(id);
      emit(LoadedState(herbal));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  Future<void> getHerbalsByCategory(String categoryId) async {
    try {
      emit(LoadingState());
      List<HerbalModel> herbals = await repository.getHerbalsByCategory(categoryId);
      emit(LoadedState(herbals));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  Future<void> getHerbalsByScientificName(String scientificName) async {
    try {
      emit(LoadingState());
      List<HerbalModel> herbals = await repository.getHerbalsByScientificName(scientificName);
      emit(LoadedState(herbals));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  Future<void> getHerbalsByFamily(String family) async {
    try {
      emit(LoadingState());
      List<HerbalModel> herbals = await repository.getHerbalsByFamily(family);
      emit(LoadedState(herbals));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  Future<void> incrementViewCount(String id) async {
    try {
      await repository.incrementViewCount(id);
      // Update the herbal in the list
      List<HerbalModel> currentList = getListDataCurrent<HerbalModel>();
      int index = currentList.indexWhere((herbal) => herbal.id == id);
      if (index != -1) {
        currentList[index].viewCount = (currentList[index].viewCount ?? 0) + 1;
        emit(LoadedState(currentList));
      }
    } catch (e) {
      // Silently handle error for view count increment
    }
  }

  Future<void> incrementLikeCount(String id) async {
    try {
      await repository.incrementLikeCount(id);
      // Update the herbal in the list
      List<HerbalModel> currentList = getListDataCurrent<HerbalModel>();
      int index = currentList.indexWhere((herbal) => herbal.id == id);
      if (index != -1) {
        currentList[index].likeCount = (currentList[index].likeCount ?? 0) + 1;
        emit(LoadedState(currentList));
      }
    } catch (e) {
      // Silently handle error for like count increment
    }
  }

  void clearState() {
    emit(InitState());
  }
} 