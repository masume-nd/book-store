import 'package:book_cart/models/book.dart';
import 'package:book_cart/models/user.dart';

class Cart {
  final List<Book> items;
  // final User user;
  final String? status;

  Cart({
    required this.items,
    // required this.user,
    this.status = 'pending', // Default status is 'pending'
  });
}

class CartResponse {
  final Cart cart;
  final int statusCode;

  CartResponse({required this.cart, required this.statusCode});
}

class Purchased {
  final String title;
  final double price;
  final String bookId;
  final String imageUrl;
  Purchased(
      {required this.title,
      required this.price,
      required this.bookId,
      required this.imageUrl});
}
