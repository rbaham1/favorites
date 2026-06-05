import 'package:flutter/material.dart';
import 'package:favorites/models/hobby_model.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';

class HobbyCard extends StatelessWidget {
  final HobbyModel hobby;
  const HobbyCard({super.key, required this.hobby});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.all(12),
      child: Row(
        children: [
          // Display hobby name and icon
          Expanded(child: 
            Row(
              children: [
                Text("${hobby.hobbyIcon} ${hobby.hobbyName}",
                  style: TextStyle(
                    fontSize: 16
                  )
                )
              ],
            )
          ),
          // Favorite button
          IconButton(
            onPressed: () {
              context.read<FavoritesProvider>().toggleHobbyFavorite(hobby.id);
            }, 
            icon: Icon(
              hobby.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: hobby.isFavorite
                ? Colors.red
                : Theme.of(context).unselectedWidgetColor,
            )
          )
        ],
      )
    );
  }
}