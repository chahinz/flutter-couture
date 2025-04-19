import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> followers = [
      {"name": "Ismail", "image": "images/user1.jpg"},
      {"name": "Amira", "image": "images/user2.jpg"},
      {"name": "Khaled", "image": "images/user3.jpg"},
      {"name": "Sarah", "image": "images/user4.jpg"},
      {"name": "Omar", "image": "images/user5.jpg"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Customers",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: followers.map((follower) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(follower["image"]!),
              ),
              title: Text(
                follower["name"]!,
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
