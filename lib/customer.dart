// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CustomerScreen extends StatefulWidget {
//   @override
//   _CustomerScreenState createState() => _CustomerScreenState();
// }

// class _CustomerScreenState extends State<CustomerScreen> {
//   List<Map<String, dynamic>> customers = [
//     {"name": "Ali", "email": "ali@gmail.com", "location": "Algiers, Algeria", "orders": 5, "spent": "1200DA", "approved": false},
//     {"name": "Hassan", "email": "hassan@gmail.com", "location": "Oran, Algeria", "orders": 12, "spent": "3400DA", "approved": false},
//     {"name": "Meriem", "email": "meriem@gmail.com", "location": "Constantine, Algeria", "orders": 8, "spent": "2100DA", "approved": false},
//   ];

//   void toggleApproval(int index) {
//     setState(() {
//       customers[index]['approved'] = !customers[index]['approved'];
//     });
//   }

//   void deleteCustomer(int index) {
//     setState(() {
//       customers.removeAt(index);
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
//                       hintText: "Search customers...",
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
//                   style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 163, 119, 178)),
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
//                   Expanded(child: Text("Spent", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
//                   Expanded(child: Text("Actions", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: customers.length,
//                 itemBuilder: (context, index) {
//                   var customer = customers[index];
//                   return Container(
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(child: Text(customer['name'], style: GoogleFonts.poppins())),
//                         Expanded(child: Text(customer['email'], style: GoogleFonts.poppins())),
//                         Expanded(child: Text(customer['location'], style: GoogleFonts.poppins())),
//                         Expanded(child: Text(customer['orders'].toString(), style: GoogleFonts.poppins())),
//                         Expanded(child: Text(customer['spent'], style: GoogleFonts.poppins())),
//                         Expanded(
//                           child: Row(
//                             children: [
//                               IconButton(
//                                 icon: Icon(
//                                   Icons.check_circle,
//                                   color: customer['approved'] ? Colors.green : Colors.grey,
//                                 ),
//                                 onPressed: () => toggleApproval(index),
//                               ),
//                               SizedBox(width: 5),
//                               IconButton(
//                                 icon: Icon(
//                                   Icons.cancel,
//                                   color: Colors.red,
//                                 ),
//                                 onPressed: () => deleteCustomer(index),
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

class CustomerScreen extends StatefulWidget {
  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  List<Map<String, dynamic>> customer = [];

  @override
  void initState() {
    super.initState();
    fetchcustomer();
  }

  Future<void> fetchcustomer() async {
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('customer')
        // .orderBy('createdAt', descending: true)  
        .get();

    setState(() {
      customer = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  } catch (e) {
    print('Error fetching users: $e');
  }
}

  Future<void> toggleApproval(int index) async {
  String userId = customer[index]['id'];

  try {
    bool newApprovalStatus = !(customer[index]['approved'] ?? false);

    await FirebaseFirestore.instance.collection('customer').doc(userId).update({
      'status': newApprovalStatus ? 'approved' : 'rejected',
    });
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'status': newApprovalStatus ? 'approved' : 'rejected',
      });
    setState(() {
      customer[index]['approved'] = newApprovalStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(newApprovalStatus ? 'User $userId approved' : 'User $userId rejected')),
    );
  } catch (e) {
    print('Error updating approval status: $e');
  }
}

  Future<void> rejectUser(int index) async {
    String userId = customer[index]['id'];

    try {
      await FirebaseFirestore.instance.collection('customer').doc(userId).update({
        'status': 'rejected',
      });
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'status': 'rejected',
      });

      // setState(() {
      //   customer.removeAt(index);
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
        title: Text("Customer Management"),
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
                      hintText: "Search customer...",
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
                  Expanded(child: Text("Spent", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
                  Expanded(child: Text("Actions", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: customer.length,
                itemBuilder: (context, index) {
                  var customers = customer[index];
                  return Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(customers['username'] ?? 'no username available', style: GoogleFonts.poppins())),
                        Expanded(child: Text(customers['email'] ?? 'No email available', style: GoogleFonts.poppins())),
                        Expanded(child: Text(customers['address'] ?? 'No location available', style: GoogleFonts.poppins())),
                        Expanded(child: Text(customers['orders']?.toString() ?? '0', style: GoogleFonts.poppins())),
                        Expanded(child: Text(customers['Spent'] ?? '0 DA', style: GoogleFonts.poppins())),
                        Expanded(
                          child: Row(
                            children: [
                              
                              IconButton(
                                icon: Icon(
                                  Icons.check_circle,
                                  color: customers['status'] == 'approved' ? Colors.green : Colors.grey,
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
