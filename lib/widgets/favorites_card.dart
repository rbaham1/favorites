import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/favorites_expansion_tile.dart';
import '/widgets/city_card.dart';
import '/widgets/hobby_card.dart';
import '/widgets/book_card.dart';

enum ContentCategory {
  cities,
  hobbies,
  books
}

class FavoritesCard extends StatefulWidget {
  final ContentCategory category;
  final String title;
  const FavoritesCard({super.key, required this.category, required this.title});

  @override
  State<FavoritesCard> createState() => _FavoritesCardState();
}

class _FavoritesCardState extends State<FavoritesCard> {
  @override
  Widget build(BuildContext context) {

    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final List categoryList;

    switch(widget.category) {
      case ContentCategory.cities:
        categoryList = favoritesProvider.cities;
      case ContentCategory.hobbies:
        categoryList = favoritesProvider.hobbies;
      case ContentCategory.books:
        categoryList = favoritesProvider.books;
    }

    final favoritesList = categoryList.where((item) => item.isFavorite).toList();

    return FavoritesExpansionTile(
      title: Text(widget.title),
      childrenPadding: EdgeInsets.only(top: 16, bottom: 16),
      children: [ favoritesList.isEmpty ? 
        Row (
          mainAxisSize: MainAxisSize.min, 
          children: [
            Text(
              "Go to the browse tab to add favorites!",
              style: TextStyle(
                fontSize: 14
              ),
            ),
          ],
        ) : 
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: favoritesList.length,
          itemBuilder: (context, index) {
            final item = favoritesList[index];
            switch(widget.category) {
              case ContentCategory.cities:
                return CityCard(city: item);

              case ContentCategory.hobbies:
                return HobbyCard(hobby: item);

              case ContentCategory.books:
                return BookCard(book: item);
            }
          }
        ),
      ]
    );
  }
}