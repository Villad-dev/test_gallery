import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_gallery/data/view_models/gallery_view_model.dart';
import 'package:test_gallery/views/gallery_view.dart';

/// The entry point of the Gallery App.
///
/// This function initializes the app and sets up the [GalleryViewModel] as a
/// [ChangeNotifierProvider] to provide state management for the app. It then
/// runs the [MyApp] widget which sets up the main application structure.
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GalleryViewModel(),
      child: MyApp(),
    ),
  );
}

/// The root widget of the Gallery App.
///
/// This widget sets up the [MaterialApp] with the application title, theme, and
/// the home page for the app. It uses a [MaterialApp] to manage the app's navigation,
/// theming, and overall structure.
class MyApp extends StatelessWidget {
  /// Creates an instance of [MyApp].
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GalleryView(),
    );
  }
}
