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
