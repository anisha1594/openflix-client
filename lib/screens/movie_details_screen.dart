import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';
import '../models/movie.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    // Dispatch LoadMovieDetails event when screen builds
    context.read<MovieBloc>().add(LoadMovieDetails(movie.imdbID));
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          Movie displayMovie = movie;

          if (state is MovieDetailsLoaded) {
            displayMovie = state.movie;
          }

          return CustomScrollView(
            slivers: [
              // App Bar with Poster
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                backgroundColor: Colors.black,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    // Reset to popular movies when going back
                    context.read<MovieBloc>().add(const LoadPopularMovies());
                    Navigator.pop(context);
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (displayMovie.poster != 'N/A')
                        CachedNetworkImage(
                          imageUrl: displayMovie.poster,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[900],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[900],
                            child: const Icon(
                              Icons.movie,
                              size: 100,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      else
                        Container(
                          color: Colors.grey[900],
                          child: const Icon(
                            Icons.movie,
                            size: 100,
                            color: Colors.grey,
                          ),
                        ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                              Colors.black,
                            ],
                            stops: const [0.0, 0.7, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        displayMovie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Metadata Row
                      Row(
                        children: [
                          if (displayMovie.year.isNotEmpty) ...[
                            Text(
                              displayMovie.year,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                          if (displayMovie.rated != null) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white70),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                displayMovie.rated!,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                          if (displayMovie.runtime != null)
                            Text(
                              displayMovie.runtime!,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Rating
                      if (displayMovie.imdbRating != null)
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${displayMovie.imdbRating}/10',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (displayMovie.imdbVotes != null)
                              Text(
                                '(${displayMovie.imdbVotes} votes)',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                          ],
                        ),
                      const SizedBox(height: 20),

                      // Play Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Play functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Play feature coming soon!'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.play_arrow, size: 32),
                          label: const Text(
                            'Play',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Plot
                      if (displayMovie.plot != null) ...[
                        const Text(
                          'Overview',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          displayMovie.plot!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Genre
                      if (displayMovie.genre != null) ...[
                        _buildInfoRow('Genre', displayMovie.genre!),
                        const SizedBox(height: 12),
                      ],

                      // Director
                      if (displayMovie.director != null) ...[
                        _buildInfoRow('Director', displayMovie.director!),
                        const SizedBox(height: 12),
                      ],

                      // Actors
                      if (displayMovie.actors != null) ...[
                        _buildInfoRow('Cast', displayMovie.actors!),
                        const SizedBox(height: 12),
                      ],

                      // Writer
                      if (displayMovie.writer != null) ...[
                        _buildInfoRow('Writer', displayMovie.writer!),
                        const SizedBox(height: 12),
                      ],

                      // Language
                      if (displayMovie.language != null) ...[
                        _buildInfoRow('Language', displayMovie.language!),
                        const SizedBox(height: 12),
                      ],

                      // Country
                      if (displayMovie.country != null) ...[
                        _buildInfoRow('Country', displayMovie.country!),
                        const SizedBox(height: 12),
                      ],

                      // Awards
                      if (displayMovie.awards != null) ...[
                        _buildInfoRow('Awards', displayMovie.awards!),
                        const SizedBox(height: 12),
                      ],

                      // Box Office
                      if (displayMovie.boxOffice != null) ...[
                        _buildInfoRow('Box Office', displayMovie.boxOffice!),
                        const SizedBox(height: 12),
                      ],

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            '$label:',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}



