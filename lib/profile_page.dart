import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'following_list.dart'; // Import the FollowingListPage
import 'settings_page.dart'; // Import the new SettingsPage

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Icon and Name
            Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 80,
                    color: Color.fromARGB(255, 163, 119, 178),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Ines', // Replace with actual name
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Email Section
            _buildSection(title: 'Email:', content: 'Ines25@gmail.com'),
            _buildDivider(),

            // Phone Number Section
            _buildSection(title: 'Phone Number:', content: '+2134567890'),
            _buildDivider(),

            // Address Section
            _buildSection(title: 'Address:', content: '1700, City, Country'),
            _buildDivider(),

            // Following List Button
            Center(child: _buildTextButton(context)),
          ],
        ),
      ),
    );
  }

  // Helper method to build sections
  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          content,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  // Helper method for divider
  Widget _buildDivider() {
    return const Divider(thickness: 1, height: 30);
  }

  // Following Button with Navigation
  Widget _buildTextButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FollowingList()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromARGB(255, 163, 119, 178), // Button color
        ),
        child: Text(
          "Following",
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
