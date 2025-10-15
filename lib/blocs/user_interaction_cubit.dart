import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base.dart';
import 'package:sotaynamduoc/blocs/utils.dart';
import 'package:sotaynamduoc/domain/repositories/user_interaction_repository.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';

class UserInteractionCubit extends Cubit<BaseState> {
  bool isLiked = false;
  int viewCount = 0;
  int likeCount = 0;
  bool hasTrackedView = false;
  final UserInteractionRepository repository;
  UserInteractionCubit({required this.repository}) : super(InitState());

  // like
  void like({required String targetType, required dynamic targetId}) async {
    try {
      emit(LoadingState());
      final response = await repository.like(
        targetType: targetType,
        targetId: targetId,
      );
      isLiked = true;
      likeCount++;
      emit(LoadedState(response));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  // unlike
  void unlike({required String targetType, required dynamic targetId}) async {
    try {
      emit(LoadingState());
      await repository.unlike(targetType: targetType, targetId: targetId);
      isLiked = false;
      likeCount = (likeCount - 1).clamp(0, double.infinity).toInt();
      emit(LoadedState(null));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  void bookmark({required String targetType, required dynamic targetId}) async {
    try {
      emit(LoadingState());
      final response = await repository.bookmark(
        targetType: targetType,
        targetId: targetId,
      );
      emit(LoadedState(response));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  void unbookmark({
    required String targetType,
    required dynamic targetId,
  }) async {
    try {
      emit(LoadingState());
      await repository.unbookmark(targetType: targetType, targetId: targetId);
      emit(LoadedState(null));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  void share({
    required String targetType,
    required dynamic targetId,
    String? platform,
  }) async {
    try {
      emit(LoadingState());
      final response = await repository.share(
        targetType: targetType,
        targetId: targetId,
        sharePlatform: platform,
      );
      emit(LoadedState(response));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  void view({required String targetType, required dynamic targetId}) async {
    // Avoid tracking view multiple times
    if (hasTrackedView) return;

    try {
      emit(LoadingState());
      final response = await repository.view(
        targetType: targetType,
        targetId: targetId,
      );
      // Increment view count locally
      viewCount++;
      hasTrackedView = true;
      emit(LoadedState(response));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  void rate({
    required String targetType,
    required dynamic targetId,
    required int rating,
  }) async {
    try {
      emit(LoadingState());
      final response = await repository.rate(
        targetType: targetType,
        targetId: targetId,
        rating: rating,
      );
      emit(LoadedState(response));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  void follow({required String targetType, required dynamic targetId}) async {
    try {
      emit(LoadingState());
      final response = await repository.follow(
        targetType: targetType,
        targetId: targetId,
      );
      emit(LoadedState(response));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  void unfollow({required String targetType, required dynamic targetId}) async {
    try {
      emit(LoadingState());
      await repository.unfollow(targetType: targetType, targetId: targetId);
      emit(LoadedState(null));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  void getStatus({
    required String targetType,
    required dynamic targetId,
  }) async {
    try {
      emit(LoadingState());
      final response = await repository.getStatus(
        targetType: targetType,
        targetId: targetId,
      );
      isLiked = response != null && response['like'] == true;
      emit(LoadedState(response));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  void getStats({required String targetType, required dynamic targetId}) async {
    try {
      emit(LoadingState());
      final response = await repository.getStats(
        targetType: targetType,
        targetId: targetId,
      );
      viewCount = response.viewCount ?? 0;
      likeCount = response.likeCount ?? 0;
      emit(LoadedState(response));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  void getMyInteractions({Map<String, dynamic>? query}) async {
    try {
      emit(LoadingState());
      final response = await repository.getMyInteractions(query: query);
      emit(LoadedState(response));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  // Reset state when switching to different target
  void resetState() {
    isLiked = false;
    viewCount = 0;
    likeCount = 0;
    hasTrackedView = false;
    emit(InitState());
  }
}
