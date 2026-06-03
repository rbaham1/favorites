import 'package:flutter/material.dart';
import '/widgets/city_card.dart';
import '/widgets/hobby_card.dart';
import '/widgets/book_card.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';

enum ContentCategory {
  cities,
  hobbies,
  books
}

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  ContentCategory selectedCategory = ContentCategory.cities;
  String searchText = "";

  String get searchHint => "Search ${selectedCategory.name}";

  @override
  Widget build(BuildContext context) {

    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [

              SegmentedButton(
                segments: [
                  ButtonSegment(
                    value: ContentCategory.cities,
                    label: Text("Cities")
                  ),
                  ButtonSegment(
                    value: ContentCategory.hobbies,
                    label: Text("Hobbies")
                  ),
                  ButtonSegment(
                    value: ContentCategory.books,
                    label: Text("Books")
                  )
                ], 
                selected: {selectedCategory},
                onSelectionChanged: (selection) {
                  setState(() {
                    selectedCategory = selection.first;
                  });
                },
              ),

              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: searchHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),
                onChanged: (value) {
                  searchText = value;
                },
              ),

              SizedBox(height: 16,),

              Expanded(
                child: 
                Builder(
                  builder: (context) {
                    switch(selectedCategory) {
                      case ContentCategory.cities:
                        return ListView.builder(
                          itemCount: favoritesProvider.cities.length,
                          itemBuilder: (context, index) {
                            final city = favoritesProvider.cities[index];
                            return CityCard(city: city);
                          }
                        );
                      case ContentCategory.hobbies:
                        return ListView.builder(
                          itemCount: favoritesProvider.hobbies.length,
                          itemBuilder: (context, index) {
                            final hobby = favoritesProvider.hobbies[index];
                            return HobbyCard(hobby: hobby);
                          }
                        );
                      case ContentCategory.books:
                        return ListView.builder(
                          itemCount: favoritesProvider.books.length,
                          itemBuilder: (context, index) {
                            final book = favoritesProvider.books[index];
                            return BookCard(book: book);
                          }
                        );
                    }
                  })
                // 
              )
            ],
          )
        )
      )
    );
  }
}