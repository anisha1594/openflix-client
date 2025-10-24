import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => [];
}

class LoadPopularMovies extends MovieEvent {
  const LoadPopularMovies();
}

class SearchMovies extends MovieEvent {
  final String query;

  const SearchMovies(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadMovieDetails extends MovieEvent {
  final String imdbId;

  const LoadMovieDetails(this.imdbId);

  @override
  List<Object?> get props => [imdbId];
}

class LoadMoviesByGenre extends MovieEvent {
  final String genre;

  const LoadMoviesByGenre(this.genre);

  @override
  List<Object?> get props => [genre];
}

class ClearSearch extends MovieEvent {
  const ClearSearch();
}


