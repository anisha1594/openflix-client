import 'package:equatable/equatable.dart';
import '../models/movie.dart';

abstract class MovieState extends Equatable {
  final bool isSearching;
  
  const MovieState({this.isSearching = false});

  @override
  List<Object?> get props => [isSearching];
}

class MovieInitial extends MovieState {
  const MovieInitial({super.isSearching});
}

class MovieLoading extends MovieState {
  const MovieLoading({super.isSearching});
}

class MovieLoaded extends MovieState {
  final List<Movie> movies;

  const MovieLoaded(this.movies, {super.isSearching});

  @override
  List<Object?> get props => [movies, isSearching];
}

class MovieDetailsLoaded extends MovieState {
  final Movie movie;

  const MovieDetailsLoaded(this.movie, {super.isSearching});

  @override
  List<Object?> get props => [movie, isSearching];
}

class MovieError extends MovieState {
  final String message;

  const MovieError(this.message, {super.isSearching});

  @override
  List<Object?> get props => [message, isSearching];
}

class MovieSearchResults extends MovieState {
  final List<Movie> movies;
  final String query;

  const MovieSearchResults(this.movies, this.query) : super(isSearching: true);

  @override
  List<Object?> get props => [movies, query, isSearching];
}


