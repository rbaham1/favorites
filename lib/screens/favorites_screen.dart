import 'package:flutter/material.dart';
import '../widgets/favorites_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Generate Favorites title
              Text("Favorites",
              textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: 24,),

              // Generate each category's favorites card
              Expanded(
                child: ListView(
                  children: [
                    FavoritesCard(category: ContentCategory.cities, title: "Cities",),
                    FavoritesCard(category: ContentCategory.hobbies, title: "Hobbies",),
                    FavoritesCard(category: ContentCategory.books, title: "Books"),
                  ],
                ),
              ),
            ],
          ),
        ) 
      )
    );
  }
}