import 'package:book_cart/models/book.dart';
import 'package:book_cart/models/user.dart';

class Cart {
  final Book? books;
  final User user;

  Cart(this.books, this.user);
}
