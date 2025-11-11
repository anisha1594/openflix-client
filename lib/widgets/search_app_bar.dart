import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({super.key});

  void _handleSearch(BuildContext context, String query) {
    if (query.isNotEmpty) {
      context.read<MovieBloc>().add(SearchMovies(query));
    }
  }

  void _handleClear(BuildContext context) {
    context.read<MovieBloc>().add(const ClearSearch());
  }

  void _toggleSearch(BuildContext context) {
    context.read<MovieBloc>().add(const ToggleSearchMode());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        final isSearching = state.isSearching;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              if (!isSearching)
                const Text(
                  'OpenFlix',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const Spacer(),
              if (isSearching)
                Expanded(
                  child: TextField(
                    key: const Key('search_text_field'),
                    autofocus: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search movies...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () => _handleClear(context),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (query) => _handleSearch(context, query),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        _handleClear(context);
                      } else {
                        // Emit event for each text change
                        context.read<MovieBloc>().add(SearchTextChanged(value));
                      }
                    },
                  ),
                )
              else
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white, size: 28),
                  onPressed: () => _toggleSearch(context),
                ),
            ],
          ),
        );
      },
    );
  }
}

