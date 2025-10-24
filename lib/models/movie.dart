import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String title;
  final String year;
  final String imdbID;
  final String type;
  final String poster;
  final String? rated;
  final String? released;
  final String? runtime;
  final String? genre;
  final String? director;
  final String? writer;
  final String? actors;
  final String? plot;
  final String? language;
  final String? country;
  final String? awards;
  final String? imdbRating;
  final String? imdbVotes;
  final String? boxOffice;

  const Movie({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.type,
    required this.poster,
    this.rated,
    this.released,
    this.runtime,
    this.genre,
    this.director,
    this.writer,
    this.actors,
    this.plot,
    this.language,
    this.country,
    this.awards,
    this.imdbRating,
    this.imdbVotes,
    this.boxOffice,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      imdbID: json['imdbID'] ?? '',
      type: json['Type'] ?? '',
      poster: json['Poster'] ?? '',
      rated: json['Rated'],
      released: json['Released'],
      runtime: json['Runtime'],
      genre: json['Genre'],
      director: json['Director'],
      writer: json['Writer'],
      actors: json['Actors'],
      plot: json['Plot'],
      language: json['Language'],
      country: json['Country'],
      awards: json['Awards'],
      imdbRating: json['imdbRating'],
      imdbVotes: json['imdbVotes'],
      boxOffice: json['BoxOffice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Year': year,
      'imdbID': imdbID,
      'Type': type,
      'Poster': poster,
      'Rated': rated,
      'Released': released,
      'Runtime': runtime,
      'Genre': genre,
      'Director': director,
      'Writer': writer,
      'Actors': actors,
      'Plot': plot,
      'Language': language,
      'Country': country,
      'Awards': awards,
      'imdbRating': imdbRating,
      'imdbVotes': imdbVotes,
      'BoxOffice': boxOffice,
    };
  }

  @override
  List<Object?> get props => [
        title,
        year,
        imdbID,
        type,
        poster,
        rated,
        released,
        runtime,
        genre,
        director,
        writer,
        actors,
        plot,
        language,
        country,
        awards,
        imdbRating,
        imdbVotes,
        boxOffice,
      ];
}

class SearchResponse extends Equatable {
  final List<Movie> movies;
  final String totalResults;
  final bool response;

  const SearchResponse({
    required this.movies,
    required this.totalResults,
    required this.response,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> searchList = json['Search'] ?? [];
    final List<Movie> movies =
        searchList.map((movie) => Movie.fromJson(movie)).toList();

    return SearchResponse(
      movies: movies,
      totalResults: json['totalResults'] ?? '0',
      response: json['Response'] == 'True',
    );
  }

  @override
  List<Object?> get props => [movies, totalResults, response];
}


