import 'dart:convert';
import 'dart:math';
import 'package:book_cart/models/user.dart';
import 'package:http/http.dart' as http;
import '../models/book.dart';

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
        bookData['user'],
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
