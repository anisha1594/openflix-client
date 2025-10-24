# 🎬 OpenFlix App Flow

## User Journey

### 1. App Launch
```
┌─────────────────────────────────────┐
│  User opens OpenFlix                │
└───────────┬─────────────────────────┘
            │
            ↓
┌─────────────────────────────────────┐
│  main.dart initializes              │
│  - BlocProvider created             │
│  - MovieBloc instantiated           │
│  - HomeScreen rendered              │
└───────────┬─────────────────────────┘
            │
            ↓
┌─────────────────────────────────────┐
│  HomeScreen initState()             │
│  Dispatches: LoadPopularMovies      │
└───────────┬─────────────────────────┘
            │
            ↓
┌─────────────────────────────────────┐
│  MovieBloc processes event          │
│  - Calls OmdbService                │
│  - Fetches popular movies           │
└───────────┬─────────────────────────┘
            │
            ↓
┌─────────────────────────────────────┐
│  State transition:                  │
│  MovieInitial → MovieLoading        │
│                → MovieLoaded        │
└───────────┬─────────────────────────┘
            │
            ↓
┌─────────────────────────────────────┐
│  UI Rebuilds                        │
│  - Featured movie displayed         │
│  - Movie rows rendered              │
│  - Cached images loaded             │
└─────────────────────────────────────┘
```

### 2. Search Flow
```
User taps search icon
        │
        ↓
┌─────────────────────────────────────┐
│  SearchBarWidget                    │
│  - TextField appears                │
│  - User types query                 │
└───────────┬─────────────────────────┘
            │
            ↓ User submits
┌─────────────────────────────────────┐
│  onSearch callback                  │
│  Dispatches: SearchMovies(query)    │
└───────────┬─────────────────────────┘
            │
            ↓
┌─────────────────────────────────────┐
│  MovieBloc._onSearchMovies()        │
│  - Validates query                  │
│  - Calls API with search term       │
└───────────┬─────────────────────────┘
            │
            ↓
┌─────────────────────────────────────┐
│  State: MovieSearchResults          │
│  Contains: movies list + query      │
└───────────┬─────────────────────────┘
            │
            ↓
┌─────────────────────────────────────┐
│  UI shows search results            │
│  - Grid layout                      │
│  - Search query displayed           │
│  - Movie cards clickable            │
└─────────────────────────────────────┘
```

### 3. Movie Details Flow
```
User taps on movie card
        │
        ↓
┌─────────────────────────────────────┐
│  onMovieTap(movie) callback         │
│  Navigator.push()                   │
└───────────┬─────────────────────────┘
            │
            ↓
┌─────────────────────────────────────┐
│  MovieDetailsScreen                 │
│  - Receives movie object            │
│  - initState() called               │
└───────────┬─────────────────────────┘
            │
            ↓
┌─────────────────────────────────────┐
│  Dispatches:                        │
│  LoadMovieDetails(movie.imdbID)     │
└───────────┬─────────────────────────┘
            │
            ↓
┌─────────────────────────────────────┐
│  MovieBloc fetches full details     │
│  - API call with IMDb ID            │
│  - Gets complete movie info         │
└───────────┬─────────────────────────┘
            │
            ↓
┌─────────────────────────────────────┐
│  State: MovieDetailsLoaded          │
│  Contains: detailed Movie object    │
└───────────┬─────────────────────────┘
            │
            ↓
┌─────────────────────────────────────┐
│  UI displays full details           │
│  - Large poster image               │
│  - Title, year, rating              │
│  - Plot, cast, director             │
│  - Play button, metadata            │
└───────────┬─────────────────────────┘
            │
            ↓ User taps back
┌─────────────────────────────────────┐
│  Navigator.pop()                    │
│  Dispatches: LoadPopularMovies      │
│  Returns to HomeScreen              │
└─────────────────────────────────────┘
```

### 4. Clear Search Flow
```
User taps clear button
        │
        ↓
┌─────────────────────────────────────┐
│  onClear callback                   │
│  Dispatches: ClearSearch()          │
└───────────┬─────────────────────────┘
            │
            ↓
┌─────────────────────────────────────┐
│  MovieBloc._onClearSearch()         │
│  - Emits MovieInitial               │
│  - Dispatches LoadPopularMovies     │
└───────────┬─────────────────────────┘
            │
            ↓
┌─────────────────────────────────────┐
│  Returns to home view               │
│  - Featured movie visible           │
│  - Movie rows displayed             │
└─────────────────────────────────────┘
```

