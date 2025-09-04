import 'package:book_cart/apis/book_api.dart';
import 'package:book_cart/models/cart.dart';
import 'package:book_cart/screens/edit_book.dart';
import 'package:book_cart/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookDetailPage extends StatefulWidget {
  final Book book;

  const BookDetailPage({required this.book, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late Future<bool> isInShoppingCart;

  @override
  void initState() {
    super.initState();
    isInShoppingCart = checkShoppingCartStatus();
  }

  Future<bool> checkShoppingCartStatus() async {
    try {
      final response = await getCart(); // Replace with your API call
      print(response);
      if (response.statusCode == 200) {
        final cartItems =
            response.cart.items; // Access items from your cart response
        return cartItems.any((item) => item.id == widget.book.id);
      } else {
        throw Exception('Failed to load cart items');
      }
    } catch (error) {
      debugPrint(error.toString());
      throw Exception('Failed to load cart items');
    }
  }

  Future<void> updateShoppingCart() async {
    try {
      final isInCart = await isInShoppingCart;

      if (isInCart) {
        // Remove the item from the cart
        final statusCode = await removeFromCart(widget.book.id);
        if (statusCode == 200 || statusCode == 201) {
          showSnackBar('Removed from Shopping Cart', Colors.green);
        } else {
          throw Exception('Failed to remove from shopping cart');
        }
      } else {
        // Add the item to the cart
        final statusCode = await addBookToCart(widget.book.id);
        if (statusCode == 200 || statusCode == 201) {
          showSnackBar('Added to Shopping Cart', Colors.green);
        } else {
          throw Exception('Failed to add to shopping cart');
        }
      }

      // Reload the cart status after updating
      setState(() {
        isInShoppingCart = checkShoppingCartStatus();
      });
    } catch (error) {
      debugPrint(error.toString());
      showSnackBar('Error: Failed to update cart', Colors.red);
    }
  }

  void showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.grey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Edit'),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateBookPage(book: widget.book),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the book image
                Image.network(
                  widget.book.imageUrl,
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),
                // Display the book details
                Row(
                  children: [
                    const Text(
                      'Author:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' ${widget.book.author}',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Description:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.book.description,
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Price: :',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' ${widget.book.price}',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                // ElevatedButton(
                //   onPressed: () async {
                //     // bool addToCart = await checkShoppingCartStatus();
                //     await updateShoppingCart();
                //   },
                //   style: ElevatedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 32, vertical: 12),
                //   ),
                //   child: FutureBuilder<bool>(
                //     future: isInShoppingCart,
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return const CircularProgressIndicator();
                //       } else if (snapshot.hasError) {
                //         return Text('Error: ${snapshot.error}');
                //       } else {
                //         return Text(snapshot.data == true
                //             ? 'Remove from Cart'
                //             : 'Add to Cart');
                //       }
                //     },
                //   ),
                // ),

                // Add to shopping cart button
                FutureBuilder<bool>(
                  future: isInShoppingCart,
                  builder: (context, snapshot) {
                    print(snapshot.error);
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(
                        'Error: ${snapshot.error ?? 'Something went wrong!'}',
                        style: const TextStyle(color: Colors.red),
                      );
                    } else {
                      final isInCart = snapshot.data ?? false;
                      return Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: updateShoppingCart,
                          child: Text(
                              isInCart ? 'Remove from Cart' : 'Add to Cart'),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
