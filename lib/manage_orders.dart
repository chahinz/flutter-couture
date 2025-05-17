// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'track_order.dart';
// import 'detail_page.dart';
// import 'leave_review.dart'; // Import LeaveReview page

// class ManageOrders extends StatefulWidget {
//   const ManageOrders({super.key});

//   @override
//   State<ManageOrders> createState() => _OrdersPageState();
// }

// class _OrdersPageState extends State<ManageOrders> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "My Orders",
//             style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.white,
//           elevation: 0,
//           bottom: TabBar(
//             indicatorColor: const Color.fromARGB(255, 163, 119, 178),
//             labelColor: const Color.fromARGB(255, 163, 119, 178),
//             unselectedLabelColor: Colors.black,
//             labelStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
//             tabs: const [
//               Tab(text: "Active"),
//               Tab(text: "Completed"),
//               Tab(text: "canceled"),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             OrdersList(orderType: "Active"),
//             OrdersList(orderType: "Completed"),
//             OrdersList(orderType: "canceled"),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OrdersList extends StatelessWidget {
//   final String orderType;
//   const OrdersList({super.key, required this.orderType});

//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, String>> orders = [
//       {
//         "title": "Karako",
//         "price": "11000 DA",
//         "image": "images/1.jpg",
//       },
//       {
//         "title": "Kafton",
//         "price": "50000 DA",
//         "image": "images/asset/2.jpg",
//       },
//       {
//         "title": "Skirt",
//         "price": "6000 DA",
//         "image": "images/asset/3.jpg",
//       },
//     ];

//     return ListView.builder(
//       padding: const EdgeInsets.all(10),
//       itemCount: orders.length,
//       itemBuilder: (context, index) {
//         final order = orders[index];
//         return Card(
//           elevation: 2,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//           child: ListTile(
//             contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//             leading: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.asset(
//                 order["image"]!,
//                 width: 60,
//                 height: 60,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             title: Text(
//               order["title"]!,
//               style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             subtitle: Text(
//               order["price"]!,
//               style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
//             ),
//             trailing: ElevatedButton(
//               onPressed: () {
//                 if (orderType == "Active") {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const TrackOrderPage()),
//                   );
//                 } else if (orderType == "canceled") {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DetailPage(
//                         tailorId: "",
//                         // imagePath: order["image"]!,
//                         modelId: "",
//                         title: order["title"]!,
//                         price: order["price"]!,
//                         description: "High-quality fabric with elegant design.",
//                         fabricType: "Silk",
//                         availableColors: [], // list of hex strings
//       availableSizes: [],
//                       ),
//                     ),
//                   );
//                 } else if (orderType == "Completed") {
//                   // ✅ Navigate to LeaveReview with correct parameters
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => LeaveReview(
//                         orderImage: order["image"]!,
//                         orderTitle: order["title"]!,
//                       ),
//                     ),
//                   );
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromARGB(255, 163, 119, 178),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//               ),
//               child: Text(
//                 orderType == "Completed" ? "Leave Review" :
//                 orderType == "canceled" ? "Re-Order" : "Track Order",
//                 style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }



//   Future<List<Map<String, dynamic>>> _fetchBookings() async {
//   final user = FirebaseAuth.instance.currentUser;

//   if (user == null) {
//     print("No user is currently signed in.");
//     return [];
//   }

//   print("Current User UID: ${user.uid}");

//   final querySnapshot = await FirebaseFirestore.instance
//       .collection('bookings')
//       .where('userId', isEqualTo: user.uid)
//       .where('status', isEqualTo: widget.orderType)
//       .get();

//   final bookings = querySnapshot.docs.map((doc) {
//     final data = doc.data();
//     data['id'] = doc.id;
//     print("Fetched Booking: ${data.toString()}"); 
//     return data;
//   }).toList();

//   print("Total Bookings Fetched: ${bookings.length}");

//   return bookings;
// }


/////////////////////////
///

// Future<List<Map<String, dynamic>>> _fetchBookings() async {
//   final user = FirebaseAuth.instance.currentUser;
//   if (user == null) {
//     print("No user is currently signed in.");
//     return [];
//   }

//   print("Current User UID: ${user.uid}");

//   final querySnapshot = await FirebaseFirestore.instance
//       .collection('bookings')
//       .where('userId', isEqualTo: user.uid)
//       .where('status', isEqualTo: widget.orderType)
//       .get();

//   final bookings = <Map<String, dynamic>>[];

//   for (final doc in querySnapshot.docs) {
//     final data = doc.data();
//     data['id'] = doc.id;

//     final modelId = data['modelId'];
//     String modelName = 'No Model Name';

//     if (modelId != null && modelId.isNotEmpty) {
//       try {
        
//         final modelSnapshot = await FirebaseFirestore.instance
//             .collection('models')
//             .doc(modelId)
//             .get();

//         if (modelSnapshot.exists) {
//           final modelData = modelSnapshot.data();
//           modelName = modelData?['name'] ?? 'Model';
//         } else {
//           modelName = 'Model ';
//           print("Model with ID $modelId not found.");
//         }
//       } catch (e) {
//         modelName = 'Error Loading Name';
//         print("Error fetching model name for ID $modelId: $e");
//       }
//     } else {
//       print("No valid modelId found for booking: ${doc.id}");
//     }

    
//     data['modelName'] = modelName; 
//     bookings.add(data);

//     print("Fetched booking: ${data['id']} with model name: $modelName");
//   }

//   return bookings;
// }


import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'track_order.dart';
import 'detail_page.dart';
import 'leave_review.dart';

class ManageOrders extends StatefulWidget {
  const ManageOrders({super.key});

  @override
  State<ManageOrders> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<ManageOrders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "My Orders",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: const Color.fromARGB(255, 163, 119, 178),
            labelColor: const Color.fromARGB(255, 163, 119, 178),
            unselectedLabelColor: Colors.black,
            labelStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
              Tab(text: "tailoring"),
              Tab(text: "completed"),
              Tab(text: "canceled"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            OrdersList(orderType: "tailoring"),
            OrdersList(orderType: "completed"),
            OrdersList(orderType: "canceled"),
          ],
        ),
      ),
    );
  }
}

