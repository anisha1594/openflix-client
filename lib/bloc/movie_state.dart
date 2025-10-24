import 'package:equatable/equatable.dart';
import '../models/movie.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {
  const MovieInitial();
}

class MovieLoading extends MovieState {
  const MovieLoading();
}

class MovieLoaded extends MovieState {
  final List<Movie> movies;

  const MovieLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class MovieDetailsLoaded extends MovieState {
  final Movie movie;

  const MovieDetailsLoaded(this.movie);

  @override
  List<Object?> get props => [movie];
}

class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieSearchResults extends MovieState {
  final List<Movie> movies;
  final String query;

  const MovieSearchResults(this.movies, this.query);

  @override
  List<Object?> get props => [movies, query];
}


