import 'package:flutter/material.dart';
import 'package:favorites/models/book_model.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';

class BookCard extends StatelessWidget {
  final BookModel book;
  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.all(0),
      child: ListTile(
        title: Text(book.bookTitle),
        subtitle: Text(book.bookAuthor),
        trailing: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  context.read<FavoritesProvider>()
                  .toggleBookFavorite(book.id);
                }, 
                icon: Icon(
                  book.isFavorite ? 
                  Icons.favorite : 
                  Icons.favorite_border,
                  color: book.isFavorite ? Colors.red : Theme.of(context).unselectedWidgetColor,
                )
              )
            ],
          ),
          contentPadding: EdgeInsets.all(12),
        ),
    );
  }
}