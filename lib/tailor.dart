// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class TailorScreen extends StatefulWidget {
//   @override
//   _TailorScreenState createState() => _TailorScreenState();
// }

// class _TailorScreenState extends State<TailorScreen> {
//   List<Map<String, dynamic>> tailors = [
//     {"name": "Ahmed", "email": "ahmed@gmail.com", "location": "Algiers, Algeria", "orders": 10, "subscription": "1 Month", "approved": false},
//     {"name": "Youssef", "email": "youssef@gmail.com", "location": "Oran, Algeria", "orders": 15, "subscription": "2 Months", "approved": false},
//     {"name": "Sara", "email": "sara@gmail.com", "location": "Constantine, Algeria", "orders": 7, "subscription": "Not Subscribed", "approved": false},
//   ];

//   void toggleApproval(int index) {
//     setState(() {
//       tailors[index]['approved'] = !tailors[index]['approved'];
//     });
//   }

//   Future<void> approveUser(String userId) async {
//   try {
//     await FirebaseFirestore.instance.collection('users').doc(userId).update({
//       'status': 'approved', 
//     });
//     await FirebaseFirestore.instance.collection('tailors').doc(userId).update({
//       'status': 'approved', 
//     });
//     print('User approved!');
//   } catch (e) {
//     print('Error approving user: $e');
//   }
// }
// Future<void> rejectUser(String userId) async {
//   try {
//     await FirebaseFirestore.instance.collection('users').doc(userId).update({
//       'status': 'rejected', 
//     });

//     await FirebaseFirestore.instance.collection('tailors').doc(userId).update({
//       'status': 'rejected', 
//     });

//     print('User rejected!');
//   } catch (e) {
//     print('Error rejecting user: $e');
//   }
// }


//   void deleteTailor(int index) {
//     setState(() {
//       tailors.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: "Search tailors...",
//                       hintStyle: GoogleFonts.poppins(),
//                       prefixIcon: Icon(Icons.search),
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 ElevatedButton.icon(
//                   onPressed: () {},
//                   icon: Icon(Icons.filter_list),
//                   label: Text(
//                     "Filter",
//                     style: GoogleFonts.poppins(color: Colors.white),
//                   ),
//                   style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 163, 119, 178)),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Container(
//               padding: EdgeInsets.all(10),
//               color: Colors.grey[300],
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(child: Text("Name", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
//                   Expanded(child: Text("Email", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
//                   Expanded(child: Text("Location", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
//                   Expanded(child: Text("Orders", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
//                   Expanded(child: Text("Subscription", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
//                   Expanded(child: Text("Actions", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: tailors.length,
//                 itemBuilder: (context, index) {
//                   var tailor = tailors[index];
//                   return Container(
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(child: Text(tailor['name'], style: GoogleFonts.poppins())),
//                         Expanded(child: Text(tailor['email'], style: GoogleFonts.poppins())),
//                         Expanded(child: Text(tailor['location'], style: GoogleFonts.poppins())),
//                         Expanded(child: Text(tailor['orders'].toString(), style: GoogleFonts.poppins())),
//                         Expanded(child: Text(tailor['subscription'], style: GoogleFonts.poppins())),
//                         Expanded(
//                           child: Row(
//                             children: [
//                               IconButton(
//                                 icon: Icon(
//                                   Icons.check_circle,
//                                   color: tailor['approved'] ? Colors.green : Colors.grey,
//                                 ),
//                                 onPressed: () => toggleApproval(index),
//                               ),
//                               SizedBox(width: 5),
//                               IconButton(
//                                 icon: Icon(
//                                   Icons.cancel,
//                                   color: Colors.red,
//                                 ),
//                                 onPressed: () => deleteTailor(index),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TailorScreen extends StatefulWidget {
  @override
  _TailorScreenState createState() => _TailorScreenState();
}

class _TailorScreenState extends State<TailorScreen> {
  List<Map<String, dynamic>> tailors = [];

  @override
  void initState() {
    super.initState();
    fetchTailors();
  }

  Future<void> fetchTailors() async {
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('tailors')
        .orderBy('createdAt', descending: true)  
        .get();

    setState(() {
      tailors = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  } catch (e) {
    print('Error fetching users: $e');
  }
}

  Future<void> toggleApproval(int index) async {
  String userId = tailors[index]['id'];

  try {
    bool newApprovalStatus = !(tailors[index]['approved'] ?? false);

    await FirebaseFirestore.instance.collection('tailors').doc(userId).update({
      'status': newApprovalStatus ? 'approved' : 'rejected',
    });
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'status': newApprovalStatus ? 'approved' : 'rejected',
      });
    setState(() {
      tailors[index]['approved'] = newApprovalStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(newApprovalStatus ? 'User $userId approved' : 'User $userId rejected')),
    );
  } catch (e) {
    print('Error updating approval status: $e');
  }
}

  Future<void> rejectUser(int index) async {
    String userId = tailors[index]['id'];

    try {
      await FirebaseFirestore.instance.collection('tailors').doc(userId).update({
        'status': 'rejected',
      });
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'status': 'rejected',
      });

      // setState(() {
      //   tailors.removeAt(index);
      // });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Request Rejected"),
            content: Text("The user request has been rejected."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error rejecting user: $e');
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tailor Management"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search tailors...",
                      hintStyle: GoogleFonts.poppins(),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.filter_list),
                  label: Text(
                    "Filter",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 163, 119, 178)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text("Name", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
                  Expanded(child: Text("Email", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
                  Expanded(child: Text("Location", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
                  Expanded(child: Text("Orders", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
                  Expanded(child: Text("Business Type", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
                  Expanded(child: Text("Actions", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: tailors.length,
                itemBuilder: (context, index) {
                  var tailor = tailors[index];
                  return Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(tailor['username'] ?? 'No name available', style: GoogleFonts.poppins())),
                        Expanded(child: Text(tailor['email'] ?? 'No email available', style: GoogleFonts.poppins())),
                        Expanded(child: Text(tailor['wilaya'] ?? 'No location available', style: GoogleFonts.poppins())),
                        Expanded(child: Text(tailor['orders']?.toString() ?? '0', style: GoogleFonts.poppins())),
                        Expanded(child: Text(tailor['businessType'] ?? 'no business type available', style: GoogleFonts.poppins())),
                        Expanded(
                          child: Row(
                            children: [
                              
                              IconButton(
                                icon: Icon(
                                  Icons.check_circle,
                                  color: tailor['status'] == 'approved' ? Colors.green : Colors.grey,
                                ),
                                onPressed: () => toggleApproval(index),
                              ),
                              SizedBox(width: 5),
                              
                              IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                                onPressed: () => rejectUser(index),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
