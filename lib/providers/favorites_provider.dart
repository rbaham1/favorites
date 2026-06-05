import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  final cities = sampleCities;
  final hobbies = sampleHobbies;
  final books = sampleBooks;
  bool isDarkMode = false;

  // Constructor that defines the provider upon initialization
  // This will run loadFavorites() immediately upon starting the app
  FavoritesProvider() {
    loadFavorites();
  }

  // Function to save any changes to favorites or settings
  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteCityIDs = cities
      .where((city) => city.isFavorite)
      .map((city) => city.id.toString())
      .toList();

      await prefs.setStringList("favoriteCities", favoriteCityIDs);

    final favoriteHobbyIDs = hobbies
      .where((hobby) => hobby.isFavorite)
      .map((hobby) => hobby.id.toString())
      .toList();

      await prefs.setStringList("favoriteHobbies", favoriteHobbyIDs);
    
    final favoriteBookIDs = books
      .where((book) => book.isFavorite)
      .map((book) => book.id.toString())
      .toList();

      await prefs.setStringList("favoriteBooks", favoriteBookIDs);

      await prefs.setBool("darkMode", isDarkMode);
  }

  // Load saved favorites and settings
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteCityIDs = prefs.getStringList('favoriteCities') ?? [];
    final favoriteHobbyIDs = prefs.getStringList('favoriteHobbies') ?? [];
    final favoriteBookIDs = prefs.getStringList('favoriteBooks') ?? [];

    for(final city in cities) {
      city.isFavorite = favoriteCityIDs.contains(city.id.toString());
    }

    for(final hobby in hobbies) {
      hobby.isFavorite = favoriteHobbyIDs.contains(hobby.id.toString());
    }

    for(final book in books) {
      book.isFavorite = favoriteBookIDs.contains(book.id.toString());
    }

    isDarkMode = prefs.getBool("darkMode") ?? false;

    notifyListeners();
  }

  // Set all favorites to false and save
  void clearFavorites() async {
    for(final city in cities) {
      city.isFavorite = false;
    }

    for(final hobby in hobbies) {
      hobby.isFavorite = false;
    }

    for(final book in books) {
      book.isFavorite = false;
    }

    saveFavorites();
    notifyListeners();
  }

  // Turn dark mode on and off
  void toggleDarkMode(bool value) {
    isDarkMode = !isDarkMode;
    saveFavorites();
    notifyListeners();
  }

  // Update city favorite state
  void toggleCityFavorite(int cityId) {
    final city = cities.firstWhere((city) => city.id == cityId);
    city.isFavorite = !city.isFavorite;
    saveFavorites();
    notifyListeners();
  }

  // Update hobby favorite state
  void toggleHobbyFavorite(int hobbyId) {
    final hobby = hobbies.firstWhere((hobby) => hobby.id == hobbyId);
    hobby.isFavorite = !hobby.isFavorite;
    saveFavorites();
    notifyListeners();
  }

  // Update book favorite state
  void toggleBookFavorite(int bookId) {
    final book = books.firstWhere((book) => book.id == bookId);
    book.isFavorite = !book.isFavorite;
    saveFavorites();
    notifyListeners();
  }
}