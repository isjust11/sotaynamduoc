import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base.dart';
import 'package:sotaynamduoc/blocs/utils.dart';
import 'package:sotaynamduoc/domain/repositories/user_interaction_repository.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';

class UserInteractionCubit extends Cubit<BaseState> {
  bool isLiked = false;
  bool isBookmarked = false;
  bool hasTrackedBookmark = false;
  int viewCount = 0;
  int likeCount = 0;
  bool hasTrackedView = false;
  final UserInteractionRepository repository;
  UserInteractionCubit({required this.repository}) : super(InitState());

  // like
  void like({required String targetType, required dynamic targetId}) async {
    try {
      emit(LoadingUserInteractionState());
      final response = await repository.like(
        targetType: targetType,
        targetId: targetId,
      );
      isLiked = true;
      likeCount++;
      emit(LoadedUserInteractionState(response));
    } catch (e) {
      emit(ErrorUserInteractionState(BlocUtils.getMessageError(e)));
    }
  }

  // unlike
  void unlike({required String targetType, required dynamic targetId}) async {
    try {
      emit(LoadingUserInteractionState());
      await repository.unlike(targetType: targetType, targetId: targetId);
      isLiked = false;
      likeCount = (likeCount - 1).clamp(0, double.infinity).toInt();
      emit(LoadedUserInteractionState(null));
    } catch (e) {
      emit(ErrorUserInteractionState(BlocUtils.getMessageError(e)));
    }
  }

  void bookmark({required String targetType, required dynamic targetId}) async {
    try {
      emit(LoadingUserInteractionState());
      final response = await repository.bookmark(
        targetType: targetType,
        targetId: targetId,
      );
      isBookmarked = true;
      emit(LoadedUserInteractionState(response));
    } catch (e) {
      emit(ErrorUserInteractionState(BlocUtils.getMessageError(e)));
    }
  }

  void unbookmark({
    required String targetType,
    required dynamic targetId,
  }) async {
    try {
      emit(LoadingUserInteractionState());
      await repository.unbookmark(targetType: targetType, targetId: targetId);
      isBookmarked = false;
      emit(LoadedUserInteractionState(null));
    } catch (e) {
      emit(ErrorUserInteractionState(BlocUtils.getMessageError(e)));
    }
  }

  void share({
    required String targetType,
    required dynamic targetId,
    String? platform,
  }) async {
    try {
      emit(LoadingUserInteractionState());
      final response = await repository.share(
        targetType: targetType,
        targetId: targetId,
        sharePlatform: platform,
      );
      emit(LoadedUserInteractionState(response));
    } catch (e) {
      emit(ErrorUserInteractionState(BlocUtils.getMessageError(e)));
    }
  }

  void view({required String targetType, required dynamic targetId}) async {
    // Avoid tracking view multiple times
    if (hasTrackedView) return;

    try {
      // emit(LoadingUserInteractionState());
      await repository.view(targetType: targetType, targetId: targetId);
      // Increment view count locally
      viewCount++;
      hasTrackedView = true;
      // emit(LoadedUserInteractionState(response));
    } catch (e) {
      // emit(ErrorUserInteractionState(BlocUtils.getMessageError(e)));
    }
  }

  void rate({
    required String targetType,
    required dynamic targetId,
    required int rating,
  }) async {
    try {
      emit(LoadingUserInteractionState());
      final response = await repository.rate(
        targetType: targetType,
        targetId: targetId,
        rating: rating,
      );
      emit(LoadedUserInteractionState(response));
    } catch (e) {
      emit(ErrorUserInteractionState(BlocUtils.getMessageError(e)));
    }
  }

  void follow({required String targetType, required dynamic targetId}) async {
    try {
      emit(LoadingUserInteractionState());
      final response = await repository.follow(
        targetType: targetType,
        targetId: targetId,
      );
      emit(LoadedUserInteractionState(response));
    } catch (e) {
      emit(ErrorUserInteractionState(BlocUtils.getMessageError(e)));
    }
  }

  void unfollow({required String targetType, required dynamic targetId}) async {
    try {
      emit(LoadingUserInteractionState());
      await repository.unfollow(targetType: targetType, targetId: targetId);
      emit(LoadedUserInteractionState(null));
    } catch (e) {
      emit(ErrorUserInteractionState(BlocUtils.getMessageError(e)));
    }
  }

  void getStatus({
    required String targetType,
    required dynamic targetId,
  }) async {
    try {
      emit(LoadingUserInteractionState());
      final response = await repository.getStatus(
        targetType: targetType,
        targetId: targetId,
      );
      isLiked = response != null && response['like'] == true;
      emit(LoadedUserInteractionState(response));
    } catch (e) {
      emit(ErrorUserInteractionState(BlocUtils.getMessageError(e)));
    }
  }

  void getStats({required String targetType, required dynamic targetId}) async {
    try {
      emit(LoadingInteractionStatsState());
      final response = await repository.getStats(
        targetType: targetType,
        targetId: targetId,
      );
      emit(LoadedInteractionStatsState(response));
    } catch (e) {
      emit(ErrorInteractionStatsState(BlocUtils.getMessageError(e)));
    }
  }

  void getMyInteractions({Map<String, dynamic>? query}) async {
    try {
      emit(LoadingUserInteractionState());
      final response = await repository.getMyInteractions(query: query);
      emit(LoadedUserInteractionState(response));
    } catch (e) {
      emit(ErrorUserInteractionState(BlocUtils.getMessageError(e)));
    }
  }

  void initInteraction({
    required bool isView,
    required bool isLiked,
    required bool isBookmarked,
  }) {
    this.isLiked = isLiked;
    this.isBookmarked = isBookmarked;
  }

  // Reset state when switching to different target
  void resetState() {
    isLiked = false;
    isBookmarked = false;
    viewCount = 0;
    likeCount = 0;
    hasTrackedView = false;
    hasTrackedBookmark = false;
    emit(InitState());
  }
}
