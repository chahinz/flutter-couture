// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class UpdateOrderPage extends StatefulWidget {
//   final String title;
//   final String price;
//   // final String image;
//   final String color;
//   final String size;
//   final String notes;

//   const UpdateOrderPage({
//     super.key,
//     required this.title,
//     required this.price,
//     // required this.image,
//     required this.color,
//     required this.size,
//     required this.notes,
//   });

//   @override
//   State<UpdateOrderPage> createState() => _UpdateOrderPageState();
// }

// class _UpdateOrderPageState extends State<UpdateOrderPage> {
//   List<bool> isChecked = [false, false, false, false, false, false]; 

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Update Order")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Center(
//             //   child: ClipRRect(
//             //     borderRadius: BorderRadius.circular(12),
//             //     child: Image.asset(
//             //       widget.image,
//             //       width: 250, 
//             //       height: 250,
//             //       fit: BoxFit.cover,
//             //     ),
//             //   ),
//             // ),
//             const SizedBox(height: 20),
//             Text(
//               widget.title,
//               style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 4),
//             Text(
//               "${widget.price} DA",
//               style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "Order Details:",
//               style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             buildOrderDetail("Color", widget.color),
//             buildOrderDetail("Size", widget.size),
//             buildOrderDetail("Notes", widget.notes),
//             const SizedBox(height: 20),
//             Text(
//               "Order Steps:",
//               style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             buildTaskItem(0, "Step 1: Pattern Making (الباترون)"),
//             buildTaskItem(1, "Step 2: Fabric Cutting (التفصيل)"),
//             buildTaskItem(2, "Step 3: Preliminary Sewing (الخياطة الأولية)"),
//             buildTaskItem(3, "Step 4: Edge Finishing (السرفلة)"),
//             buildTaskItem(4, "Step 5: Accessories Assembly (تركيب الكماليات)"),
//             buildTaskItem(5, "Step 6: Delivery (التوصيل)"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildOrderDetail(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           Text(
//             "$label: ",
//             style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildTaskItem(int index, String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               text,
//               style: GoogleFonts.poppins(fontSize: 16),
//             ),
//           ),
//           SizedBox(
//             width: 28,
//             height: 28,
//             child: Checkbox(
//               value: isChecked[index],
//               onChanged: (bool? value) {
//                 setState(() {
//                   isChecked[index] = value ?? false;
//                 });
//               },
//               shape: const CircleBorder(),
//               activeColor: const Color.fromARGB(255, 163, 119, 178),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




// class _UpdateOrderPageState extends State<UpdateOrderPage> {
//   List<bool> isChecked = [false, false, false, false, false, false];
//   int currentStep = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Update Order")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//             Text(
//               widget.title,
//               style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 4),
//             Text(
//               "${widget.price} DA",
//               style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "Order Details:",
//               style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             buildOrderDetail("Color", widget.color),
//             buildOrderDetail("Size", widget.size),
//             buildOrderDetail("Notes", widget.notes),
//             const SizedBox(height: 20),
//             Text(
//               "Order Steps:",
//               style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             buildTaskItem(0, "Step 1: Pattern Making (الباترون)"),
//             buildTaskItem(1, "Step 2: Fabric Cutting (التفصيل)"),
//             buildTaskItem(2, "Step 3: Preliminary Sewing (الخياطة الأولية)"),
//             buildTaskItem(3, "Step 4: Edge Finishing (السرفلة)"),
//             buildTaskItem(4, "Step 5: Accessories Assembly (تركيب الكماليات)"),
//             buildTaskItem(5, "Step 6: Delivery (التوصيل)"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildOrderDetail(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           Text(
//             "$label: ",
//             style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildTaskItem(int index, String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               text,
//               style: GoogleFonts.poppins(fontSize: 16),
//             ),
//           ),
//           SizedBox(
//             width: 28,
//             height: 28,
//             child: Checkbox(
//               value: isChecked[index],
//               onChanged: (bool? value) async {
//                 setState(() {
//                   isChecked[index] = value ?? false;
//                 });

//                 if (value == true) {
//                   currentStep++;

//                   await FirebaseFirestore.instance
//                       .collection('bookings')
//                       .doc(widget.bookingId)
//                       .update({'progress': currentStep});

//                   if (index == isChecked.length - 1) {
//                     await FirebaseFirestore.instance
//                         .collection('bookings')
//                         .doc(widget.bookingId)
//                         .update({'status': 'completed'});

//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("Order marked as completed ✅")),
//                     );

//                     Navigator.pop(context, true);
//                   }
//                 }
//               },
//               shape: const CircleBorder(),
//               activeColor: const Color.fromARGB(255, 163, 119, 178),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




