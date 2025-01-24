import 'package:book_cart/screens/about_us.dart';
import 'package:book_cart/screens/add_book.dart';
import 'package:book_cart/screens/books.dart';
import 'package:book_cart/screens/login.dart';
import 'package:book_cart/screens/my_books.dart';
import 'package:book_cart/screens/my_purchased.dart';
import 'package:book_cart/utils/login.dart';
import 'package:flutter/material.dart';
import '../widgets/book_list.dart';
import '../models/book.dart';
import '../widgets/settings_drawer.dart';
import '../apis/book_api.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPage = 0; // Keeps track of the selected tab
  bool isAuthenticatedUser = false;

  String _searchQuery = ''; // Holds the search query
  late List<Widget> _pages;
  // Function to filter books based on search query
  List<Book> _searchBooks(List<Book> books) {
    return books
        .where((book) =>
            book.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    super.initState();

    _initializeState(); // Async initialization
  }

  Future<void> _initializeState() async {
    await isAuth(); // Wait for authentication status
    setState(() {
      _pages = getPages(); // Generate pages after state update
    });
  }

  Future<void> isAuth() async {
    bool aa = await isAuthenticated();
    setState(() {
      isAuthenticatedUser = aa; // Update authentication state
    });
  }

  List<Widget> getPages() {
    List<Widget> pages = [BooksPage(), AboutUsScreen()];

    // Conditionally add LoginPage or MyBooksPage
    if (isAuthenticatedUser) {
      pages.insert(2, AddBookPage());
      pages.insert(3, MyPurchased());
      pages.insert(
          4, MyBooksPage()); // Insert MyBooksPage in the second position
    } else {
      pages.insert(2, LoginPage()); // Insert LoginPage in the second position
    }

    return pages;
  }

  void _onPageSelected(int page) {
    setState(() {
      _selectedPage = page; // Update the selected index when a tab is tapped
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPage,
        onTap: _onPageSelected,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Books',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'About us',
          ),
          if (isAuthenticatedUser)
            const BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Book',
            ),
          if (isAuthenticatedUser)
            const BottomNavigationBarItem(
              icon: Icon(Icons.done_all_rounded),
              label: 'Purchased',
            ),
          isAuthenticatedUser
              ? const BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book_sharp),
                  label: 'My Books',
                )
              : const BottomNavigationBarItem(
                  icon: Icon(Icons.login), label: 'Login')
        ],
      ),
    );
  }
}
