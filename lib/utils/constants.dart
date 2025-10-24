import 'package:flutter/material.dart';

/// App-wide constants for OpenFlix
class AppConstants {
  // Colors
  static const Color primaryRed = Color(0xFFE50914);
  static const Color darkBackground = Color(0xFF000000);
  static const Color darkGrey = Color(0xFF141414);
  static const Color lightGrey = Color(0xFF2F2F2F);

  // API
  static const String omdbBaseUrl = 'http://www.omdbapi.com/';
  static const String omdbApiKey = '86ede769';

  // UI Constants
  static const double movieCardWidth = 140.0;
  static const double movieCardHeight = 200.0;
  static const double borderRadius = 8.0;

  // Animation Durations
  static const Duration shortDuration = Duration(milliseconds: 200);
  static const Duration mediumDuration = Duration(milliseconds: 400);
  static const Duration longDuration = Duration(milliseconds: 600);

  // Text Styles
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: Colors.white70,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    color: Colors.white54,
  );
}

/// Popular search terms for movie discovery
class MovieCategories {
  static const List<String> popular = [
    'avengers',
    'marvel',
    'star wars',
    'batman',
    'spider',
    'harry potter',
    'lord of the rings',
    'matrix',
    'inception',
    'interstellar',
  ];

  static const List<String> genres = [
    'action',
    'comedy',
    'drama',
    'horror',
    'thriller',
    'romance',
    'sci-fi',
    'fantasy',
  ];
}