## State Transition Diagram

```
                    ┌──────────────┐
                    │ MovieInitial │
                    └──────┬───────┘
                           │
                           │ LoadPopularMovies
                           │ SearchMovies
                           │ LoadMovieDetails
                           ↓
                    ┌──────────────┐
                    │ MovieLoading │
                    └──────┬───────┘
                           │
              ┌────────────┼────────────┐
              │            │            │
              ↓            ↓            ↓
     ┌──────────────┐ ┌─────────┐ ┌──────────────────┐
     │ MovieLoaded  │ │MovieError│ │MovieDetailsLoaded│
     └──────────────┘ └─────────┘ └──────────────────┘
              │
              │ SearchMovies
              ↓
     ┌────────────────────┐
     │MovieSearchResults  │
     └────────────────────┘
              │
              │ ClearSearch
              ↓
        [Back to Initial]
```

## Component Interaction

### Home Screen Components
```
HomeScreen
├── SearchBarWidget
│   ├── TextField (conditionally rendered)
│   └── Search Icon / Clear Button
├── BlocBuilder<MovieBloc, MovieState>
│   ├── MovieLoading → CircularProgressIndicator
│   ├── MovieError → Error message + Retry button
│   ├── MovieSearchResults → GridView
│   └── MovieLoaded → SingleChildScrollView
│       ├── FeaturedMovie
│       │   ├── CachedNetworkImage
│       │   ├── Play Button
│       │   └── More Info Button
│       ├── MovieRow (Popular Movies)
│       │   └── ListView.builder
│       │       └── MovieCard (x10)
│       ├── MovieRow (Popular Series)
│       │   └── ListView.builder
│       │       └── MovieCard (x10)
│       └── MovieRow (Trending Now)
│           └── ListView.builder
│               └── MovieCard (x10)
```

### Movie Details Screen Components
```
MovieDetailsScreen
└── CustomScrollView
    ├── SliverAppBar
    │   ├── Back Button
    │   └── FlexibleSpaceBar
    │       └── CachedNetworkImage (poster)
    └── SliverToBoxAdapter
        ├── Title
        ├── Metadata Row (year, rating, runtime)
        ├── IMDb Rating with stars
        ├── Play Button (full width)
        ├── Overview Section
        └── Info Rows
            ├── Genre
            ├── Director
            ├── Cast
            ├── Writer
            ├── Language
            ├── Country
            ├── Awards
            └── Box Office
```

## Data Flow

### API Call Flow
```
1. User Action → Event
2. Event → MovieBloc
3. MovieBloc → OmdbService
4. OmdbService → HTTP Request
5. OMDB API → JSON Response
6. JSON → Movie Model (fromJson)
7. Movie Model → MovieBloc
8. MovieBloc → New State
9. State → UI (via BlocBuilder)
10. UI → Rebuild with new data
```

## Error Handling Flow

```
┌─────────────────────────────────────┐
│  API call fails                     │
└───────────┬─────────────────────────┘
            │
            ↓
┌─────────────────────────────────────┐
│  try-catch in Bloc                  │
│  Exception caught                   │
└───────────┬─────────────────────────┘
            │
            ↓
┌─────────────────────────────────────┐
│  emit(MovieError(message))          │
└───────────┬─────────────────────────┘
            │
            ↓
┌─────────────────────────────────────┐
│  UI shows error state               │
│  - Error icon                       │
│  - Error message                    │
│  - Retry button                     │
└───────────┬─────────────────────────┘
            │
            ↓ User taps retry
┌─────────────────────────────────────┐
│  Retry → LoadPopularMovies()        │
│  Process repeats                    │
└─────────────────────────────────────┘
```

## Performance Optimizations

1. **Image Caching**
   - `cached_network_image` package
   - Reduces network calls
   - Smooth scrolling

2. **Bloc State Management**
   - Efficient rebuilds
   - Only affected widgets rebuild
   - No unnecessary API calls

3. **Lazy Loading**
   - ListView.builder for efficient lists
   - Items built on-demand

4. **Const Constructors**
   - Reduced widget rebuilds
   - Better performance

## Key Features Implementation

### Search Debouncing
Currently: Triggers on submit
Future: Could add debouncing for live search

### Infinite Scroll
Currently: Fixed list sizes
Future: Could implement pagination

### Favorites
Currently: Not implemented
Future: Local storage with Hive/SharedPreferences

### Offline Mode
Currently: Requires internet
Future: Cache responses locally

---

This flow diagram helps understand how the app works end-to-end! 🎬



