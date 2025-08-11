# Thư Viện Sổ Tay Nam Dược - Thiết Kế Mới

## Tổng Quan

Thư viện đã được thiết kế lại để bao gồm cả **Cây thuốc** và **Thầy thuốc** theo endpoint từ backend. Giao diện sử dụng tab navigation để chuyển đổi giữa hai loại nội dung.

## Cấu Trúc Mới

### 1. Tab Navigation
- **Tab 1: Cây thuốc** - Hiển thị danh sách các loại cây thuốc
- **Tab 2: Thầy thuốc** - Hiển thị danh sách các thầy thuốc nổi tiếng

### 2. Các Model Mới

#### AuthorEntity & AuthorModel
- `id`: ID duy nhất
- `name`: Tên thầy thuốc
- `slug`: URL slug
- `alias`: Bí danh
- `biography`: Tiểu sử
- `career`: Sự nghiệp
- `achievements`: Thành tựu
- `contributions`: Đóng góp
- `works`: Tác phẩm
- `philosophy`: Triết lý
- `legacy`: Di sản
- `birthDate`, `deathDate`: Ngày sinh/mất
- `birthPlace`, `deathPlace`: Nơi sinh/mất
- `era`, `dynasty`: Thời đại, triều đại
- `specialty`: Chuyên môn
- `teacher`, `students`: Thầy dạy, học trò
- `portrait`, `avatar`, `coverImage`: Hình ảnh
- `galleryImages`: Bộ sưu tập hình ảnh
- `quotes`: Trích dẫn
- `anecdotes`: Giai thoại
- `honors`: Danh hiệu
- `memorials`: Tưởng niệm
- `references`: Tài liệu tham khảo
- `viewCount`, `likeCount`: Số lượt xem, thích
- `isActive`: Trạng thái hoạt động
- `createdAt`, `updatedAt`: Thời gian tạo/cập nhật

### 3. Bloc Pattern

#### AuthorBloc
- **Events**: GetAuthors, LoadMoreAuthors, RefreshAuthors, SearchAuthors, GetAuthorById, GetAuthorBySlug, GetFamousAuthors, GetAuthorsByEra, GetAuthorsByDynasty, GetAuthorsBySpecialty
- **States**: AuthorInitial, AuthorLoading, AuthorLoaded, AuthorDetailLoaded, AuthorError

#### AuthorRepository
- Interface và implementation cho các API calls
- Hỗ trợ pagination, search, và filtering

### 4. Giao Diện

#### LibraryBodyScreen
- Tab controller với 2 tab
- Scroll controller riêng biệt cho mỗi tab
- Pull-to-refresh cho cả hai tab
- Infinite scrolling với loading indicator

#### AuthorDetailScreen
- Header với avatar và thông tin cơ bản
- Các section thông tin chi tiết
- Responsive design
- Error handling cho hình ảnh

## API Endpoints

### Authors
- `GET /authors` - Lấy danh sách tất cả thầy thuốc
- `GET /authors/famous` - Lấy danh sách thầy thuốc nổi tiếng
- `GET /authors/search/:query` - Tìm kiếm thầy thuốc
- `GET /authors/era/:era` - Lấy thầy thuốc theo thời đại
- `GET /authors/dynasty/:dynasty` - Lấy thầy thuốc theo triều đại
- `GET /authors/specialty/:specialty` - Lấy thầy thuốc theo chuyên môn
- `GET /authors/slug/:slug` - Lấy thầy thuốc theo slug
- `GET /authors/:id` - Lấy thầy thuốc theo ID
- `POST /authors/:id/view` - Tăng lượt xem
- `POST /authors/:id/like` - Tăng lượt thích

## Cách Sử Dụng

### 1. Khởi tạo
```dart
// Trong main.dart hoặc app initialization
final authorBloc = getIt<AuthorBloc>();
```

### 2. Load dữ liệu
```dart
// Load tất cả thầy thuốc
context.read<AuthorBloc>().add(const GetAuthorsEvent());

// Load thầy thuốc nổi tiếng
context.read<AuthorBloc>().add(const GetFamousAuthorsEvent());

// Tìm kiếm
context.read<AuthorBloc>().add(SearchAuthorsEvent('Hải Thượng'));
```

### 3. Hiển thị trong UI
```dart
BlocBuilder<AuthorBloc, AuthorState>(
  builder: (context, state) {
    if (state is AuthorLoading) {
      return CircularProgressIndicator();
    } else if (state is AuthorLoaded) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final author = state.authors[index];
          return AuthorCard(author: author);
        },
      );
    }
    return Container();
  },
)
```

## Tính Năng

### ✅ Đã Hoàn Thành
- [x] Tab navigation giữa Cây thuốc và Thầy thuốc
- [x] Author model và entity
- [x] Author bloc pattern
- [x] Author repository interface
- [x] Giao diện danh sách thầy thuốc
- [x] Màn hình chi tiết thầy thuốc
- [x] Pull-to-refresh
- [x] Infinite scrolling
- [x] Error handling
- [x] Loading states

### 🔄 Cần Hoàn Thiện
- [ ] API implementation trong repository
- [ ] Pagination logic
- [ ] Search functionality
- [ ] Filtering theo era, dynasty, specialty
- [ ] Image caching
- [ ] Offline support
- [ ] Unit tests
- [ ] Integration tests

## Cấu Trúc File

```
lib/
├── domain/
│   ├── data/
│   │   ├── entities/
│   │   │   └── author_entity.dart
│   │   └── models/
│   │       └── author_model.dart
│   └── repositories/
│       └── author_repository.dart
├── blocs/
│   └── author/
│       ├── author_bloc.dart
│       ├── author_event.dart
│       ├── author_state.dart
│       └── author.dart
└── ui/
    └── screen/
        └── library/
            ├── library_body_screen.dart
            └── author_detail_screen.dart
```

## Lưu Ý

1. **Dependency Injection**: Đảm bảo đã đăng ký AuthorBloc và AuthorRepository trong injection container
2. **API Keys**: Cần cấu hình API endpoints và authentication
3. **Error Handling**: Xử lý các trường hợp network error, server error
4. **Performance**: Implement pagination để tránh load quá nhiều dữ liệu
5. **Accessibility**: Thêm semantic labels và screen reader support

## Tương Lai

- [ ] Thêm folk medicine tab
- [ ] Advanced search với filters
- [ ] Bookmark/favorite functionality
- [ ] Share functionality
- [ ] Dark mode support
- [ ] Multi-language support
- [ ] Analytics tracking 