import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bloc/movie_bloc.dart';
import 'bloc/movie_event.dart';
import 'screens/home_screen.dart';
import 'services/omdb_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const OpenFlixApp());
}

class OpenFlixApp extends StatelessWidget {
  const OpenFlixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // Create MovieBloc and immediately dispatch LoadPopularMovies event
        final bloc = MovieBloc(omdbService: OmdbService());
        bloc.add(const LoadPopularMovies());
        return bloc;
      },
      child: MaterialApp(
        title: 'OpenFlix',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.red,
          scaffoldBackgroundColor: Colors.black,
          textTheme: GoogleFonts.robotoTextTheme(
            ThemeData.dark().textTheme,
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}



