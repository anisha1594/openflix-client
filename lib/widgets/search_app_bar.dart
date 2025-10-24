import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget {
  final Function(String) onSearch;
  final VoidCallback onClear;

  const SearchAppBar({
    super.key,
    required this.onSearch,
    required this.onClear,
  });

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    if (query.isNotEmpty) {
      widget.onSearch(query);
    }
  }

  void _handleClear() {
    _searchController.clear();
    setState(() {
      _isSearching = false;
    });
    widget.onClear();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          if (!_isSearching)
            const Text(
              'OpenFlix',
              style: TextStyle(
                color: Colors.red,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          const Spacer(),
          if (_isSearching)
            Expanded(
              child: TextField(
                controller: _searchController,
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
                    onPressed: _handleClear,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onSubmitted: _handleSearch,
                onChanged: (value) {
                  if (value.isEmpty) {
                    _handleClear();
                  }
                },
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white, size: 28),
              onPressed: _toggleSearch,
            ),
        ],
      ),
    );
  }
}

