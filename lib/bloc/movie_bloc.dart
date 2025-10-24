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
  }

  Future<void> _onLoadPopularMovies(
    LoadPopularMovies event,
    Emitter<MovieState> emit,
  ) async {
    emit(const MovieLoading());
    try {
      final movies = await movieRepository.getPopularMovies();
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> _onSearchMovies(
    SearchMovies event,
    Emitter<MovieState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(const MovieInitial());
      return;
    }

    emit(const MovieLoading());
    try {
      final response = await movieRepository.searchMovies(event.query);
      emit(MovieSearchResults(response.movies, event.query));
    } catch (e) {
      emit(MovieError(e.toString()));
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
    emit(const MovieLoading());
    try {
      final movies = await movieRepository.getMoviesByGenre(event.genre);
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> _onClearSearch(
    ClearSearch event,
    Emitter<MovieState> emit,
  ) async {
    emit(const MovieInitial());
    add(const LoadPopularMovies());
  }
}


