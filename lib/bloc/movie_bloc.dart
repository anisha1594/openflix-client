import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/movie_repository.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc({required this.movieRepository}) : super(const MovieInitial()) {
    on<LoadPopularMovies>(_onLoadPopularMovies);
    on<SearchMovies>(_onSearchMovies);
    on<LoadMovieDetails>(_onLoadMovieDetails);
    on<LoadMoviesByGenre>(_onLoadMoviesByGenre);
    on<ClearSearch>(_onClearSearch);
    on<SearchTextChanged>(_onSearchTextChanged);
    on<ToggleSearchMode>(_onToggleSearchMode);
  }

  Future<void> _onLoadPopularMovies(
    LoadPopularMovies event,
    Emitter<MovieState> emit,
  ) async {
    final currentSearching = state.isSearching;
    emit(MovieLoading(isSearching: currentSearching));
    try {
      final movies = await movieRepository.getPopularMovies();
      emit(MovieLoaded(movies, isSearching: currentSearching));
    } catch (e) {
      emit(MovieError(e.toString(), isSearching: currentSearching));
    }
  }

  Future<void> _onSearchMovies(
    SearchMovies event,
    Emitter<MovieState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(const MovieInitial(isSearching: true));
      return;
    }

    emit(const MovieLoading(isSearching: true));
    try {
      final response = await movieRepository.searchMovies(event.query);
      emit(MovieSearchResults(response.movies, event.query));
    } catch (e) {
      emit(MovieError(e.toString(), isSearching: true));
    }
  }

  Future<void> _onLoadMovieDetails(
    LoadMovieDetails event,
    Emitter<MovieState> emit,
  ) async {
    emit(const MovieLoading());
    try {
      final movie = await movieRepository.getMovieDetails(event.imdbId);
      emit(MovieDetailsLoaded(movie));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> _onLoadMoviesByGenre(
    LoadMoviesByGenre event,
    Emitter<MovieState> emit,
  ) async {
    final currentSearching = state.isSearching;
    emit(MovieLoading(isSearching: currentSearching));
    try {
      final movies = await movieRepository.getMoviesByGenre(event.genre);
      emit(MovieLoaded(movies, isSearching: currentSearching));
    } catch (e) {
      emit(MovieError(e.toString(), isSearching: currentSearching));
    }
  }

  Future<void> _onClearSearch(
    ClearSearch event,
    Emitter<MovieState> emit,
  ) async {
    emit(const MovieInitial(isSearching: false));
    add(const LoadPopularMovies());
  }

  Future<void> _onSearchTextChanged(
    SearchTextChanged event,
    Emitter<MovieState> emit,
  ) async {
    // This event can be used for debounced search in the future
    // For now, just trigger search if text is not empty
    if (event.text.isNotEmpty) {
      add(SearchMovies(event.text));
    }
  }

  void _onToggleSearchMode(
    ToggleSearchMode event,
    Emitter<MovieState> emit,
  ) {
    // Toggle search mode while preserving the current state data
    if (state is MovieLoaded) {
      final currentState = state as MovieLoaded;
      emit(MovieLoaded(currentState.movies, isSearching: true));
    } else if (state is MovieInitial) {
      emit(const MovieInitial(isSearching: true));
    } else {
      // For other states, just toggle the flag
      emit(_copyStateWithSearching(state, true));
    }
  }

  MovieState _copyStateWithSearching(MovieState state, bool isSearching) {
    if (state is MovieLoaded) {
      return MovieLoaded(state.movies, isSearching: isSearching);
    } else if (state is MovieError) {
      return MovieError(state.message, isSearching: isSearching);
    } else if (state is MovieLoading) {
      return MovieLoading(isSearching: isSearching);
    } else if (state is MovieInitial) {
      return MovieInitial(isSearching: isSearching);
    }
    return state;
  }
}


