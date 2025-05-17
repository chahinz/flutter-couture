// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class TailorList extends StatefulWidget {
//   const TailorList({super.key});

//   @override
//   State<TailorList> createState() => _TailorListState();
// }

// class _TailorListState extends State<TailorList> {
//   final List<Map<String, String>> tailors = [
//     {
//       "name": "Ali Tailor",
//       "phone": "0654321897",
//       "address": "Alger, Algeria",
//       "subscription": "Premium",
//       "image": "assets/tailor1.jpg"
//     },
//     {
//       "name": "Sami Fashion",
//       "phone": "0776543210",
//       "address": "Oran, Algeria",
//       "subscription": "Standard",
//       "image": "assets/tailor2.jpg"
//     },
//     {
//       "name": "Lina Designs",
//       "phone": "0551234567",
//       "address": "Constantine, Algeria",
//       "subscription": "Basic",
//       "image": "assets/tailor3.jpg"
//     },
//     {
//       "name": "Hassan Couture",
//       "phone": "0669876543",
//       "address": "Annaba, Algeria",
//       "subscription": "Premium",
//       "image": "assets/tailor4.jpg"
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: tailors.length,
//         itemBuilder: (context, index) {
//           final tailor = tailors[index];
//           return Card(
//             elevation: 2,
//             margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: ListTile(
//               leading: CircleAvatar(
//                 radius: 30,
//                 backgroundImage: AssetImage(tailor["image"]!),
//               ),
//               title: Text(
//                 tailor["name"]!,
//                 style: GoogleFonts.poppins(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               subtitle: Text(
//                 "📞 ${tailor["phone"]}\n📍 ${tailor["address"]}\n⭐ Subscription: ${tailor["subscription"]}",
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                 ),
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

class TailorList extends StatefulWidget {
  const TailorList({super.key});

  @override
  State<TailorList> createState() => _TailorListState();
}

class _TailorListState extends State<TailorList> {
  List<Map<String, dynamic>> tailors = [];

  @override
  void initState() {
    super.initState();
    fetchTailors();
  }

  Future<void> fetchTailors() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('tailors').get();
      final data = snapshot.docs.map((doc) => doc.data()).toList();

      setState(() {
        tailors = data;
      });
    } catch (e) {
      print("Error fetching tailors: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tailors.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: tailors.length,
              itemBuilder: (context, index) {
                final tailor = tailors[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: tailor["imageUrl"] != null
                          ? NetworkImage(tailor["imageUrl"])
                          : const AssetImage("assets/default_tailor.jpg") as ImageProvider,
                    ),
                    title: Text(
                      tailor["username"] ?? "Unknown",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "📞 ${tailor["phoneNumber"] ?? "N/A"}\n📍 ${tailor["wilaya"] ?? "N/A"}",
                      //\n⭐ Subscription: ${tailor["subscription"] ?? "N/A"}
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
