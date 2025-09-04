import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            const Center(
              child: Text(
                'Welcome to Our App!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16.0),

            // Description Section
            const Text(
              'Welcome to Book Store, your ultimate destination for discovering and purchasing a wide range of books! We believe in the power of books to inspire, inform, and transform lives. Whether you’re a casual reader, an avid bibliophile, or someone looking for the perfect gift, we’ve curated a diverse selection of books across all genres to meet your needs.'
              'At Book Store, we strive to make reading accessible to everyone. Our easy-to-use platform allows you to browse books, check reviews, and make secure purchases from the comfort of your home. We understand that every reader has unique tastes, which is why we offer personalized recommendations and an ever-growing collection of new releases, bestsellers, and timeless classics.'
              'Our mission is to create a community of passionate readers who share a love for literature. We’re not just about selling books; we’re here to foster a love for reading, learning, and self-improvement.'
              'Thank you for choosing [Your Bookstore Name]. We’re excited to be part of your literary journey, and we hope you find your next favorite book with us!',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 24.0),

            // Team Section (Optional)
            Text(
              'Meet Our Team',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTeamMember('assets/alice.jpeg', 'Alice'),
                _buildTeamMember('assets/bob.jpeg', 'Bob'),
                _buildTeamMember('assets/charlie.jpeg', 'Charlie'),
              ],
            ),
            SizedBox(height: 24.0),

            // Features Section (Optional)
            Text(
              'Key Features',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            _buildFeatureItem(Icons.check_circle, 'User-Friendly Interface'),
            _buildFeatureItem(Icons.security, 'Top-Notch Security'),
            _buildFeatureItem(Icons.speed, 'High Performance'),
            const SizedBox(height: 24.0),

            // Contact Section
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'If you have any questions or feedback, feel free to reach out to us at support@example.com.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Team Members
  Widget _buildTeamMember(String imagePath, String name) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40.0,
          backgroundImage: AssetImage(imagePath),
        ),
        const SizedBox(height: 8.0),
        Text(
          name,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Helper Widget for Features
  Widget _buildFeatureItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8.0),
          Text(
            title,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
