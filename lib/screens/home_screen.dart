import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';
import '../models/movie.dart';
import '../widgets/featured_movie.dart';
import '../widgets/movie_row.dart';
import '../widgets/search_app_bar.dart';
import 'movie_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToDetails(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsScreen(movie: movie),
      ),
    );
  }

  List<Movie> _getMoviesByType(List<Movie> movies, String type) {
    return movies.where((m) => m.type == type).toList();
  }

  void _handleSearch(BuildContext context, String query) {
    // Dispatch SearchMovies event to Bloc
    context.read<MovieBloc>().add(SearchMovies(query));
  }

  void _handleClear(BuildContext context) {
    // Dispatch ClearSearch event to Bloc
    context.read<MovieBloc>().add(const ClearSearch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar - Extracted to separate widget
            SearchAppBar(
              onSearch: (query) => _handleSearch(context, query),
              onClear: () => _handleClear(context),
            ),

            // Content
            Expanded(
              child: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    );
                  }

                  if (state is MovieError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error: ${state.message}',
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<MovieBloc>()
                                  .add(const LoadPopularMovies());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is MovieSearchResults) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Search Results for "${state.query}"',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (state.movies.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(32.0),
                                child: Text(
                                  'No results found',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )
                          else
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(16),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemCount: state.movies.length,
                              itemBuilder: (context, index) {
                                final movie = state.movies[index];
                                return GestureDetector(
                                  onTap: () => _navigateToDetails(context, movie),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: movie.poster != 'N/A'
                                              ? Image.network(
                                                  movie.poster,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Container(
                                                      color: Colors.grey[900],
                                                      child: const Icon(
                                                        Icons.movie,
                                                        color: Colors.grey,
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container(
                                                  color: Colors.grey[900],
                                                  child: const Icon(
                                                    Icons.movie,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        movie.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    );
                  }

                  if (state is MovieLoaded && state.movies.isNotEmpty) {
                    final movies = state.movies;
                    final featuredMovie = movies.first;
                    final moviesList = _getMoviesByType(movies, 'movie');
                    final seriesList = _getMoviesByType(movies, 'series');

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          // Featured Movie
                          FeaturedMovie(
                            movie: featuredMovie,
                            onPlayTap: () => _navigateToDetails(context, featuredMovie),
                            onInfoTap: () => _navigateToDetails(context, featuredMovie),
                          ),

                          // Movie Rows
                          if (moviesList.isNotEmpty)
                            MovieRow(
                              title: 'Popular Movies',
                              movies: moviesList.take(10).toList(),
                              onMovieTap: (movie) => _navigateToDetails(context, movie),
                            ),

                          if (seriesList.isNotEmpty)
                            MovieRow(
                              title: 'Popular Series',
                              movies: seriesList.take(10).toList(),
                              onMovieTap: (movie) => _navigateToDetails(context, movie),
                            ),

                          // Additional rows with different slices
                          if (movies.length > 20)
                            MovieRow(
                              title: 'Trending Now',
                              movies: movies.skip(10).take(10).toList(),
                              onMovieTap: (movie) => _navigateToDetails(context, movie),
                            ),

                          if (movies.length > 30)
                            MovieRow(
                              title: 'Top Picks',
                              movies: movies.skip(20).take(10).toList(),
                              onMovieTap: (movie) => _navigateToDetails(context, movie),
                            ),

                          const SizedBox(height: 32),
                        ],
                      ),
                    );
                  }

                  return const Center(
                    child: Text(
                      'No movies available',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

