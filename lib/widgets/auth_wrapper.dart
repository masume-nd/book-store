import 'package:book_cart/utils/login.dart';
import 'package:flutter/material.dart';
import 'package:book_cart/screens/login.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isAuthenticated(), // Check if user is authenticated
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading indicator while checking
        }
        if (snapshot.hasData && snapshot.data == true) {
          return AlertDialog(
            title: const Text('Added to Cart'),
            content:
                const Text('The book has been added to your shopping cart.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/cart');
                },
                child: const Text('Show My Cart'),
              ),
            ],
          ); // Show Main Screen if authenticated
        } else {
          return const LoginPage(); // Show Login Screen if not authenticated
        }
      },
    );
  }

  // Function to check if the user is authenticated
}
