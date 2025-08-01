# Folk Medicine Bloc

This bloc manages the state for folk medicine data in the Sotay Nam Duoc app.

## Features

- **List Management**: Load and paginate folk medicine list
- **Search**: Search folk medicines by title/content
- **Category Filtering**: Filter folk medicines by category
- **Detail Loading**: Load individual folk medicine details by ID or slug
- **Refresh**: Refresh the current list
- **Error Handling**: Proper error states and messages

## Events

### LoadFolkMedicineList
Loads a list of folk medicines with pagination support.

```dart
LoadFolkMedicineList(
  page: 1,
  size: 10,
  search: "search term",
  categoryId: "category_id",
  isRefresh: false,
)
```

### LoadFolkMedicineDetail
Loads a specific folk medicine by ID.

```dart
LoadFolkMedicineDetail("folk_medicine_id")
```

### LoadFolkMedicineBySlug
Loads a specific folk medicine by slug.

```dart
LoadFolkMedicineBySlug("folk-medicine-slug")
```

### SearchFolkMedicine
Searches for folk medicines by term.

```dart
SearchFolkMedicine("search term")
```

### FilterFolkMedicineByCategory
Filters folk medicines by category.

```dart
FilterFolkMedicineByCategory("category_id")
```

### RefreshFolkMedicine
Refreshes the current list.

```dart
RefreshFolkMedicine()
```

## States

### FolkMedicineInitial
Initial state when the bloc is created.

### FolkMedicineLoading
Loading state when fetching data.

### FolkMedicineListLoaded
State when folk medicine list is successfully loaded.

```dart
FolkMedicineListLoaded(
  folkMedicineList: List<FolkMedicineModel>,
  hasMore: bool,
  isLoadingMore: bool,
  searchTerm: String?,
  categoryId: String?,
)
```

### FolkMedicineDetailLoaded
State when a single folk medicine detail is loaded.

```dart
FolkMedicineDetailLoaded(FolkMedicineModel)
```

### FolkMedicineError
Error state with error message.

```dart
FolkMedicineError("Error message")
```

### FolkMedicineEmpty
State when no folk medicines are found.

```dart
FolkMedicineEmpty(message: "Custom message")
```

## Usage

### Basic Setup

```dart
BlocProvider(
  create: (context) => FolkMedicineBloc(
    folkMedicineRepository: context.read<FolkMedicineRepository>(),
  ),
  child: YourWidget(),
)
```

### Loading List

```dart
context.read<FolkMedicineBloc>().add(
  LoadFolkMedicineList(page: 1, size: 10),
);
```

### Searching

```dart
context.read<FolkMedicineBloc>().add(
  SearchFolkMedicine("search term"),
);
```

### Loading Detail

```dart
context.read<FolkMedicineBloc>().add(
  LoadFolkMedicineDetail("folk_medicine_id"),
);
```

### Listening to States

```dart
BlocBuilder<FolkMedicineBloc, FolkMedicineState>(
  builder: (context, state) {
    if (state is FolkMedicineLoading) {
      return CircularProgressIndicator();
    } else if (state is FolkMedicineListLoaded) {
      return ListView.builder(
        itemCount: state.folkMedicineList.length,
        itemBuilder: (context, index) {
          final folkMedicine = state.folkMedicineList[index];
          return FolkMedicineCard(folkMedicine: folkMedicine);
        },
      );
    } else if (state is FolkMedicineError) {
      return Text('Error: ${state.message}');
    } else if (state is FolkMedicineEmpty) {
      return Text(state.message);
    }
    return Container();
  },
)
```

### Load More Functionality

```dart
// In your widget
void _loadMore() {
  context.read<FolkMedicineBloc>().loadMore();
}

// Use with ListView.builder
ListView.builder(
  itemCount: state.folkMedicineList.length + (state.hasMore ? 1 : 0),
  itemBuilder: (context, index) {
    if (index == state.folkMedicineList.length) {
      if (state.hasMore) {
        _loadMore();
        return CircularProgressIndicator();
      }
      return Container();
    }
    return FolkMedicineCard(folkMedicine: state.folkMedicineList[index]);
  },
)
```

## Repository Integration

The bloc uses `FolkMedicineRepository` to fetch data from the API. Make sure the repository is properly configured in your dependency injection setup.

## Error Handling

The bloc handles errors gracefully and emits `FolkMedicineError` state with appropriate error messages. Always check for error states in your UI to provide good user experience. 