// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'update_order.dart';
// import 'requested_order_page.dart';
// import '../models/post_model.dart';
// import '../models/bookins.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';


// class ManageOrders extends StatefulWidget {
//   const ManageOrders({super.key});

//   @override
//   State<ManageOrders> createState() => _OrdersPageState();
// }

// Future<List<Booking>> fetchTailorBookings(String tailorId, String statusFilter) async {
//   final querySnapshot = await FirebaseFirestore.instance
//       .collection('bookings')
//       .where('tailorId', isEqualTo: tailorId)
//       .where('status', isEqualTo: statusFilter) 
//       .get();

//   return querySnapshot.docs.map((doc) => Booking.fromFirestore(doc)).toList();
// }

// class _OrdersPageState extends State<ManageOrders> {
//   String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4, 
//       child: Scaffold(
//         appBar: AppBar(
//           title: Center(
//             child: Text(
//               "My Orders",
//               style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           backgroundColor: const Color.fromARGB(255, 245, 243, 249),
//           foregroundColor: Colors.black,
//           bottom: TabBar(
//             indicatorColor: Color.fromARGB(255, 163, 119, 178), // Tab indicator color
//             labelColor: Color.fromARGB(255, 163, 119, 178), // Text color when selected
//             unselectedLabelColor: Colors.black, // Text color when unselected
//             labelStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
//             tabs: const [
//               Tab(text: "Received"), // Received orders
//               Tab(text: "Tailoring"), // Orders in tailoring process
//               Tab(text: "Completed"), // Completed orders
//               Tab(text: "Canceled"), // Canceled orders
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             OrdersList(orderType: "view Request"), // List of received orders
//             OrdersList(orderType: "Update"), // List of orders that can be updated
//             OrdersList(orderType: "Review"), // List of completed orders
//             OrdersList(orderType: "Canceled"), // List of canceled orders
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OrdersList extends StatefulWidget {
//   final String orderType;
//   const OrdersList({super.key, required this.orderType , });

//   @override
//   State<OrdersList> createState() => _OrdersListState();
// }

// class _OrdersListState extends State<OrdersList> {
//   // Sample list of orders
//   final List<Map<String, String>> orders = [
//     {
//       "title": "Karako",
//       "price": "21000 DA",
//       "image": "images/1.jpg",
//       "color": "Blue",
//       "size": "Large",
//       "notes": "Add silver embroidery"
//     },
   
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(10),
//       itemCount: orders.length, // Number of orders
//       itemBuilder: (context, index) {
//         final order = orders[index];
//         return ListTile(
//           contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//           leading: ClipRRect(
//             borderRadius: BorderRadius.circular(10), // Rounded image shape
//             child: Image.asset(
//               order["image"]!,
//               width: 80,
//               height: 80,
//               fit: BoxFit.cover,
//             ),
//           ),
//           title: Text(
//             order["title"]!,
//             style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
//           ),
//           subtitle: Text(
//             order["price"]!,
//             style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
//           ),
//           trailing: (widget.orderType == "Update" || widget.orderType == "view Request")
//               ? ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color.fromARGB(255, 163, 119, 178),
//                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   ),
//                   onPressed: () {
//                     if (widget.orderType == "Update") {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => UpdateOrderPage(
//                             title: order["title"]!,
//                             price: order["price"]!,
//                             image: order["image"]!,
//                             color: order["color"]!,
//                             size: order["size"]!,
//                             notes: order["notes"]!,
//                           ),
//                         ),
//                       );
//                     } else if (widget.orderType == "view Request") {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => RequestedOrderPage(
//                             title: order["title"]!,
//                             price: order["price"]!,
//                             image: order["image"]!,
//                             color: order["color"]!,
//                             size: order["size"]!,
//                             notes: order["notes"]!,
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                   child: Text(
//                     widget.orderType,
//                     style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
//                   ),
//                 )
//               : null,
//         );
//       },
//     );
//   }
// }




///////
///
///

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'update_order.dart';
// import 'requested_order_page.dart';
// import '../models/post_model.dart';
// import '../models/bookins.dart'; 

// class ManageOrders extends StatefulWidget {
//   const ManageOrders({super.key});

//   @override
//   State<ManageOrders> createState() => _OrdersPageState();
// }

// class _OrdersPageState extends State<ManageOrders> {
//   final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Center(
//             child: Text(
//               "My Orders",
//               style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           backgroundColor: const Color.fromARGB(255, 245, 243, 249),
//           foregroundColor: Colors.black,
//           bottom: TabBar(
//             indicatorColor: const Color.fromARGB(255, 163, 119, 178),
//             labelColor: const Color.fromARGB(255, 163, 119, 178),
//             unselectedLabelColor: Colors.black,
//             labelStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
//             tabs: const [
//               Tab(text: "Received"),
//               Tab(text: "Tailoring"),
//               Tab(text: "Completed"),
//               Tab(text: "Canceled"),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             OrdersList(orderType: "view Request", statusFilter: "requested"),
//             OrdersList(orderType: "Update", statusFilter: "Tailoring"),
//             OrdersList(orderType: "Review", statusFilter: "Completed"),
//             OrdersList(orderType: "Canceled", statusFilter: "Canceled"),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OrdersList extends StatefulWidget {
//   final String orderType;
//   final String statusFilter;

//   const OrdersList({
//     super.key,
//     required this.orderType,
//     required this.statusFilter,
//   });

//   @override
//   State<OrdersList> createState() => _OrdersListState();
// }

// class _OrdersListState extends State<OrdersList> {
//   late Future<List<Map<String, dynamic>>> ordersFuture;

//   @override
//   void initState() {
//     super.initState();
//     ordersFuture = fetchBookingsWithModelData(
//       FirebaseAuth.instance.currentUser!.uid,
//       widget.statusFilter,
//     );
//   }

//   Future<List<Map<String, dynamic>>> fetchBookingsWithModelData(
//       String tailorId, String statusFilter) async {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('bookings')
//         .where('tailorId', isEqualTo: tailorId)
//         .where('status', isEqualTo: statusFilter)
//         .get();

//     List<Map<String, dynamic>> orders = [];

//     for (var doc in querySnapshot.docs) {
//       final booking = Booking.fromFirestore(doc);
//       final modelDoc = await FirebaseFirestore.instance
//           .collection('models')
//           .doc(booking.modelId)
//           .get();

//       if (modelDoc.exists) {
//         final post = Post.fromJson(modelDoc.data()!);
//         orders.add({
//           'booking': booking,
//           'model': post,
//         });
//       }
//     }

//     return orders;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Map<String, dynamic>>>(
//       future: ordersFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (snapshot.hasError) {
//           return Center(child: Text("Error: ${snapshot.error}"));
//         }

//         final orders = snapshot.data ?? [];

//         if (orders.isEmpty) {
//           return const Center(child: Text("No orders found."));
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.all(10),
//           itemCount: orders.length,
//           itemBuilder: (context, index) {
//             final booking = orders[index]['booking'] as Booking;
//             final model = orders[index]['model'] as Post;

//             return ListTile(
//               contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//               leading: Container(
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(Icons.image, size: 40), // replace with image preview if needed
//               ),
//               title: Text(
//                 model.title,
//                 style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               subtitle: Text(
//                 "${booking.modifiedprice} DA",
//                 style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
//               ),
//               trailing: (widget.orderType == "Update" || widget.orderType == "view Request")
//                   ? ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color.fromARGB(255, 163, 119, 178),
//                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                       ),
//                       onPressed: () {
//                         if (widget.orderType == "Update") {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => UpdateOrderPage(
//                                 title: model.title,
//                                 price: booking.modifiedprice,
//                                 image: '', // Add image URL if you use one
//                                 color: booking.colors.join(', '),
//                                 size: booking.sizes.join(', '),
//                                 notes: booking.note,
//                               ),
//                             ),
//                           );
//                         } else {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => RequestedOrderPage(
//                                 title: model.title,
//                                 price: booking.intialprice,
//                                 image: '', // Add image URL if needed
//                                 color: booking.colors.join(', '),
//                                 size: booking.sizes.join(', '),
//                                 notes: booking.note,
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                       child: Text(
//                         widget.orderType,
//                         style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
//                       ),
//                     )
//                   : null,
//             );
//           },
//         );
//       },
//     );
//   }
// }



////////////////////


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'update_order.dart';
// import 'requested_order_page.dart';
// import '../models/post_model.dart';
// import '../models/bookins.dart'; 

// class ManageOrders extends StatefulWidget {
//   const ManageOrders({super.key});

//   @override
//   State<ManageOrders> createState() => _OrdersPageState();
// }

// class _OrdersPageState extends State<ManageOrders> {
//   final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Center(
//             child: Text(
//               "My Orders",
//               style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           backgroundColor: const Color.fromARGB(255, 245, 243, 249),
//           foregroundColor: Colors.black,
//           bottom: TabBar(
//             indicatorColor: const Color.fromARGB(255, 163, 119, 178),
//             labelColor: const Color.fromARGB(255, 163, 119, 178),
//             unselectedLabelColor: Colors.black,
//             labelStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
//             tabs: const [
//               Tab(text: "Received"),
//               Tab(text: "Tailoring"),
//               Tab(text: "Completed"),
//               Tab(text: "Canceled"),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             OrdersList(orderType: "view Request", statusFilter: "requested"),
//             OrdersList(orderType: "Update", statusFilter: "Tailoring"),
//             OrdersList(orderType: "Review", statusFilter: "Completed"),
//             OrdersList(orderType: "Canceled", statusFilter: "Canceled"),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OrdersList extends StatefulWidget {
//   final String orderType;
//   final String statusFilter;

//   const OrdersList({
//     super.key,
//     required this.orderType,
//     required this.statusFilter,
//   });

//   @override
//   State<OrdersList> createState() => _OrdersListState();
// }

// class _OrdersListState extends State<OrdersList> {
//   late Future<List<Map<String, dynamic>>> ordersFuture;

//   @override
//   void initState() {
//     super.initState();
//     ordersFuture = fetchBookingsWithModelData(
//       FirebaseAuth.instance.currentUser!.uid,
//       widget.statusFilter,
//     );
//   }

//   Future<List<Map<String, dynamic>>> fetchBookingsWithModelData(
//       String tailorId, String statusFilter) async {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('bookings')
//         .where('tailorId', isEqualTo: tailorId)
//         .where('status', isEqualTo: statusFilter)
//         .get();

//     List<Map<String, dynamic>> orders = [];

//     for (var doc in querySnapshot.docs) {
//       final booking = Booking.fromFirestore(doc);
//       final modelDoc = await FirebaseFirestore.instance
//           .collection('models')
//           .doc(booking.modelId)
//           .get();

//       if (modelDoc.exists) {
//         final post = Post.fromJson(modelDoc.data()!);
//         orders.add({
//           'booking': booking,
//           'model': post,
//         });
//       }
//     }

//     return orders;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Map<String, dynamic>>>( 
//       future: ordersFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (snapshot.hasError) {
//           return Center(child: Text("Error: ${snapshot.error}"));
//         }

//         final orders = snapshot.data ?? [];

//         if (orders.isEmpty) {
//           return const Center(child: Text("No orders found."));
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.all(10),
//           itemCount: orders.length,
//           itemBuilder: (context, index) {
//             final booking = orders[index]['booking'] as Booking;
//             final model = orders[index]['model'] as Post;

//             return ListTile(
//               contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//               leading: Container(
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(Icons.image, size: 40), // Add image URL if you use one
//               ),
//               title: Text(
//                 model.name,
//                 style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               subtitle: Text(
//                 "${booking.modifiedprice} DA",
//                 style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
//               ),
//               trailing: (widget.orderType == "Update" || widget.orderType == "view Request")
//                   ? ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color.fromARGB(255, 163, 119, 178),
//                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                       ),
//                       onPressed: () {
//                         if (widget.orderType == "Update") {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => UpdateOrderPage(
//                                 title: model.name,
//                                 price: booking.modifiedprice,
//                                 image: '', // Add image URL if you use one
//                                 color: booking.colors.join(', '),
//                                 size: booking.sizes.join(', '),
//                                 notes: booking.note,
//                               ),
//                             ),
//                           );
//                         } else {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => RequestedOrderPage(
//                                 title: model.name,
//                                 price: booking.intialprice,
//                                 image: '', // Add image URL if needed
//                                 color: booking.colors.join(', '),
//                                 size: booking.sizes.join(', '),
//                                 notes: booking.note,
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                       child: Text(
//                         widget.orderType,
//                         style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
//                       ),
//                     )
//                   : null,
//             );
//           },
//         );
//       },
//     );
//   }
// }


///////////////////////////
///
///
///
///
///
// /// updated code with pics
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'update_order.dart';
// import 'requested_order_page.dart';
// import '../models/post_model.dart';
// import '../models/bookins.dart';

// class ManageOrders extends StatefulWidget {
//   const ManageOrders({super.key});

//   @override
//   State<ManageOrders> createState() => _ManageOrdersState();
// }

// class _ManageOrdersState extends State<ManageOrders> {
//   final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Center(
//             child: Text(
//               "My Orders",
//               style: GoogleFonts.poppins(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           backgroundColor: const Color.fromARGB(255, 245, 243, 249),
//           foregroundColor: Colors.black,
//           bottom: TabBar(
//             indicatorColor: const Color.fromARGB(255, 163, 119, 178),
//             labelColor: const Color.fromARGB(255, 163, 119, 178),
//             unselectedLabelColor: Colors.black,
//             labelStyle: GoogleFonts.poppins(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//             tabs: const [
//               Tab(text: "Received"),
//               Tab(text: "Tailoring"),
//               Tab(text: "Completed"),
//               Tab(text: "Canceled"),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             OrdersList(orderType: "view Request", statusFilter: "requested"),
//             OrdersList(orderType: "Update", statusFilter: "Tailoring"),
//             OrdersList(orderType: "Review", statusFilter: "Completed"),
//             OrdersList(orderType: "Canceled", statusFilter: "Canceled"),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OrdersList extends StatefulWidget {
//   final String orderType;
//   final String statusFilter;

//   const OrdersList({
//     super.key,
//     required this.orderType,
//     required this.statusFilter,
//   });

//   @override
//   State<OrdersList> createState() => _OrdersListState();
// }

// class _OrdersListState extends State<OrdersList> {
//   late Future<List<Map<String, dynamic>>> ordersFuture;

//   @override
//   void initState() {
//     super.initState();
//     ordersFuture = fetchBookingsWithModelData(
//       FirebaseAuth.instance.currentUser!.uid,
//       widget.statusFilter,
//     );
//   }

//   Future<List<Map<String, dynamic>>> fetchBookingsWithModelData(
//       String tailorId, String statusFilter) async {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('bookings')
//         .where('tailorId', isEqualTo: tailorId)
//         .where('status', isEqualTo: statusFilter)
//         .get();

//     List<Map<String, dynamic>> orders = [];

//     for (var doc in querySnapshot.docs) {
//       final booking = Booking.fromFirestore(doc);
//       final modelDoc = await FirebaseFirestore.instance
//           .collection('models')
//           .doc(booking.modelId)
//           .get();

//       if (modelDoc.exists) {
//         final post = Post.fromJson(modelDoc.data()!);
//         orders.add({
//           'booking': booking,
//           'model': post,
//         });
//       }
//     }

//     return orders;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Map<String, dynamic>>>(
//       future: ordersFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (snapshot.hasError) {
//           return Center(child: Text("Error: ${snapshot.error}"));
//         }

//         final orders = snapshot.data ?? [];

//         if (orders.isEmpty) {
//           return const Center(child: Text("No orders found."));
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.all(10),
//           itemCount: orders.length,
//           itemBuilder: (context, index) {
//             final booking = orders[index]['booking'] as Booking;
//             final model = orders[index]['model'] as Post;

//             return ListTile(
//               contentPadding: const EdgeInsets.symmetric(
//                 vertical: 10,
//                 horizontal: 15,
//               ),
//               leading: model.imageUrl != null && model.imageUrl.isNotEmpty
//                   ? ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Image.network(
//                         model.imageUrl,
//                         width: 80,
//                         height: 80,
//                         fit: BoxFit.cover,
//                       ),
//                     )
//                   : 
//                   Container(
//                       width: 80,
//                       height: 80,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Icon(Icons.image, size: 40),
//                     ),
//               title: Text(
//                 model.name,
//                 style: GoogleFonts.poppins(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//               subtitle: Text(
//                 "${booking.modifiedprice} DA",
//                 style: GoogleFonts.poppins(
//                   color: Colors.grey,
//                   fontSize: 16,
//                 ),
//               ),
//               trailing: (widget.orderType == "Update" ||
//                       widget.orderType == "view Request")
//                   ? ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             const Color.fromARGB(255, 163, 119, 178),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 20,
//                           vertical: 10,
//                         ),
//                       ),
//                       onPressed: () {
//                         final destination = widget.orderType == "Update"
//                             ? UpdateOrderPage(
//                                 title: model.name,
//                                 price: booking.modifiedprice,
//                                 image: model.imageUrl,
//                                 color: booking.colors.join(', '),
//                                 size: booking.sizes.join(', '),
//                                 notes: booking.note,
//                               )
//                             : RequestedOrderPage(
//                                 title: model.name,
//                                 price: booking.intialprice,
//                                 image: model.imageUrl,
//                                 color: booking.colors.join(', '),
//                                 size: booking.sizes.join(', '),
//                                 notes: booking.note,
//                               );

//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => destination),
//                         );
//                       },
//                       child: Text(
//                         widget.orderType,
//                         style: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 16,
//                         ),
//                       ),
//                     )
//                   : null,
//             );
//           },
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'update_order.dart';
import 'requested_order_page.dart';
import '../models/post_model.dart';
import '../models/bookins.dart';

class ManageOrders extends StatefulWidget {
  const ManageOrders({super.key});

  @override
  State<ManageOrders> createState() => _ManageOrdersState();
}

class _ManageOrdersState extends State<ManageOrders> {
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "My Orders",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 245, 243, 249),
          foregroundColor: Colors.black,
          bottom: TabBar(
            indicatorColor: const Color.fromARGB(255, 163, 119, 178),
            labelColor: const Color.fromARGB(255, 163, 119, 178),
            unselectedLabelColor: Colors.black,
            labelStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
              Tab(text: "Received"),
              Tab(text: "Tailoring"),
              Tab(text: "Completed"),
              Tab(text: "Canceled"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            OrdersList(orderType: "view Request", statusFilter: "requested"),
            OrdersList(orderType: "Update", statusFilter: "Tailoring"),
            OrdersList(orderType: "Review", statusFilter: "Completed"),
            OrdersList(orderType: "Canceled", statusFilter: "Canceled"),
          ],
        ),
      ),
    );
  }
}

