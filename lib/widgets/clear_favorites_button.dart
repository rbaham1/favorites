import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';

class ClearFavoritesButton extends StatelessWidget {
  const ClearFavoritesButton({super.key});

  @override
  Widget build(BuildContext context) {

    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Clear Favorites?"),
              content: Text("This action cannot be undone."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  child: Text("Cancel")
                ),
                TextButton(
                  onPressed: () {
                    favoritesProvider.clearFavorites();
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Confirm")
                )
              ],
            );
          }
        );
      }, 
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: Colors.red)
        ),
        minimumSize: Size.fromHeight(0),
        padding: EdgeInsets.all(10)
      ),
      child: Text("Clear Favorites"),
    );
  }
}