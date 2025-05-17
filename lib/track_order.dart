// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class TrackOrderPage extends StatelessWidget {
//   const TrackOrderPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           "Track Order",
//           style: GoogleFonts.poppins(
//               fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.asset(
//                     "images/1.jpg",
//                     width: 100,
//                     height: 100,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Kaftan Royal",
//                         style: GoogleFonts.poppins(
//                             fontSize: 16, fontWeight: FontWeight.w600)),
//                     Text("Tailor: Ines",
//                         style: GoogleFonts.poppins(
//                             fontSize: 14, color: Colors.grey)),
//                     const SizedBox(height: 5),
//                     Text("Price: 25000DA",
//                         style: GoogleFonts.poppins(
//                             fontSize: 16, fontWeight: FontWeight.bold)),
//                   ],
//                 )
//               ],
//             ),
//             const SizedBox(height: 20),
//             Text("Order Details",
//                 style: GoogleFonts.poppins(
//                     fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   orderDetailRow("Order Number", "#123456"),
//                   orderDetailRow("Order Date", "10 Jan 2024"),
//                   orderDetailRow("Estimated Delivery", "12 Jan 2024"),
//                   orderDetailRow("Shipping Address", "Algiers, Algeria"),
//                   const Divider(),
//                   orderDetailRow("Size", "M"),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Color",
//                           style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.grey)),
//                       Container(
//                         width: 20,
//                         height: 20,
//                         decoration: BoxDecoration(
//                           color: Colors.blue,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ],
//                   ),
//                   orderDetailRow("Notes", "Custom embroidery on sleeves"),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text("Order Status", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             Column(
//               children: List.generate(6, (index) {
//                 return orderStep(
//                   [
//                     "Pattern Making (الباترون)",
//                     "Fabric Cutting (التفصيل)",
//                     "Preliminary Sewing (الخياطة الأولية)",
//                     "Edge Finishing (السرفلة)",
//                     "Accessories Assembly (تركيب الكماليات)",
//                     "Delivery (التوصيل)"
//                   ][index],
//                   [
//                     "10 Jan 2024 10:00 AM",
//                     "10 Jan 2024 02:00 PM",
//                     "11 Jan 2024 08:00 AM",
//                     "11 Jan 2024",
//                     "11 Jan 2024",
//                     "11 Jan 2024"
//                   ][index],
//                   index < 2,
//                   index != 5,
//                 );
//               }),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   backgroundColor: const Color.fromARGB(255, 163, 119, 178),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30)),
//                 ),
//                 child: Text("Cancel Order",
//                     style: GoogleFonts.poppins(
//                         fontSize: 16, color: Colors.white)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget orderStep(String title, String date, bool isCompleted, bool hasLine) {
//     return Column(
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               children: [
//                 Container(
//                   width: 26,
//                   height: 26,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: isCompleted
//                         ? const Color.fromARGB(255, 163, 119, 178)
//                         : Colors.grey.shade400,
//                   ),
//                   child: const Icon(Icons.check, size: 16, color: Colors.white),
//                 ),
//                 if (hasLine)
//                   Container(
//                     width: 2,
//                     height: 60,
//                     color: isCompleted
//                         ? const Color.fromARGB(255, 163, 119, 178)
//                         : Colors.grey.shade300,
//                   ),
//               ],
//             ),
//             const SizedBox(width: 12),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: GoogleFonts.poppins(
//                     fontSize: 16, fontWeight: FontWeight.bold)),
//                 Text(date, style: GoogleFonts.poppins(
//                     fontSize: 14, color: Colors.grey)),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget orderDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: GoogleFonts.poppins(
//               fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey)),
//           Text(value, style: GoogleFonts.poppins(
//               fontSize: 14, fontWeight: FontWeight.w600)),
//         ],
//       ),
//     );
//   }
// }




import 'package:cloud_firestore/cloud_firestore.dart';

/////////////////
///
///
// ///

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class TrackOrderPage extends StatelessWidget {
//   final Map<String, dynamic> orderData;

//   const TrackOrderPage({super.key, required this.orderData});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           "Track Order",
//           style: GoogleFonts.poppins(
//               fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.network(
//                     orderData['image'] ?? '',
//                     width: 100,
//                     height: 100,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(orderData['modelName'] ?? '',
//                         style: GoogleFonts.poppins(
//                             fontSize: 16, fontWeight: FontWeight.w600)),
//                     Text("Tailor: ${orderData['tailorId'] ?? ''}",
//                         style: GoogleFonts.poppins(
//                             fontSize: 14, color: Colors.grey)),
//                     const SizedBox(height: 5),
//                     Text("Price: ${orderData['modifiedprice'] ?? ''} DA",
//                         style: GoogleFonts.poppins(
//                             fontSize: 16, fontWeight: FontWeight.bold)),
//                   ],
//                 )
//               ],
//             ),
//             const SizedBox(height: 20),
//             Text("Order Details",
//                 style: GoogleFonts.poppins(
//                     fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   orderDetailRow("Order Number", orderData['orderNumber'] ?? ''),
//                   orderDetailRow("Order Date", formatDate(orderData['orderDate'])),
//                   orderDetailRow("Estimated Delivery", formatDate(orderData['deliveryDate'])),
//                   orderDetailRow("Shipping Address", orderData['address'] ?? ''),
//                   const Divider(),
//                   orderDetailRow("Size", formatListToString(orderData['size'])),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Color",
//                           style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.grey)),
//                       Container(
//                         width: 20,
//                         height: 20,
//                         decoration: BoxDecoration(
//                           color: Color(int.tryParse(orderData['color'] ?? '0xff000000') ?? 0xff000000),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ],
//                   ),
//                   orderDetailRow("Notes", orderData['notes'] ?? 'None'),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text("Order Status", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             // Column(
//               // children: List.generate(orderData['progress'].length, (index) {
//             //     final step = orderData['progress'][index];
//             //     return orderStep(
//             //       step['title'] ?? '',
//             //       formatDate(step['date']),
//             //       step['completed'] ?? false,
//             //       index != orderData['progress'].length - 1,
//             //     );
//             //   }),
//             // ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   backgroundColor: const Color.fromARGB(255, 163, 119, 178),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30)),
//                 ),
//                 child: Text("Cancel Order",
//                     style: GoogleFonts.poppins(
//                         fontSize: 16, color: Colors.white)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget orderStep(String title, String date, bool isCompleted, bool hasLine) {
//     return Column(
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               children: [
//                 Container(
//                   width: 26,
//                   height: 26,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: isCompleted
//                         ? const Color.fromARGB(255, 163, 119, 178)
//                         : Colors.grey.shade400,
//                   ),
//                   child: const Icon(Icons.check, size: 16, color: Colors.white),
//                 ),
//                 if (hasLine)
//                   Container(
//                     width: 2,
//                     height: 60,
//                     color: isCompleted
//                         ? const Color.fromARGB(255, 163, 119, 178)
//                         : Colors.grey.shade300,
//                   ),
//               ],
//             ),
//             const SizedBox(width: 12),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: GoogleFonts.poppins(
//                     fontSize: 16, fontWeight: FontWeight.bold)),
//                 Text(date, style: GoogleFonts.poppins(
//                     fontSize: 14, color: Colors.grey)),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget orderDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: GoogleFonts.poppins(
//               fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey)),
//           Text(value, style: GoogleFonts.poppins(
//               fontSize: 14, fontWeight: FontWeight.w600)),
//         ],
//       ),
//     );
//   }

//   String formatDate(dynamic date) {
//     if (date is Timestamp) {
//       return "${date.toDate().day}/${date.toDate().month}/${date.toDate().year}";
//     }
//     return date ?? '';
//   }

//   String formatListToString(dynamic list) {
//   if (list is List) {
//     return list.join(", ");
//   }
//   return list?.toString() ?? ''; 
// }
// }



/////////////////////////
// ///
// import 'package:flutter/material.dart';

// import 'package:google_fonts/google_fonts.dart';

// class TrackOrderPage extends StatelessWidget {
//   final Map<String, dynamic> orderData;

//   const TrackOrderPage({super.key, required this.orderData});

//   @override
//   Widget build(BuildContext context) {

//     int progress = 0;
// if (orderData['progres'] != null) {
//   if (orderData['progres'] is int) {
//     progress = orderData['progres'];
//   } else if (orderData['progres'] is String) {
//     progress = int.tryParse(orderData['progres']) ?? 0;
//   }
// }




// print("🔍 Fetched Order Data:");
//   orderData.forEach((key, value) {
//     print("$key: ${value ?? '❌ null'}");
//   });


//   Future<void> fetchModelName() async {
//     try {
//       final String modelId = orderData['modelId'];
//       if (modelId.isNotEmpty) {
//         DocumentSnapshot modelSnapshot = await FirebaseFirestore.instance
//             .collection('models')
//             .doc(modelId)
//             .get();
//         if (modelSnapshot.exists) {
//           setState(() {
//             modelName = modelSnapshot.get('name') ?? 'Unnamed Model';
//           });
//         } else {
//           setState(() {
//             modelName = 'Model Not Found';
//           });
//         }
//       }
//     } catch (e) {
//       print("❌ Error fetching model name: $e");
//       setState(() {
//         modelName = 'Error loading name';
//       });
//     }
//   }


//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           "Track Order",
//           style: GoogleFonts.poppins(
//               fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.network(
//                     orderData['image'] ?? '',
//                     width: 50,
//                     height: 100,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(orderData['modelName'] ?? '',
//                         style: GoogleFonts.poppins(
//                             fontSize: 16, fontWeight: FontWeight.w600)),
//                     Text("Tailor: ${orderData['tailorId'] ?? ''}",
//                         style: GoogleFonts.poppins(
//                             fontSize: 14, color: Colors.grey)),
//                     const SizedBox(height: 5),
//                     Text("Price: ${orderData['modifiedprice'] ?? ''} DA",
//                         style: GoogleFonts.poppins(
//                             fontSize: 16, fontWeight: FontWeight.bold)),
//                   ],
//                 )
//               ],
//             ),
//             const SizedBox(height: 20),
//             Text("Order Details",
//                 style: GoogleFonts.poppins(
//                     fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   orderDetailRow("Order Number", orderData['orderNumber'] ?? ''),
//                   orderDetailRow("Order Date", formatDate(orderData['orderDate'])),
//                   FutureBuilder<DocumentSnapshot>(
//                           future: FirebaseFirestore.instance
//                               .collection('customer')
//                               .doc(orderData['userId'])
//                               .get(),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState == ConnectionState.waiting) {
//                               return orderDetailRow("Shipping Address", "Loading...");
//                             } else if (snapshot.hasError) {
//                               return orderDetailRow("Shipping Address", "Error loading address");
//                             } else if (snapshot.hasData) {
//                               final customerData = snapshot.data!.data() as Map<String, dynamic>?;
//                               final address = customerData?['address'] ?? 'No address found';
//                               return orderDetailRow("Shipping Address", address);
//                             } else {
//                               return orderDetailRow("Shipping Address", "No customer data");
//                             }
//                           },
//                         ),
//                   const Divider(),
//                   // orderDetailRow("Size", formatListToString(orderData['size'])),
//                   orderDetailRow("Size", formatListToString(orderData['size'] ?? [])),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Color",
//                           style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.grey)),
//                       Container(
//                         width: 20,
//                         height: 20,
//                         decoration: BoxDecoration(
//                           color: _parseColorFromList(orderData['color']),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ],
//                   ),
//                   orderDetailRow("Notes", orderData['notes'] ?? 'None'),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text("Order Status", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             Column(
//               children: List.generate(6, (index) {
//                 List<String> steps = [
//                   "Pattern Making (الباترون)",
//                   "Fabric Cutting (التفصيل)",
//                   "Preliminary Sewing (الخياطة الأولية)",
//                   "Edge Finishing (السرفلة)",
//                   "Accessories Assembly(تركيب الكماليات)",
//                   "Delivery (التوصيل)"
//                 ];
//                 bool isCompleted = index < progress; 
//                 return orderStep(
//                   steps[index], 
//                   '',
//                   isCompleted,   
//                   index != 5, 
//                 );
//               }),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () async {
//                 try {
//               final String bookingId = orderData['bookingId']; 
//                 await FirebaseFirestore.instance
//                 .collection('bookings')
//                 .doc(bookingId)
//                 .update({'status': 'canceled'});
                
//               print('orderData bookingId: ${orderData['bookingId']}');

//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Order canceled successfully')),
//             );

//             Navigator.pop(context); 
//           } catch (e) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Failed to cancel order: $orderData  $e' )),
              
//             );
//           }

//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   backgroundColor: const Color.fromARGB(255, 163, 119, 178),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30)),
//                 ),
//                 child: Text("Cancel Order",
//                     style: GoogleFonts.poppins(
//                         fontSize: 16, color: Colors.white)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget orderStep(String title, String date, bool isCompleted, bool hasLine) {
//     return Column(
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               children: [
//                 Container(
//                   width: 26,
//                   height: 26,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: isCompleted
//                         ? const Color.fromARGB(255, 163, 119, 178)
//                         : Colors.grey.shade400,
//                   ),
//                   child: const Icon(Icons.check, size: 16, color: Colors.white),
//                 ),
//                 if (hasLine)
//                   Container(
//                     width: 2,
//                     height: 60,
//                     color: isCompleted
//                         ? const Color.fromARGB(255, 163, 119, 178)
//                         : Colors.grey.shade300,
//                   ),
//               ],
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title, style: GoogleFonts.poppins(
//                       fontSize: 16, fontWeight: FontWeight.bold)),
//                   Text(date, style: GoogleFonts.poppins(
//                       fontSize: 14, color: Colors.grey)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget orderDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: GoogleFonts.poppins(
//               fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
//           Text(value, style: GoogleFonts.poppins(
//               fontSize: 14, fontWeight: FontWeight.w600)),
//         ],
//       ),
//     );
//   }

//   String formatDate(dynamic date) {
//     if (date is Timestamp) {
//       return "${date.toDate().day}/${date.toDate().month}/${date.toDate().year}";
//     }
//     return date ?? '';
//   }

// String formatListToString(dynamic list) {
//   if (list is List) {
//     return list.map((e) => e.toString()).join(", ");
//   }
//   return list?.toString() ?? '';
// }

// Color _parseColorFromList(dynamic colorList) {
//   if (colorList is List && colorList.isNotEmpty) {
//     String colorString = colorList.first.toString().replaceAll('#', '');
//     // Ensure it starts with '0x' and is 8 digits (ARGB), fallback to black if invalid
//     if (colorString.length == 8) {
//       return Color(int.parse('0x$colorString'));
//     } else if (colorString.length == 6) {
//       return Color(int.parse('0xff$colorString'));
//     }
//   }
//   return const Color(0xff000000);
// }

// }







/////////////////////////
///
///
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackOrderPage extends StatefulWidget {
  final Map<String, dynamic> orderData;

  const TrackOrderPage({super.key, required this.orderData});

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = widget.orderData;

    int progress = 0;
    if (orderData['progres'] != null) {
      if (orderData['progres'] is int) {
        progress = orderData['progres'];
      } else if (orderData['progres'] is String) {
        progress = int.tryParse(orderData['progres']) ?? 0;
      }
    }

    print("🔍 Fetched Order Data:");
    orderData.forEach((key, value) {
      print("$key: ${value ?? '❌ null'}");
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Track Order",
          style: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FutureBuilder<QuerySnapshot>(
  future: FirebaseFirestore.instance
      .collection('models')
      .where('idModel', isEqualTo: orderData['modelId'])
      .limit(1)
      .get(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Container(
        width: 50,
        height: 100,
        color: Colors.grey.shade200,
        child: const Center(child: CircularProgressIndicator()),
      );
    } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Container(
        width: 50,
        height: 100,
        color: Colors.grey.shade300,
        child: const Icon(Icons.broken_image, color: Colors.grey),
      );
    } else {
      final modelData = snapshot.data!.docs.first.data() as Map<String, dynamic>;
      final imageUrl = modelData['imageUrl'] ?? '';

      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imageUrl,
          width: 50,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            width: 50,
            height: 100,
            color: Colors.grey.shade300,
            child: const Icon(Icons.broken_image, color: Colors.grey),
          ),
        ),
      );
    }
  },
),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                                          FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('models')
                      .where('idModel', isEqualTo: orderData['modelId']) 
                      .limit(1)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text(
                        "Loading model...",
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        "Error loading model",
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                      );
                    } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      final modelData = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                      final modelName = modelData['name'] ?? 'Unnamed Model';
                      return Text(
                        modelName,
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                      );
                    } else {
                      return Text(
                        "Model not found",
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                      );
                    }
                  },
                ),
                      FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('tailors')
                          .doc(orderData['tailorId'])
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text("Tailor: Loading...",
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey));
                        } else if (snapshot.hasError) {
                          return Text("Tailor: Error loading name",
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey));
                        } else if (snapshot.hasData && snapshot.data!.exists) {
                          final tailorData = snapshot.data!.data() as Map<String, dynamic>;
                          final tailorName = tailorData['username'] ?? 'Unknown Tailor';
                          return Text("Tailor: $tailorName",
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey));
                        } else {
                          return Text("Tailor: Not found",
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey));
                        }
                      },
                    ),



                    const SizedBox(height: 5),
                    Text("Price: ${orderData['modifiedprice'] ?? ''} DA",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Text("Order Details",
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  orderDetailRow("Order Number", orderData['orderNumber'] ?? ''),
                  orderDetailRow("Order Date", formatDate(orderData['orderDate'])),
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('customer')
                        .doc(orderData['userId'])
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return orderDetailRow("Shipping Address", "Loading...");
                      } else if (snapshot.hasError) {
                        return orderDetailRow("Shipping Address", "Error loading address");
                      } else if (snapshot.hasData) {
                        final customerData = snapshot.data!.data() as Map<String, dynamic>?;
                        final address = customerData?['address'] ?? 'No address found';
                        return orderDetailRow("Shipping Address", address);
                      } else {
                        return orderDetailRow("Shipping Address", "No customer data");
                      }
                    },
                  ),
                  const Divider(),
                  orderDetailRow("Size", formatListToString(orderData['size'] ?? [])),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Color",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey)),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: _parseColorFromList(orderData['color']),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  orderDetailRow("Notes", orderData['notes'] ?? 'None'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text("Order Status", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Column(
              children: List.generate(6, (index) {
                List<String> steps = [
                  "Pattern Making (الباترون)",
                  "Fabric Cutting (التفصيل)",
                  "Preliminary Sewing (الخياطة الأولية)",
                  "Edge Finishing (السرفلة)",
                  "Accessories Assembly(تركيب الكماليات)",
                  "Delivery (التوصيل)"
                ];
                bool isCompleted = index < progress; 
                return orderStep(
                  steps[index], 
                  '',
                  isCompleted,   
                  index != 5, 
                );
              }),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    final String bookingId = orderData['bookingId']; 
                    await FirebaseFirestore.instance
                        .collection('bookings')
                        .doc(bookingId)
                        .update({'status': 'canceled'});
                    
                    print('orderData bookingId: ${orderData['bookingId']}');

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order canceled successfully')),
                    );

                    Navigator.pop(context); 
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to cancel order: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: const Color.fromARGB(255, 163, 119, 178),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: Text("Cancel Order",
                    style: GoogleFonts.poppins(
                        fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderStep(String title, String date, bool isCompleted, bool hasLine) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? const Color.fromARGB(255, 163, 119, 178)
                        : Colors.grey.shade400,
                  ),
                  child: const Icon(Icons.check, size: 16, color: Colors.white),
                ),
                if (hasLine)
                  Container(
                    width: 2,
                    height: 60,
                    color: isCompleted
                        ? const Color.fromARGB(255, 163, 119, 178)
                        : Colors.grey.shade300,
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(date, style: GoogleFonts.poppins(
                      fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget orderDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
          Flexible(
            child: Text(value, style: GoogleFonts.poppins(
                fontSize: 14, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(dynamic date) {
    if (date is Timestamp) {
      final dt = date.toDate();
      return "${dt.day}/${dt.month}/${dt.year}";
    }
    return date?.toString() ?? '';
  }

  String formatListToString(dynamic list) {
    if (list is List) {
      return list.map((e) => e.toString()).join(", ");
    }
    return list?.toString() ?? '';
  }

  Color _parseColorFromList(dynamic colorList) {
    if (colorList is List && colorList.isNotEmpty) {
      String colorString = colorList.first.toString().replaceAll('#', '');
      if (colorString.length == 8) {
        return Color(int.parse('0x$colorString'));
      } else if (colorString.length == 6) {
        return Color(int.parse('0xff$colorString'));
      }
    }
    return const Color(0xff000000);
  }
}
