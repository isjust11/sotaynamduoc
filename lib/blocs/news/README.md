# News BLoC Pattern Implementation

## Tổng quan

Chức năng tin tức được xây dựng theo mô hình BLoC (Business Logic Component) pattern, giúp tách biệt logic nghiệp vụ khỏi UI và quản lý state một cách hiệu quả.

## Cấu trúc thư mục

```
lib/blocs/news/
├── news_bloc.dart          # Business Logic Component
├── news_event.dart         # Events (sự kiện)
├── news_state.dart         # States (trạng thái)
├── news.dart              # File export
└── README.md              # Hướng dẫn sử dụng
```

## Các thành phần chính

### 1. NewsEvent (Sự kiện)
- `LoadNewsList`: Tải danh sách tin tức
- `LoadNewsDetail`: Tải chi tiết tin tức
- `SearchNews`: Tìm kiếm tin tức
- `RefreshNews`: Làm mới dữ liệu

### 2. NewsState (Trạng thái)
- `NewsInitial`: Trạng thái khởi tạo
- `NewsLoading`: Đang tải dữ liệu
- `NewsListLoaded`: Đã tải xong danh sách
- `NewsDetailLoaded`: Đã tải xong chi tiết
- `NewsError`: Có lỗi xảy ra
- `NewsEmpty`: Không có dữ liệu

### 3. NewsBloc (Business Logic)
Quản lý logic nghiệp vụ và chuyển đổi giữa các trạng thái.

## Cách sử dụng

### 1. Trong Widget

```dart
// Tạo BlocProvider
BlocProvider(
  create: (context) => getIt<NewsBloc>()..add(const LoadNewsList()),
  child: YourWidget(),
)

// Sử dụng BlocBuilder để lắng nghe state
BlocBuilder<NewsBloc, NewsState>(
  builder: (context, state) {
    if (state is NewsLoading) {
      return CircularProgressIndicator();
    } else if (state is NewsListLoaded) {
      return ListView.builder(
        itemCount: state.newsList.length,
        itemBuilder: (context, index) {
          return NewsItem(news: state.newsList[index]);
        },
      );
    }
    return Container();
  },
)

// Gửi event
context.read<NewsBloc>().add(const LoadNewsList());
context.read<NewsBloc>().add(SearchNews("từ khóa"));
```

### 2. Tải thêm dữ liệu (Pagination)

```dart
// Trong ScrollController listener
void _onScroll() {
  if (_scrollController.position.pixels >=
      _scrollController.position.maxScrollExtent - 200) {
    context.read<NewsBloc>().loadMore();
  }
}
```

### 3. Làm mới dữ liệu

```dart
RefreshIndicator(
  onRefresh: () async {
    context.read<NewsBloc>().add(const RefreshNews());
  },
  child: YourListView(),
)
```

## API Endpoints

- `GET /article` - Lấy danh sách tin tức (với pagination)
- `GET /article/:id` - Lấy chi tiết tin tức

## Tham số API

### LoadNewsList
- `page`: Số trang (mặc định: 1)
- `size`: Số lượng item mỗi trang (mặc định: 10)
- `search`: Từ khóa tìm kiếm (tùy chọn)
- `isRefresh`: Có phải làm mới không (mặc định: false)

### LoadNewsDetail
- `id`: ID của tin tức

## Lưu ý

1. **Dependency Injection**: NewsBloc được đăng ký trong `injection_container.dart`
2. **Error Handling**: Tất cả lỗi được xử lý và hiển thị thông qua `NewsError` state
3. **Pagination**: Hỗ trợ tải thêm dữ liệu tự động khi scroll đến cuối
4. **Search**: Hỗ trợ tìm kiếm với debounce để tối ưu performance
5. **Refresh**: Hỗ trợ pull-to-refresh để làm mới dữ liệu

## Ví dụ hoàn chỉnh

Xem file `lib/ui/screen/news/news_list_bloc_screen.dart` và `lib/ui/screen/news/news_detail_bloc_screen.dart` để tham khảo cách implement hoàn chỉnh. 