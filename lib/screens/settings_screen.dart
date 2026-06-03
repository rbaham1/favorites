import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/clear_favorites_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text("Settings",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: 24,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dark Mode",
                    style: TextStyle(
                      fontSize: 18
                    )
                  ),
                  Switch(
                    value: favoritesProvider.isDarkMode, 
                    onChanged: (value) {
                      favoritesProvider.toggleDarkMode(value);
                    }
                  )
                ],
              ),

              SizedBox(height: 24,),
              
              ClearFavoritesButton()
            ],
          ),
        ) 
      )
    );
  }
}