import 'package:book_cart/apis/book_api.dart';
import 'package:flutter/material.dart';
import '../models/book.dart';
import 'book_card.dart';

class MyBookList extends StatelessWidget {
  final List<Book> books;

  const MyBookList({required this.books, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(books[index].id), // Unique key for each book
          direction: DismissDirection.endToStart, // Swipe from right to left
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) async {
            // Handle removing the book from the list
            await removeBook(books[index].id);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${books[index].title} removed from cart'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 1),
              ),
            );
          },
          child: BookCard(book: books[index]), // Your custom book card widget
        );
      },
    );
  }
}
