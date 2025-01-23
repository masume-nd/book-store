import 'package:book_cart/models/book.dart';
import 'package:book_cart/widgets/settings_drawer.dart';
import 'package:flutter/material.dart';

class AddBookPage extends StatefulWidget {
  // Callback to pass the book data back
  const AddBookPage({super.key});

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String author = '';
  String description = '';
  String imageUrl = '';
  double price = 0.0;
  dynamic user;

  void handleAddBook(Book book) {
    // Handle the added book (e.g., add to a list or database)
    print('Book added: ${book.title}, ID: ${book.id}');
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Generate a unique ID (can use a package like uuid for better results)
      final id = DateTime.now().millisecondsSinceEpoch.toString();

      // Create a book object
      final newBook = Book(
        title,
        author,
        description,
        imageUrl,
        id,
        price,
        user,
      );

      // Pass the book back through the callback
      handleAddBook(newBook);

      // Clear the form
      _formKey.currentState!.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Book added successfully!')),
      );
    }
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) => title = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Author'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an author';
                    }
                    return null;
                  },
                  onSaved: (value) => author = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) => description = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an image URL';
                    }
                    return null;
                  },
                  onSaved: (value) => imageUrl = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onSaved: (value) => price = double.parse(value!),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'User'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a user';
                    }
                    return null;
                  },
                  onSaved: (value) => user = value, // Adjust based on user type
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Add Book'),
                ),
              ],
            ),
          ),
        ));
  }
}
