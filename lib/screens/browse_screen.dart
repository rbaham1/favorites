import 'package:flutter/material.dart';
import '/widgets/city_card.dart';
import '/widgets/hobby_card.dart';
import '/widgets/book_card.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';

enum ContentCategory { cities, hobbies, books }

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  ContentCategory selectedCategory = ContentCategory.cities;
  String searchText = "";
  bool searchActive = false;
  final fieldText = TextEditingController();

  String get searchHint => "Search ${selectedCategory.name}";

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    // Create lists that are filtered based on the search text
    List filteredCities = favoritesProvider.cities
      .where((city) => city.cityName.toLowerCase().contains(searchText))
      .toList();

    List filteredHobbies = favoritesProvider.hobbies
      .where((hobby) => hobby.hobbyName.toLowerCase().contains(searchText))
      .toList();

    // Filter books based on title or author
    List filteredBooks = favoritesProvider.books
      .where(
        (book) =>
          (book.bookTitle.toLowerCase().contains(searchText) ||
          book.bookAuthor.toLowerCase().contains(searchText)),
      )
      .toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Create a segmented button to have 3 options: Cities, Hobbies, Books
              // Selecting each one will display the items in the respective category
              SegmentedButton(
                segments: [
                  ButtonSegment(
                    value: ContentCategory.cities,
                    label: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      child: Text("Cities"),
                    ),
                  ),
                  ButtonSegment(
                    value: ContentCategory.hobbies,
                    label: Text("Hobbies"),
                  ),
                  ButtonSegment(
                    value: ContentCategory.books,
                    label: Text("Books"),
                  ),
                ],
                selected: {selectedCategory},
                onSelectionChanged: (selection) {
                  setState(() {
                    selectedCategory = selection.first;
                    searchText = "";
                    fieldText.clear();
                    FocusScope.of(context).unfocus();
                  });
                },
                showSelectedIcon: false,
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Add search field that updates searchText and searchActive
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: searchHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value.toLowerCase();
                    (searchText != "")
                      ? searchActive = true
                      : searchActive = false;
                  });
                },
                controller: fieldText,
              ),

              SizedBox(height: 16),

              // Show items based on segmented button selection
              Expanded(
                child: Builder(
                  builder: (context) {
                    switch (selectedCategory) {
                      case ContentCategory.cities:
                        return ListView.builder(
                          // Use searchActive to determine whether to display a filtered list
                          // or the entire unfiltred list
                          itemCount: searchActive
                            ? filteredCities.length
                            : favoritesProvider.cities.length,
                          itemBuilder: (context, index) {
                            final city = searchActive
                              ? filteredCities[index]
                              : favoritesProvider.cities[index];
                            return CityCard(city: city);
                          },
                        );

                      case ContentCategory.hobbies:
                        return ListView.builder(
                          itemCount: searchActive
                            ? filteredHobbies.length
                            : favoritesProvider.hobbies.length,
                          itemBuilder: (context, index) {
                            final hobby = searchActive
                              ? filteredHobbies[index]
                              : favoritesProvider.hobbies[index];
                            return HobbyCard(hobby: hobby);
                          },
                        );

                      case ContentCategory.books:
                        return ListView.builder(
                          itemCount: searchActive
                            ? filteredBooks.length
                            : favoritesProvider.books.length,
                          itemBuilder: (context, index) {
                            final book = searchActive
                              ? filteredBooks[index]
                              : favoritesProvider.books[index];
                            return BookCard(book: book);
                          },
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
