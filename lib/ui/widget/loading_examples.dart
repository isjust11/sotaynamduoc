import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/news/news.dart';
import 'package:sotaynamduoc/blocs/auth/auth_cubit.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base.dart';
import 'package:sotaynamduoc/ui/widget/base_loading.dart';

/// Ví dụ sử dụng CustomBlocLoading với NewsBloc
class NewsLoadingExample extends StatelessWidget {
  const NewsLoadingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Loading Example')),
      body: Stack(
        children: [
          // Nội dung chính của màn hình
          const Center(child: Text('Nội dung màn hình tin tức')),

          // CustomBlocLoading cho NewsBloc
          CustomBlocLoading<NewsBloc, NewsState>(
            loadingState: (state) => state is NewsLoading,
            message: 'Đang tải tin tức...',
            loadingType: LoadingType.bouncingBall,
            backgroundColor: Colors.black.withOpacity(0.5),
            indicatorColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

/// Ví dụ sử dụng CustomBlocLoading với AuthCubit
class AuthLoadingExample extends StatelessWidget {
  const AuthLoadingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth Loading Example')),
      body: Stack(
        children: [
          // Nội dung chính của màn hình
          const Center(child: Text('Nội dung màn hình đăng nhập')),

          // CustomBlocLoading cho AuthCubit
          CustomBlocLoading<AuthCubit, BaseState>(
            loadingState: (state) => state is LoadingState,
            message: 'Đang xử lý đăng nhập...',
            loadingType: LoadingType.waveDots,
            backgroundColor: Colors.black.withOpacity(0.3),
            indicatorColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

/// Ví dụ sử dụng CustomLoading cũ (tương thích ngược)
class LegacyLoadingExample extends StatelessWidget {
  const LegacyLoadingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Legacy Loading Example')),
      body: Stack(
        children: [
          // Nội dung chính của màn hình
          const Center(child: Text('Nội dung màn hình')),

          // CustomLoading cũ vẫn hoạt động bình thường
          CustomLoading<AuthCubit>(
            message: 'Đang tải dữ liệu...',
            loadingType: LoadingType.threeRotatingDots,
          ),
        ],
      ),
    );
  }
}

/// Ví dụ sử dụng với các loại loading khác nhau
class LoadingTypesExample extends StatelessWidget {
  const LoadingTypesExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loading Types Example')),
      body: Stack(
        children: [
          // Nội dung chính
          const Center(child: Text('Các loại loading animation khác nhau')),

          // Ví dụ với loading type khác
          CustomBlocLoading<NewsBloc, NewsState>(
            loadingState: (state) => state is NewsLoading,
            message: 'Loading với animation đặc biệt',
            loadingType: LoadingType.newtonCradle,
            backgroundColor: Colors.purple.withOpacity(0.2),
            indicatorColor: Colors.purple,
            size: 50.0,
          ),
        ],
      ),
    );
  }
}

/// Ví dụ sử dụng trong một màn hình thực tế
class NewsListWithLoading extends StatelessWidget {
  const NewsListWithLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Danh sách tin tức')),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          return Stack(
            children: [
              // Hiển thị danh sách tin tức
              if (state is NewsListLoaded)
                ListView.builder(
                  itemCount: state.newsList.length,
                  itemBuilder: (context, index) {
                    final news = state.newsList[index];
                    return ListTile(
                      title: Text(news.title ?? ''),
                      subtitle: Text(news.content ?? ''),
                    );
                  },
                ),

              // Hiển thị loading khi đang tải
              if (state is NewsLoading)
                CustomBlocLoading<NewsBloc, NewsState>(
                  loadingState: (state) => state is NewsLoading,
                  message: 'Đang tải danh sách tin tức...',
                  loadingType: LoadingType.staggeredDotsWave,
                ),

              // Hiển thị thông báo lỗi
              if (state is NewsError)
                Center(child: Text('Lỗi: ${state.message}')),

              // Hiển thị thông báo trống
              if (state is NewsEmpty) Center(child: Text(state.message)),
            ],
          );
        },
      ),
    );
  }
}
