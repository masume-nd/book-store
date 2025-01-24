import 'dart:convert';
import 'dart:math';
import 'package:book_cart/models/cart.dart';
import 'package:book_cart/models/user.dart';
import 'package:http/http.dart' as http;
import '../models/book.dart';
import '../utils/login.dart';

const String basePath = 'http://localhost:8000/api';
Future<List<Book>> fetchBooks() async {
  final Uri uri = Uri.parse('$basePath/books');
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);

    List<Book> books = data.map((bookData) {
      return Book(
        bookData['title'],
        bookData['author'],
        bookData['description'],
        bookData['imageUrl'],
        bookData['_id'],
        bookData['price'],
        // bookData['user'],
      );
    }).toList();

    return books;
  } else {
    throw Exception('Failed to load books');
  }
}

Future<List<Book>> fetchMyBooks() async {
  final Uri uri = Uri.parse('$basePath/mybooks');
  final response =
      await http.get(uri, headers: {'Authorization': await getToken() ?? ''});
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);

    List<Book> books = data.map((bookData) {
      return Book(
        bookData['title'],
        bookData['author'],
        bookData['description'],
        bookData['imageUrl'],
        bookData['_id'],
        bookData['price'],
        // bookData['user'],
      );
    }).toList();

    return books;
  } else {
    throw Exception('Failed to load books');
  }
}

Future<int> registerUser(String username, String password) async {
  final Uri uri = Uri.parse('$basePath/users/register');

  final response = await http.post(uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username,
        'password': password,
      }));

  return response.statusCode;
}

Future<Map<String, dynamic>> loginUser(String username, String password) async {
  final Uri uri = Uri.parse('$basePath/users/login');

  final response = await http.post(uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username,
        'password': password,
      }));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return {
      'token': data['token'],
      'statusCode': response.statusCode,
    }; // Return the token and status code from the response
  } else {
    return {
      'token': null,
      'statusCode': response.statusCode,
    }; // Return null token and status code from the response
  }
}

Future<int> addBook(Book book) async {
  String token = await getToken() ?? '';

  final Uri uri = Uri.parse('$basePath/books');
  final response = await http.post(uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: json.encode({
        'title': book.title,
        'author': book.author,
        'description': book.description,
        'imageUrl': book.imageUrl,
        'price': book.price,
      }));

  return response.statusCode;
}

Future<int> updateBook(Book book) async {
  String token = await getToken() ?? '';

  final Uri uri = Uri.parse('$basePath/books/${book.id}');
  final response = await http.put(uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: json.encode({
        'title': book.title,
        'author': book.author,
        'description': book.description,
        'imageUrl': book.imageUrl,
        'price': book.price,
      }));

  return response.statusCode;
}

Future<CartResponse> getCart() async {
  String token = await getToken() ?? '';

  final Uri uri = Uri.parse('$basePath/cart');
  final response = await http.get(uri, headers: {'Authorization': token});
  // print(response.body);
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body)['cart'];

    List<Book> books = (data['items'] as List).map((el) {
      var bookData = el['bookId'];
      return Book(
        bookData['title'],
        bookData['author'],
        bookData['description'],
        bookData['imageUrl'],
        bookData['_id'],
        bookData['price'],
      );
    }).toList();
    print(books);
    Cart cart = Cart(
      items: books,
      status: data['status'] ?? 'pending',
    );

    // Return CartResponse
    return CartResponse(cart: cart, statusCode: response.statusCode);
  } else {
    throw Exception('Failed to load cart, Status Code: ${response.statusCode}');
  }
}

Future<int> addBookToCart(String bookId) async {
  String token = await getToken() ?? '';
  final Uri uri = Uri.parse('$basePath/cart');

  final response = await http.post(
    uri,
    body: jsonEncode({
      'bookId': bookId,
      'quantity': 1,
    }),
    headers: {'Content-Type': 'application/json', 'Authorization': token},
  );

  return response.statusCode;
}

Future<int> removeFromCart(String bookId) async {
  String token = await getToken() ?? '';

  final Uri uri = Uri.parse('$basePath/cart/items/1/');
  final response = await http.post(uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: json.encode({
        'book_id': bookId,
        'add_to_cart': false,
      }));

  return response.statusCode;
}

Future<int> updateCart() async {
  String token = await getToken() ?? '';

  final Uri uri = Uri.parse('$basePath/cart/checkout');
  final response = await http.put(
    uri,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    },
  );
  
  return response.statusCode;
}
