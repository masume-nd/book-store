import 'package:flutter/material.dart';
import '../widgets/book_list.dart';
import '../models/book.dart';
import '../widgets/settings_drawer.dart';
import '../apis/book_api.dart';

class MyPurchased extends StatefulWidget {
  const MyPurchased({Key? key}) : super(key: key);

  @override
  _MyPurchasedState createState() => _MyPurchasedState();
}

class _MyPurchasedState extends State<MyPurchased> {
  String _searchQuery = ''; // Holds the search query

  // Function to filter books based on search query
  List<Book> _searchBooks(List<Book> books) {
    return books
        .where((book) =>
            book.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
        actions: [
          // Search bar in the AppBar
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      drawer: const SettingsDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (query) {
                  setState(() {
                    _searchQuery =
                        query; // Update the search query on input change
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Search books',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Book>>(
                future: fetchMyBooks(), // Call the function to fetch books
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  } else {
                    List<Book> books = snapshot.data ?? [];
                    List<Book> filteredBooks = _searchBooks(
                        books); // Filter books based on search query

                    if (filteredBooks.isEmpty) {
                      return const Center(
                        child: Text(
                          'No books found.',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }

                    return BookList(
                      books:
                          filteredBooks, // Pass the filtered list to BookList widget
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
