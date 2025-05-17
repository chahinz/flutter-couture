

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerList extends StatefulWidget {
  final String tailorId; 

  const CustomerList({super.key, required this.tailorId});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  List<Map<String, dynamic>> followers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFollowers();
  }

  Future<void> fetchFollowers() async {
    final tailorDoc = await FirebaseFirestore.instance
        .collection('tailors')
        .doc(widget.tailorId)
        .get();

    final followerIds = List<String>.from(tailorDoc.data()?['followers'] ?? []);
    List<Map<String, dynamic>> fetchedFollowers = [];

    for (String userId in followerIds) {
      final userDoc = await FirebaseFirestore.instance
          .collection('customer')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data()!;
        fetchedFollowers.add({
          'name': data['username'] ?? 'Unknown',
          'image': data['profileImage'] ?? 'images/default.jpg',
        });
      }
    }

    setState(() {
      followers = fetchedFollowers;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : followers.isEmpty
              ? const Center(child: Text("No followers found."))
              : ListView.builder(
                  itemCount: followers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: followers[index]["image"].startsWith("http")
                            ? NetworkImage(followers[index]["image"])
                            : AssetImage(followers[index]["image"]) as ImageProvider,
                      ),
                      title: Text(
                        followers[index]["name"],
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
    );
  }
}
