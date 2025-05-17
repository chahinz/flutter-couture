// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CustomerList extends StatefulWidget {
//   const CustomerList({super.key});

//   @override
//   State<CustomerList> createState() => _CustomerListState();
// }

// class _CustomerListState extends State<CustomerList> {
//   final List<Map<String, String>> customers = [
//     {"name": "Ahmed", "phone": "0654321897", "address": "Alger, Algeria"},
//     {"name": "Youssef", "phone": "0776543210", "address": "Oran, Algeria"},
//     {"name": "Sara", "phone": "0551234567", "address": "Constantine, Algeria"},
//     {"name": "Fatima", "phone": "0669876543", "address": "Annaba, Algeria"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: customers.length,
//         itemBuilder: (context, index) {
//           final customer = customers[index];
//           return Card(
//             elevation: 2,
//             margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: ListTile(
//               leading: const CircleAvatar(
//                 backgroundColor: Color.fromARGB(255, 163, 119, 178),
//                 child: Icon(Icons.person, color: Colors.white),
//               ),
//               title: Text(
//                 customer["name"]!,
//                 style: GoogleFonts.poppins(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               subtitle: Text(
//                 "📞 ${customer["phone"]}\n📍 ${customer["address"]}",
//                 style: GoogleFonts.poppins(fontSize: 14),
//               ),
//               isThreeLine: true,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  List<Map<String, dynamic>> customers = [];

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  Future<void> fetchCustomers() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('customer').get();
      final data = snapshot.docs.map((doc) => doc.data()).toList();

      setState(() {
        customers = data;
      });
    } catch (e) {
      print("Error fetching customers: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customers.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 163, 119, 178),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(
                      customer["username"] ?? "Unknown",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "📞 ${customer["phone"] ?? "N/A"}\n📍 ${customer["address"] ?? "N/A"}",
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}
