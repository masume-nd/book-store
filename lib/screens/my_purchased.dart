import 'package:book_cart/models/cart.dart';
import 'package:book_cart/screens/book_detail.dart';
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
  List<Purchased> _searchBooks(List<Purchased> books) {
    return books
        .where((book) =>
            book.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Purchased'),
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
              colors: [Colors.black, Colors.grey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: FutureBuilder<List<Purchased>>(
                future:
                    fetchPurchasedBooks(), // Call the function to fetch books
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  } else {
                    List<Purchased> books = snapshot.data ?? [];
                    List<Purchased> filteredBooks = _searchBooks(
                        books); // Filter books based on search query

                    if (filteredBooks.isEmpty) {
                      return const Center(
                        child: Text(
                          'No books found.',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemCount: filteredBooks.length,
                        itemBuilder: (context, index) {
                          final Purchased book = filteredBooks[index];
                          return ListTile(
                            leading: Image.network(book.imageUrl),
                            title: Text(book.title),
                            subtitle: Text('Price: \$${book.price}'),
                          );
                        },
                      ),
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
