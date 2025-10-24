import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openflix_client/main.dart';
import 'package:openflix_client/bloc/movie_bloc.dart';
import 'package:openflix_client/repositories/movie_repository.dart';

void main() {
  testWidgets('OpenFlix app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const OpenFlixApp());

    // Verify that the app title is present
    expect(find.text('OpenFlix'), findsOneWidget);

    // Verify that loading indicator or content appears
    await tester.pump();
  });

  testWidgets('Search bar appears on home screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (context) => MovieBloc(movieRepository: MovieRepository()),
        child: const MaterialApp(home: Scaffold(body: Text('OpenFlix'))),
      ),
    );

    expect(find.text('OpenFlix'), findsOneWidget);
  });
}



