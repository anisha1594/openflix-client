import 'package:dio/dio.dart';
import 'package:openflix_client/models/movie.dart';
import 'package:retrofit/retrofit.dart';

part 'omdb_rest_client.g.dart';

@RestApi(baseUrl: 'https://www.omdbapi.com/?apikey=86ede769')
abstract class RestClient {

  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('&s={query}&page={page}')
  Future<SearchResponse> searchMovies(@Path('query') String query, @Path('page') int page);

  @GET('&i={imdbId}&plot=full')
  Future<Movie> getMovieDetails(@Path('imdbId') String imdbId);

}