///////////
///

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class UpdateOrderPage extends StatefulWidget {
//   final String bookingId; // <-- Add this
//   final String title;
//   final String price;
//   final String color;
//   final String size;
//   final String notes;

//   const UpdateOrderPage({
//     super.key,
//     required this.bookingId,
//     required this.title,
//     required this.price,
//     required this.color,
//     required this.size,
//     required this.notes,
//   });

//   @override
//   State<UpdateOrderPage> createState() => _UpdateOrderPageState();
// }


// class _UpdateOrderPageState extends State<UpdateOrderPage> {
//   List<bool> isChecked = [false, false, false, false, false, false];
//   int currentStep = 0;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadProgressFromFirestore();
//   }

//   Future<void> loadProgressFromFirestore() async {
//     final doc = await FirebaseFirestore.instance
//         .collection('bookings')
//         .doc(widget.bookingId)
//         .get();

//     if (doc.exists) {
//       currentStep = doc['progress'] ?? 0;

//       setState(() {
//         for (int i = 0; i < currentStep && i < isChecked.length; i++) {
//           isChecked[i] = true;
//         }
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(title: const Text("Update Order")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//             Text(
//               widget.title,
//               style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 4),
//             Text(
//               "${widget.price} DA",
//               style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             Text("Order Details:", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//             buildOrderDetail("Color", widget.color),
//             buildOrderDetail("Size", widget.size),
//             buildOrderDetail("Notes", widget.notes),
//             const SizedBox(height: 20),
//             Text("Order Steps:", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//             buildTaskItem(0, "Step 1: Pattern Making (الباترون)"),
//             buildTaskItem(1, "Step 2: Fabric Cutting (التفصيل)"),
//             buildTaskItem(2, "Step 3: Preliminary Sewing (الخياطة الأولية)"),
//             buildTaskItem(3, "Step 4: Edge Finishing (السرفلة)"),
//             buildTaskItem(4, "Step 5: Accessories Assembly (تركيب الكماليات)"),
//             buildTaskItem(5, "Step 6: Delivery (التوصيل)"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildOrderDetail(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           Text("$label: ", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
//           Expanded(
//             child: Text(value, style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildTaskItem(int index, String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(text, style: GoogleFonts.poppins(fontSize: 16)),
//           ),
//           SizedBox(
//             width: 28,
//             height: 28,
//             child: Checkbox(
//               value: isChecked[index],
//               onChanged: isChecked[index]
//                   ? null 
//                   : (bool? value) async {
//                       if (value == true) {
//                         setState(() {
//                           isChecked[index] = true;
//                           currentStep++;
//                         });

//                         await FirebaseFirestore.instance
//                             .collection('bookings')
//                             .doc(widget.bookingId)
//                             .update({'progress': currentStep});

//                         if (index == isChecked.length - 1) {
//                         await FirebaseFirestore.instance
//                             .collection('bookings')
//                             .doc(widget.bookingId)
//                             .update({
//                               'status': 'completed',
//                               'progress': currentStep,
//                             });

//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("Order marked as completed ✅")),
//                         );

//                         loadProgressFromFirestore();
//                       }
//                       }
//                     },
//               shape: const CircleBorder(),
//               activeColor: const Color.fromARGB(255, 163, 119, 178),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class UpdateOrderPage extends StatefulWidget {
//   final String bookingId;
//   final String title;
//   final String price;
//   final String color;
//   final String size;
//   final String notes;

//   const UpdateOrderPage({
//     super.key,
//     required this.bookingId,
//     required this.title,
//     required this.price,
//     required this.color,
//     required this.size,
//     required this.notes,
//   });

//   @override
//   State<UpdateOrderPage> createState() => _UpdateOrderPageState();
// }

// class _UpdateOrderPageState extends State<UpdateOrderPage> {
//   List<bool> isChecked = [false, false, false, false, false, false];
//   int currentStep = 0;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadProgressFromFirestore();
//   }

//   Future<void> loadProgressFromFirestore() async {
//     final doc = await FirebaseFirestore.instance
//         .collection('bookings')
//         .doc(widget.bookingId)
//         .get();

//     if (doc.exists) {
//       currentStep = doc['progress'] ?? 0;

//       setState(() {
//         for (int i = 0; i < currentStep && i < isChecked.length; i++) {
//           isChecked[i] = true;
//         }
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(title: const Text("Update Order")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//             Text(
//               widget.title,
//               style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 4),
//             Text(
//               "${widget.price} DA",
//               style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             Text("Order Details:", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//             buildOrderDetail("Color", widget.color.isNotEmpty ? widget.color : '—'),
//             buildOrderDetail("Size", widget.size.isNotEmpty ? widget.size : '—'),
//             buildOrderDetail("Notes", widget.notes.isNotEmpty ? widget.notes : '—'),
//             const SizedBox(height: 20),
//             Text("Order Steps:", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//             buildTaskItem(0, "Step 1: Pattern Making (الباترون)"),
//             buildTaskItem(1, "Step 2: Fabric Cutting (التفصيل)"),
//             buildTaskItem(2, "Step 3: Preliminary Sewing (الخياطة الأولية)"),
//             buildTaskItem(3, "Step 4: Edge Finishing (السرفلة)"),
//             buildTaskItem(4, "Step 5: Accessories Assembly (تركيب الكماليات)"),
//             buildTaskItem(5, "Step 6: Delivery (التوصيل)"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildOrderDetail(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           Text("$label: ", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
//           Expanded(
//             child: Text(value, style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildTaskItem(int index, String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(text, style: GoogleFonts.poppins(fontSize: 16)),
//           ),
//           SizedBox(
//             width: 28,
//             height: 28,
//             child: Checkbox(
//               value: isChecked[index],
//               onChanged: isChecked[index]
//                   ? null
//                   : (bool? value) async {
//                       if (value == true) {
//                         setState(() {
//                           isChecked[index] = true;
//                           currentStep++;
//                         });

//                         await FirebaseFirestore.instance
//                             .collection('bookings')
//                             .doc(widget.bookingId)
//                             .update({'progress': currentStep});

//                         if (index == isChecked.length - 1) {
//                           await FirebaseFirestore.instance
//                               .collection('bookings')
//                               .doc(widget.bookingId)
//                               .update({
//                                 'status': 'completed',
//                                 'progress': currentStep,
//                               });

//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text("Order marked as completed ✅")),
//                           );

//                           loadProgressFromFirestore();
//                         }
//                       }
//                     },
//               shape: const CircleBorder(),
//               activeColor: Color(0xFFA377B2), 
//               checkColor: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateOrderPage extends StatefulWidget {
  final String bookingId;
  final String title;
  final String price;
  final String color;
  final String size;
  final String notes;
  final int progress;
  final String? imageUrl;

  const UpdateOrderPage({
    super.key,
    required this.bookingId,
    required this.title,
    required this.price,
    required this.color,
    required this.size,
    required this.notes,
    required this.progress,
    this.imageUrl,
  });

  @override
  State<UpdateOrderPage> createState() => _UpdateOrderPageState();
}

class _UpdateOrderPageState extends State<UpdateOrderPage> {
  List<bool> isChecked = [false, false, false, false, false, false];
  int currentStep = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProgressFromFirestore();
  }

  Future<void> loadProgressFromFirestore() async {
                final doc = await FirebaseFirestore.instance
                .collection('bookings')
                .doc(widget.bookingId)
                .get();

            final data = doc.data();

            final progress = (data != null && data.containsKey('progress'))
                ? data['progress'] as int
                : 0;

            setState(() {
              currentStep = progress;
              for (int i = 0; i < isChecked.length; i++) {
                isChecked[i] = i < currentStep;
              }
              isLoading = false;
            });
  }

  Future<void> updateProgress() async {
    int newProgress = isChecked.lastIndexWhere((v) => v == true) + 1;

    await FirebaseFirestore.instance
        .collection('bookings')
        .doc(widget.bookingId)
        .update({'progress': newProgress});

    if (newProgress == isChecked.length) {
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(widget.bookingId)
          .update({'status': 'completed'});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Order marked as completed ")),
      );
    }

    setState(() {
      currentStep = newProgress;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }


    return Scaffold(
      appBar: AppBar(title: const Text("Update Order")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty)
  Center(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        widget.imageUrl!,
        width: 300,
        height: 300,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 80, color: Colors.grey);
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const SizedBox(
            width: 80,
            height: 80,
            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    ),
  )
else
  Center(
    child: Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.image, size: 80, color: Colors.white70),
    ),
  ),

const SizedBox(height: 20),
            const SizedBox(height: 20),
            Text(
              widget.title,
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              "${widget.price} DA",
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text("Order Details:", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            buildOrderDetail("Color", widget.color.isNotEmpty ? widget.color : '—'),
            buildOrderDetail("Size", widget.size.isNotEmpty ? widget.size : '—'),
            buildOrderDetail("Notes", widget.notes.isNotEmpty ? widget.notes : '—'),
            const SizedBox(height: 20),
            Text("Order Steps:", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            buildTaskItem(0, "Step 1: Pattern Making (الباترون)"),
            buildTaskItem(1, "Step 2: Fabric Cutting (التفصيل)"),
            buildTaskItem(2, "Step 3: Preliminary Sewing (الخياطة الأولية)"),
            buildTaskItem(3, "Step 4: Edge Finishing (السرفلة)"),
            buildTaskItem(4, "Step 5: Accessories Assembly (تركيب الكماليات)"),
            buildTaskItem(5, "Step 6: Delivery (التوصيل)"),
          ],
        ),
      ),
    );
  }

  Widget buildOrderDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$label: ", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
          Expanded(
            child: Text(value, style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54)),
          ),
        ],
      ),
    );
  }

  Widget buildTaskItem(int index, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(text, style: GoogleFonts.poppins(fontSize: 16)),
          ),
          SizedBox(
            width: 28,
            height: 28,
            child: Checkbox(
              value: isChecked[index],
              onChanged: (bool? value) async {
                if (value == true) {
                  bool allPreviousChecked = isChecked
                      .sublist(0, index)
                      .every((checked) => checked == true);

                  if (!allPreviousChecked) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("You must complete previous steps first!")),
                    );
                    return;
                  }

                  setState(() {
                    isChecked[index] = true;
                  });
                } else {
                  setState(() {
                    for (int i = index; i < isChecked.length; i++) {
                      isChecked[i] = false;
                    }
                  });
                }

                await updateProgress();
              },
              shape: const CircleBorder(),
              activeColor: Color(0xFFA377B2),
              checkColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
