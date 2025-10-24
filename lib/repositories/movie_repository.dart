import 'package:dio/dio.dart';
import '../clients/omdb_rest_client.dart';
import '../models/movie.dart';

class MovieRepository {
  MovieRepository()
      : dio = Dio(),
        client = RestClient(Dio());

  final Dio dio;
  final RestClient client;

  // Get popular movies (using predefined search terms)
  Future<List<Movie>> getPopularMovies() async {
    try {
      // Using popular search terms to get trending content
      final searches = ['avengers', 'marvel', 'star wars', 'batman'];
      final List<Movie> allMovies = [];

      for (var searchTerm in searches) {
        final response = await client.searchMovies(searchTerm, 1);
        allMovies.addAll(response.movies);
      }

      // Remove duplicates based on imdbID
      final uniqueMovies = <String, Movie>{};
      for (var movie in allMovies) {
        uniqueMovies[movie.imdbID] = movie;
      }

      return uniqueMovies.values.toList()..shuffle();
    } catch (e) {
      throw Exception('Error getting popular movies: $e');
    }
  }

  // Get movies by genre (using search term as proxy)
  Future<List<Movie>> getMoviesByGenre(String genre) async {
    try {
      final response = await client.searchMovies(genre, 1);
      return response.movies;
    } catch (e) {
      throw Exception('Error getting movies by genre: $e');
    }
  }

  // Search movies by title
  Future<SearchResponse> searchMovies(String query, {int page = 1}) async {
    try {
      final response = await client.searchMovies(query, page);
      return response;
    } catch (e) {
      throw Exception('Error searching movies: $e');
    }
  }

  // // Get movie details by IMDb ID
  Future<Movie> getMovieDetails(String imdbId) async {
    try {
      final response = await client.getMovieDetails(imdbId);
      return response;
    } catch (e) {
      throw Exception('Error getting movie details: $e');
    }
  }
}


