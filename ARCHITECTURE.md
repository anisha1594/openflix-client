# 🏗️ Architecture Documentation

## Overview

OpenFlix follows the **Bloc (Business Logic Component)** pattern for clean, testable, and maintainable code architecture.

## Architecture Layers

```
┌─────────────────────────────────────────┐
│           Presentation Layer            │
│        (Screens & Widgets)              │
│  - home_screen.dart                     │
│  - movie_details_screen.dart            │
│  - Widget components                    │
└──────────────┬──────────────────────────┘
               │ Events
               ↓
┌──────────────────────────────────────────┐
│         Business Logic Layer             │
│              (Bloc)                      │
│  - movie_bloc.dart                       │
│  - movie_event.dart                      │
│  - movie_state.dart                      │
└──────────────┬───────────────────────────┘
               │ Calls
               ↓
┌──────────────────────────────────────────┐
│           Data Layer                     │
│    (Services & Models)                   │
│  - omdb_service.dart                     │
│  - movie.dart                            │
└──────────────┬───────────────────────────┘
               │ HTTP
               ↓
┌──────────────────────────────────────────┐
│          External API                    │
│         (OMDB API)                       │
└──────────────────────────────────────────┘
```

## Bloc Pattern Flow

### 1. User Interaction
User interacts with UI (e.g., searches for a movie)

### 2. Event Dispatched
UI dispatches an event to the Bloc:
```dart
context.read<MovieBloc>().add(SearchMovies(query));
```

### 3. Bloc Processing
Bloc receives event and processes it:
```dart
on<SearchMovies>(_onSearchMovies);

Future<void> _onSearchMovies(
  SearchMovies event,
  Emitter<MovieState> emit,
) async {
  emit(const MovieLoading());
  try {
    final response = await omdbService.searchMovies(event.query);
    emit(MovieSearchResults(response.movies, event.query));
  } catch (e) {
    emit(MovieError(e.toString()));
  }
}
```

### 4. State Emission
Bloc emits new state based on result

### 5. UI Rebuild
UI listens to state changes and rebuilds:
```dart
BlocBuilder<MovieBloc, MovieState>(
  builder: (context, state) {
    if (state is MovieLoading) {
      return CircularProgressIndicator();
    }
    if (state is MovieLoaded) {
      return MovieList(movies: state.movies);
    }
    // ... handle other states
  },
)
```

## Project Structure Explained

### 📁 lib/bloc/
**Purpose**: Contains all business logic

- **movie_event.dart**: Defines all possible user actions
  - `LoadPopularMovies`
  - `SearchMovies`
  - `LoadMovieDetails`
  - `LoadMoviesByGenre`
  - `ClearSearch`

- **movie_state.dart**: Defines all possible UI states
  - `MovieInitial`
  - `MovieLoading`
  - `MovieLoaded`
  - `MovieDetailsLoaded`
  - `MovieSearchResults`
  - `MovieError`

- **movie_bloc.dart**: Connects events to states
  - Handles event processing
  - Calls services
  - Emits appropriate states

### 📁 lib/models/
**Purpose**: Data models for type safety

- **movie.dart**: 
  - `Movie` class with all movie properties
  - `SearchResponse` for API response handling
  - JSON serialization/deserialization

### 📁 lib/services/
**Purpose**: External API communication

- **omdb_service.dart**:
  - API calls to OMDB
  - Response parsing
  - Error handling
  - Methods:
    - `searchMovies(query)`
    - `getMovieDetails(imdbId)`
    - `getPopularMovies()`
    - `getMoviesByGenre(genre)`

### 📁 lib/screens/
**Purpose**: Full-page UI components

- **home_screen.dart**:
  - Main app screen
  - Displays featured movie
  - Shows movie rows
  - Search functionality

- **movie_details_screen.dart**:
  - Detailed movie information
  - Ratings, cast, plot
  - Play button UI

### 📁 lib/widgets/
**Purpose**: Reusable UI components

- **featured_movie.dart**: Hero section with large poster
- **movie_card.dart**: Individual movie card
- **movie_row.dart**: Horizontal scrolling row
- **search_bar_widget.dart**: Search functionality

### 📁 lib/utils/
**Purpose**: Constants and utilities

- **constants.dart**: App-wide constants, colors, styles

## Key Dependencies

### State Management
- **flutter_bloc** (^8.1.3)
  - Provides Bloc pattern implementation
  - Includes BlocProvider, BlocBuilder
  - Handles state streams

- **equatable** (^2.0.5)
  - Value equality for events and states
  - Reduces boilerplate
  - Improves performance

### Networking
- **http** (^1.1.0)
  - HTTP client for API calls
  - Simple and reliable

### UI Enhancement
- **cached_network_image** (^3.3.0)
  - Image caching for performance
  - Smooth scrolling
  - Placeholder support

- **google_fonts** (^6.1.0)
  - Custom typography
  - Better UI aesthetics

## State Management Benefits

### ✅ Separation of Concerns
- Business logic separate from UI
- Easy to test
- Maintainable code

### ✅ Predictable State
- Single source of truth
- Clear state transitions
- Debuggable with BlocObserver

### ✅ Scalability
- Easy to add new features
- Modular architecture
- Reusable components

### ✅ Testability
- Unit test business logic
- Widget test UI
- Integration test flows

## Testing Strategy

### Unit Tests
Test individual Blocs:
```dart
test('emits [MovieLoading, MovieLoaded] when successful', () async {
  when(() => mockService.getPopularMovies())
      .thenAnswer((_) async => movies);
  
  expectLater(
    bloc.stream,
    emitsInOrder([MovieLoading(), MovieLoaded(movies)]),
  );
  
  bloc.add(LoadPopularMovies());
});
```

### Widget Tests
Test UI components:
```dart
testWidgets('displays movies when loaded', (tester) async {
  await tester.pumpWidget(
    BlocProvider.value(
      value: mockBloc,
      child: HomeScreen(),
    ),
  );
  
  expect(find.byType(MovieCard), findsWidgets);
});
```

## Best Practices

### 1. Single Responsibility
Each file/class has one clear purpose

### 2. Immutable States
All states are immutable using const constructors

### 3. Error Handling
Comprehensive error handling at all layers

### 4. Loading States
Show loading indicators for better UX

### 5. Type Safety
Use models instead of dynamic types

### 6. Code Reusability
Extract common widgets for reuse

## Future Enhancements

Potential improvements:
- [ ] Add favorites functionality with local storage
- [ ] Implement video playback
- [ ] Add user authentication
- [ ] Include movie trailers
- [ ] Add filters and sorting
- [ ] Implement pagination
- [ ] Add offline support
- [ ] Include unit tests
- [ ] Add integration tests

## Resources

- [Bloc Documentation](https://bloclibrary.dev/)
- [Flutter Documentation](https://docs.flutter.dev/)
- [OMDB API Docs](http://www.omdbapi.com/)
- [Material Design](https://m3.material.io/)

---

Built with 💙 using Flutter & Bloc Pattern



