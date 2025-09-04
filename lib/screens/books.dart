import 'package:book_cart/utils/login.dart';
import 'package:flutter/material.dart';
import '../widgets/book_list.dart';
import '../models/book.dart';
import '../widgets/settings_drawer.dart';
import '../apis/book_api.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  int _selectedIndex = 0; // Keeps track of the selected tab
  String _searchQuery = ''; // Holds the search query
  bool isAuthenticatedUser = false;

  // Function to filter books based on search query

  void initState() {
    super.initState();
    _initializeState(); // Async initialization
  }

  Future<void> _initializeState() async {
    await isAuth(); // Wait for authentication status
  }

  Future<void> isAuth() async {
    bool aa = await isAuthenticated();
    setState(() {
      isAuthenticatedUser = aa; // Update authentication state
    });
  }

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
        title: const Text('Book Store'),
        actions: [
          // Search bar in the AppBar
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
          if (isAuthenticatedUser)
            IconButton(
                onPressed: () async {
                  await removeToken();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                icon: const Icon(Icons.logout_outlined))
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
                future: fetchBooks(), // Call the function to fetch books
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<Book> books = snapshot.data ?? [];
                    List<Book> filteredBooks = _searchBooks(
                        books); // Filter books based on search query
                    return BookList(
                        books:
                            filteredBooks); // Pass the filtered list to BookList widget
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
