import 'package:flutter/material.dart';
import 'screens/content_view.dart';
import 'package:provider/provider.dart';
import 'providers/favorites_provider.dart';

void main() {
  runApp(const FavoritesApp());
}

class FavoritesApp extends StatelessWidget {
  const FavoritesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // Light theme data
            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.white
            ),
            // Dark theme data
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Colors.black,
              unselectedWidgetColor: Colors.white
            ),
            themeMode: favoritesProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: ContentView(),
          );
        },
      )
    );
  }
}