class OrdersList extends StatefulWidget {
  final String orderType;
  final String statusFilter;

  const OrdersList({
    super.key,
    required this.orderType,
    required this.statusFilter,
  });

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  late Future<List<Map<String, dynamic>>> ordersFuture;

  @override
  void initState() {
    super.initState();
    ordersFuture = fetchBookingsWithModelData(
      FirebaseAuth.instance.currentUser!.uid,
      widget.statusFilter,
    );
    
  }


  String mapOrderTypeToStatus(String orderType) {
  switch (orderType.toLowerCase()) {
    case "view request":
      return "requested";
    case "update":
      return "accepted";
    // add more mappings as needed
    default:
      return ""; // fallback
  }
}



Future<List<Map<String, dynamic>>> fetchBookingsWithModelData(
  String tailorId, String statusFilter) async {
  
  // Query with statusFilter applied
  final querySnapshot = await FirebaseFirestore.instance
      .collection('bookings')
      .where('tailorId', isEqualTo: tailorId)
      .where('status', isEqualTo: statusFilter.toLowerCase().trim()) // filter by status
      .get();

  print("Status filter: '${widget.statusFilter}'");

  // Check the number of bookings found
  print('Number of bookings found: ${querySnapshot.docs.length}');
  if (querySnapshot.docs.isEmpty) {
    print('No bookings matched the query.');
  }

  List<Map<String, dynamic>> orders = [];

  for (var doc in querySnapshot.docs) {
    final booking = Booking.fromFirestore(doc);
    print('Booking found: ${booking.id}');

    // final modelDoc = await FirebaseFirestore.instance
    //     .collection('models')
    //     .doc(booking.modelId)
    //     .get();

    // if (modelDoc.exists) {
    //   final post = Post.fromJson(modelDoc.data()!);
    //   print('Model found: ${post.name}');

    //   orders.add({
    //     'booking': booking,
    //     'model': post,
    //   });
    // } else {
    //   print('Model not found for booking ID: ${booking.id}');
    // }

    final modelQuery = await FirebaseFirestore.instance
    .collection('models')
    .where('idModel', isEqualTo: booking.modelId) 
    .limit(1)
    .get();

if (modelQuery.docs.isNotEmpty) {
  final post = Post.fromJson(modelQuery.docs.first.data());
  print('✅ Model found: ${post.name}');
  print("🔍 Booking ID: ${booking.id}, modelId: ${booking.modelId}");

  orders.add({
    'booking': booking,
    'model': post,
  });
} else {
  print('❌ Model not found for booking ID: ${booking.id}');
}

  }

  var bookings = await FirebaseFirestore.instance.collection('bookings').where('status', isEqualTo: 'requested').get();

if (bookings.docs.isEmpty) {
  print("No bookings found");
} else {
  var bookingData = bookings.docs.map((doc) => doc.data()).toList();
  print("Number of bookings found: ${bookingData.length}");
}

  print("Current User ID: ${FirebaseAuth.instance.currentUser!.uid}");




  List<Map<String, dynamic>> bookingsList = [];

// After fetching the data
if (bookings != null && bookings.docs.isNotEmpty) {
  bookingsList = bookings.docs.map((doc) => doc.data()).toList();
}

// Now, bookingsList is an iterable and can be used for displaying



  return orders;
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: ordersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final orders = snapshot.data ?? [];

        if (orders.isEmpty) {
          return const Center(child: Text("No orders found."));
        }
        

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final booking = orders[index]['booking'] as Booking;
            final model = orders[index]['model'] as Post;

            return ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              title: Text(
                model.name,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                "${booking.modifiedprice} DA",
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              trailing: (widget.orderType == "Update" ||
                      widget.orderType == "view Request")
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 163, 119, 178),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      onPressed: () {
                        final destination = widget.orderType == "Update"
                            ? UpdateOrderPage(
                                title: model.name,
                                price: booking.modifiedprice,
                                color: booking.colors.join(', '),
                                size: booking.sizes.join(', '),
                                notes: booking.note,
                              )
                            : RequestedOrderPage(
                                title: model.name,
                                price: booking.initialprice,
                                color: booking.colors.join(', '),
                                size: booking.sizes.join(', '),
                                notes: booking.note,
                              );

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => destination),
                        );
                      },
                      child: Text(
                        widget.orderType,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : null,
            );
          },
        );
      },
    );
  }
}

