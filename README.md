# OpenFlix - Netflix-like Movie App

A beautiful Netflix-inspired Flutter application built with **Bloc** state management and powered by the **OMDB API**.

## Features

✨ **Modern Netflix-like UI**
- Beautiful home screen with featured movies
- Horizontal scrolling movie rows
- Grid layout for search results
- Detailed movie information screen

🎬 **Movie Discovery**
- Browse popular movies and series
- Search for any movie or TV show
- View detailed information including ratings, cast, plot, and more
- Cached images for smooth scrolling

🏗️ **Clean Architecture**
- Bloc pattern for state management
- Separation of concerns (models, services, bloc, UI)
- Reactive programming with streams
- Equatable for value comparison

## Project Structure

```
lib/
├── bloc/
│   ├── movie_bloc.dart      # Business logic
│   ├── movie_event.dart     # Events
│   └── movie_state.dart     # States
├── models/
│   └── movie.dart           # Data models
├── screens/
│   ├── home_screen.dart     # Main screen
│   └── movie_details_screen.dart
├── services/
│   └── omdb_service.dart    # API service
├── widgets/
│   ├── featured_movie.dart
│   ├── movie_card.dart
│   ├── movie_row.dart
│   └── search_bar_widget.dart
└── main.dart                # App entry point
```

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK
- OMDB API key (included in the project)

### Installation

1. **Clone the repository**
   ```bash
   cd openflix-client
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Dependencies

- **flutter_bloc** (^8.1.3) - State management
- **equatable** (^2.0.5) - Value equality
- **http** (^1.1.0) - API calls
- **cached_network_image** (^3.3.0) - Image caching
- **google_fonts** (^6.1.0) - Typography
- **intl** (^0.18.1) - Date formatting

## API Configuration

The app uses OMDB API with the following configuration:
- **Base URL**: `http://www.omdbapi.com/`
- **API Key**: `86ede769`

The API key is configured in `lib/services/omdb_service.dart`.

## Usage

### Home Screen
- Browse featured movies at the top
- Scroll through different categories
- Tap on any movie to view details
- Use the search icon to find specific movies

### Search
- Tap the search icon in the app bar
- Enter a movie or TV show name
- Results appear in a grid layout
- Tap any result to view details

### Movie Details
- View full movie information
- See ratings, cast, director, plot
- Access play button (UI only)
- Navigate back to home

## Bloc Architecture

The app uses the Bloc pattern with three main components:

### Events
```dart
- LoadPopularMovies()
- SearchMovies(query)
- LoadMovieDetails(imdbId)
- LoadMoviesByGenre(genre)
- ClearSearch()
```

### States
```dart
- MovieInitial
- MovieLoading
- MovieLoaded(movies)
- MovieDetailsLoaded(movie)
- MovieSearchResults(movies, query)
- MovieError(message)
```

### Bloc
The `MovieBloc` handles all business logic and state transitions:
- Fetches data from OMDB service
- Emits appropriate states
- Handles errors gracefully

## Customization

### Changing API Key
Edit `lib/services/omdb_service.dart`:
```dart
static const String _apiKey = 'YOUR_API_KEY';
```

### Modifying Colors
Edit `lib/main.dart` theme configuration:
```dart
theme: ThemeData(
  primaryColor: Colors.red, // Change primary color
  // ... other theme properties
)
```

### Adding More Categories
Edit `lib/services/omdb_service.dart` in the `getPopularMovies()` method:
```dart
final searches = ['avengers', 'marvel', 'star wars', 'batman', 'your_category'];
```

## Build for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the MIT License.

## Acknowledgments

- **OMDB API** for providing the movie data
- **Flutter** team for the amazing framework
- **Bloc Library** for state management solution
- **Netflix** for UI/UX inspiration

## Screenshots

The app features:
- 🎯 Netflix-inspired home screen
- 🔍 Powerful search functionality
- 📱 Responsive design
- 🎨 Modern Material Design 3
- ⚡ Fast and smooth performance

## Support

For issues, questions, or contributions, please open an issue in the repository.

---

Built with ❤️ using Flutter and Bloc