class OrdersList extends StatefulWidget {
  final String orderType;
  const OrdersList({super.key, required this.orderType});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  late Future<List<Map<String, dynamic>>> _futureBookings;

  @override
  void initState() {
    super.initState();
    _futureBookings = _fetchBookings();
  }

Future<List<Map<String, dynamic>>> _fetchBookings() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    print("No user is currently signed in.");
    return [];
  }

  final querySnapshot = await FirebaseFirestore.instance
      .collection('bookings')
      .where('userId', isEqualTo: user.uid)
      .where('status', isEqualTo: widget.orderType)
      .get();

  final bookings = <Map<String, dynamic>>[];

  for (final doc in querySnapshot.docs) {
    final data = doc.data();
    data['id'] = doc.id;

    
    if (data['orderNumber'] == null || (data['orderNumber'] as String).isEmpty) {
      final generatedOrderNumber = _generateRandomOrderNumber();
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(doc.id)
          .update({'orderNumber': generatedOrderNumber});
      data['orderNumber'] = generatedOrderNumber;
    }

    final modelId = data['modelId'];

String modelName = 'No Model Name';

// if (modelId != null && modelId.isNotEmpty) {
//   try {
//     final modelQuery = await FirebaseFirestore.instance
//         .collection('models')
//         .where('idModel', isEqualTo: modelId)  
//         .limit(1)
//         .get();

//     if (modelQuery.docs.isNotEmpty) {
//       final modelData = modelQuery.docs.first.data();
//       modelName = modelData['name'] ?? 'Model';
//       data['imageUrl'] = modelData['imageUrl'] ?? '';
//     } else {
//       modelName = 'No Model Found';
//     }
//   } catch (e) {
//     modelName = 'Error Loading Name';
//   }
// }

if (modelId != null && modelId.isNotEmpty) {
  try {
    final modelQuery = await FirebaseFirestore.instance
        .collection('models')
        .where('idModel', isEqualTo: modelId)
        .limit(1)
        .get();

    if (modelQuery.docs.isNotEmpty) {
      final modelData = modelQuery.docs.first.data();
      modelName = modelData['name'] ?? 'Model';
      data['imageUrl'] = modelData['imageUrl'] ?? ''; // ✅ fetch imageUrl URL
    } else {
      modelName = 'No Model Found';
      data['imageUrl'] = '';
    }
  } catch (e) {
    modelName = 'Error Loading Name';
    data['imageUrl'] = '';
  }
}

data['modelName'] = modelName;



    data['colors'] = List<String>.from(data['colors'] ?? []);
    data['sizes'] = List<String>.from(data['sizes'] ?? []);

    bookings.add(data);
  }

  return bookings;
}


String _generateRandomOrderNumber() {
  final random = Random();
  const length = 8; 
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
}


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _futureBookings,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              "No ${widget.orderType} orders found.",
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          );
        }

        final orders = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 15),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    order["imageUrl"] ?? "",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.image_not_supported),
                  ),
                ),
                title: Text(
                  order["modelName"] ?? "No Title",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(
                  "${order["initialprice"] ?? "0"} DA",
                  style:
                      GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    if (widget.orderType == "tailoring") {
                     
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrackOrderPage(
                          orderData: {
                          "imageUrl": order["imageUrl"] ?? "",
                          "modelName": order["modelName"] ?? "No Title",
                          "modelId" : order["modelId"],
                          "initialprice": order["initialprice"] ?? "0",
                          "orderNumber": order["orderNumber"] ?? _generateRandomOrderNumber(),
                          "orderDate": order["createdAt"],
                          "address": order['wilaya'],
                          "size": order['sizes'],
                          "color": order['colors'],
                          "notes": order['note'],
                          "progres": order['progres'],  
                          "categoryId": order['categoryId'], 
                          "modifiedprice": order['modifiedprice'], 
                          "tailorId": order['tailorId'],
                          "userId": order['userId'],
                          "bookingId": order['id'],
                          "progress" : order['progress']
                          },
                        ),
                      ),
                    );
                    } else if (widget.orderType == "canceled") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            tailorId: order['tailorId'] ?? "",
                            modelId: order['modelId'] ?? "",
                            title: order['title'] ?? "",
                            price: order['price'] ?? "",
                            description: order['description'] ??
                                "",
                            fabricType: order['fabricType'] ?? "Unknown",
                            // availableColors: List<String>.from(order['availableColors'] ?? []),
                            // availableSizes: List<String>.from(order['availableSizes'] ?? []),
                            availableColors: List<String>.from(order['availableColors'] ?? []),
                            availableSizes: List<String>.from(order['availableSizes'] ?? []),
                          ),
                        ),
                      );
                    } else if (widget.orderType == "completed") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LeaveReview(
                            orderImage: order["imageUrl"] ?? "",
                            orderTitle: order["title"] ?? "",
                            tailorId: order['tailorId'] ?? "",
                            customerUid: FirebaseAuth.instance.currentUser?.uid ?? "",
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 163, 119, 178),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text(
                    widget.orderType == "completed"
                        ? "Leave Review"
                        : widget.orderType == "canceled"
                            ? "Re-Order"
                            : "Track Order",
                    style:
                        GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

