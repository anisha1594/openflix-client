import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class OmdbService {
  static const String _baseUrl = 'https://www.omdbapi.com/';
  static const String _apiKey = '86ede769';

  // Search movies by title
  Future<SearchResponse> searchMovies(String query, {int page = 1}) async {
    try {
      final url = Uri.parse('$_baseUrl?apikey=$_apiKey&s=$query&page=$page');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['Response'] == 'True') {
          return SearchResponse.fromJson(data);
        } else {
          throw Exception(data['Error'] ?? 'Failed to search movies');
        }
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Error searching movies: $e');
    }
  }

  // Get movie details by IMDb ID
  Future<Movie> getMovieDetails(String imdbId) async {
    try {
      final url = Uri.parse('$_baseUrl?apikey=$_apiKey&i=$imdbId&plot=full');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['Response'] == 'True') {
          return Movie.fromJson(data);
        } else {
          throw Exception(data['Error'] ?? 'Failed to get movie details');
        }
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw Exception('Error getting movie details: $e');
    }
  }

  // Get popular movies (using predefined search terms)
  Future<List<Movie>> getPopularMovies() async {
    try {
      // Using popular search terms to get trending content
      final searches = ['avengers', 'marvel', 'star wars', 'batman'];
      final List<Movie> allMovies = [];

      for (var searchTerm in searches) {
        final response = await searchMovies(searchTerm);
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
      final response = await searchMovies(genre);
      return response.movies;
    } catch (e) {
      throw Exception('Error getting movies by genre: $e');
    }
  }
}


