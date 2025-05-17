// // 

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'tailor_profile_page.dart';

// class DetailPage extends StatefulWidget {
//   final String title; 
//   final String price; 
//   final String description; 
//   final String fabricType; 
//   final String modelId; 
//   final String tailorId; 

  
//   const DetailPage({
//     super.key,
//     required this.title,
//     required this.price,
//     required this.description,
//     required this.fabricType,
//     required this.modelId,
//     required this.tailorId,

//   });

//   @override
//   _DetailPageState createState() => _DetailPageState();
// }


// String tailorName = "";



// class _DetailPageState extends State<DetailPage> {
//   // Selected color for the product
//   Color _selectedColor = Colors.brown;

//   // Selected size for the product
//   String _selectedSize = "S";

//   // Boolean flag to track whether the product is liked or not
//   bool _isLiked = false;

//   Future<void> _fetchTailorName() async {
//     try {
//       DocumentSnapshot tailorDoc = await FirebaseFirestore.instance
//           .collection('tailors') // Assuming 'tailors' is your collection
//           .doc(widget.tailorId) // Use the tailorId passed to the page
//           .get();

//       if (tailorDoc.exists) {
//         setState(() {
//           tailorName = tailorDoc['name']; // Assuming 'name' is the field in Firestore
//         });
//       }
//     } catch (e) {
//       print("Error fetching tailor name: $e");
//     }
//   }

//    @override
//   void initState() {
//     super.initState();
//     _fetchTailorName();
//   }

//   // Tailor's details (Hardcoded for now)
//   static const String tailorProfileImage = "images/5.jpg";

//   // Controller for the notes text field
//   TextEditingController _notesController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200], // Light grey background
//       appBar: AppBar(
//         backgroundColor: Colors.white, // White app bar
//         elevation: 0, // Removes shadow effect
//         iconTheme: const IconThemeData(color: Colors.black), // Black back button
//         actions: [
//           // Favorite (Like) button
//           IconButton(
//             icon: Icon(
//               _isLiked ? Icons.favorite : Icons.favorite_border,
//               color: _isLiked ? Colors.red : Colors.black,
//             ),
//             onPressed: () {
//               setState(() {
//                 _isLiked = !_isLiked; // Toggle like status
//               });
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView( // Makes the screen scrollable
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image Display - Placeholder for now
//             Center(
//               child: Container(
//                 width: double.infinity,
//                 height: 300,
//                 color: Colors.grey[300], // Placeholder background color
//                 child: Center(
//                   child: Text(
//                     "No Image Available", // Placeholder text
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
            
//             // Product Details Section
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Tailor's Profile (Clickable)
//                   GestureDetector(
//                     onTap: () {
//                       // Navigate to Tailor's Profile Page
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => TailorProfilePage(
//                             name: tailorName,
//                             image: tailorProfileImage,
//                           ),
//                         ),
//                       );
//                     },
//                     child: Row(
//                       children: [
//                         // Tailor's Profile Picture
//                         const CircleAvatar(
//                           backgroundImage: AssetImage(tailorProfileImage),
//                           radius: 20,
//                         ),
//                         const SizedBox(width: 10),
//                         // Tailor's Name
//                         Text(
//                           tailorName,
//                           style: GoogleFonts.poppins(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 16),

//                   // Product Title
//                   Text(widget.title,
//                       style: GoogleFonts.poppins(
//                           fontSize: 24, fontWeight: FontWeight.bold)),

//                   const SizedBox(height: 16),

//                   // Product Description
//                   Text(widget.description,
//                       style: GoogleFonts.poppins(
//                           fontSize: 16, color: Colors.grey[600])),

//                   const SizedBox(height: 16),

//                   // Color Selection Section
//                   Text("Color",
//                       style: GoogleFonts.poppins(
//                           fontSize: 16, fontWeight: FontWeight.bold)),

//                   Row(
//                     children: [
//                       _buildColorOption(Colors.brown),
//                       _buildColorOption(Colors.blue),
//                       _buildColorOption(Colors.black),
//                     ],
//                   ),

//                   const SizedBox(height: 16),

//                   // Size Selection Section
//                   Text("Size",
//                       style: GoogleFonts.poppins(
//                           fontSize: 16, fontWeight: FontWeight.bold)),

//                   Row(
//                     children: ["S", "M", "L", "XL"].map((size) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 4),
//                         child: ChoiceChip(
//                           label: Text(size, style: GoogleFonts.poppins()),
//                           selected: _selectedSize == size,
//                           onSelected: (selected) {
//                             setState(() {
//                               _selectedSize = size; // Update selected size
//                             });
//                           },
//                         ),
//                       );
//                     }).toList(),
//                   ),

//                   const SizedBox(height: 16),

//                   // Price Display
//                   Text("Total Price",
//                       style: GoogleFonts.poppins(
//                           fontSize: 16, fontWeight: FontWeight.bold)),
//                   Text(
//                     widget.price,
//                     style: GoogleFonts.poppins(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: const Color.fromARGB(255, 255, 0, 204)),
//                   ),

//                   const SizedBox(height: 16),

//                   // Notes Section
//                   Text("Notes",
//                       style: GoogleFonts.poppins(
//                           fontSize: 16, fontWeight: FontWeight.bold)),
//                           TextField(
//                     controller: _notesController,
//                     maxLines: 3,
//                     decoration: InputDecoration(
//                       hintText: "Enter your notes here...",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 16),

//                   // Order Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Show a confirmation message
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                               content:
//                                   Text("The product has been added to the cart")),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             const Color.fromARGB(255, 163, 119, 178),
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                       ),
//                       child: Text("Order",
//                           style: GoogleFonts.poppins(
//                               fontSize: 20, color: Colors.white)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Widget to display color options for selection.
//   Widget _buildColorOption(Color color) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedColor = color; // Update selected color
//         });
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 4),
//         width: 30,
//         height: 30,
//         decoration: BoxDecoration(
//           color: color,
//           shape: BoxShape.circle,
//           border: Border.all(
//               color:
//                   _selectedColor == color ? Colors.black : Colors.transparent,
//               width: 2),
//         ),
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_couture/models/bookins.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tailor_profile_page.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  final String title; 
  final String price; 
  final String description; 
  final String fabricType; 
  final String modelId; 
  final String tailorId; 
  final List<String> availableColors;
  final List<String> availableSizes;
  final int progress; 
  final String? imageUrl; 

  const DetailPage({
    Key? key,
    required this.tailorId,
    required this.modelId,
    required this.title,
    required this.price,
    this.progress = 0,
    required this.description,
    required this.fabricType,
    this.availableColors = const [], 
    this.availableSizes = const [],  
    this.imageUrl ,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String tailorName = "";
  String tailorProfileImage = ""; 
  String tailorId = "";



  String _selectedSize = "S";
  bool _isLiked = false;


final List<String> _selectedColors = []; 

Color hexToColor(String hex) {
  return Color(int.parse(hex.replaceFirst('#', '0x')));
}

Widget _buildColorOption(Color color, String hexCode) {
  final isSelected = _selectedColors.contains(hexCode);

  return GestureDetector(
    onTap: () {
      setState(() {
        if (isSelected) {
          _selectedColors.remove(hexCode);
        } else {
          _selectedColors.add(hexCode);
        }
      });
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.black : Colors.grey.shade300,
          width: isSelected ? 3 : 1.5,
        ),
      ),
      child: CircleAvatar(
        radius: 15,
        backgroundColor: color,
      ),
    ),
  );
}

String Idcustomer = FirebaseAuth.instance.currentUser?.uid ?? 'default_user_id';

 void placeOrder(String userId, String tailorId, String modelId, List<String> colors, List<String> sizes, String initialPrice, String modifiedPrice, String note, String categoryId , int progress , String imageUrl) async {
    try {
      Booking newBooking = Booking(
        id: FirebaseFirestore.instance.collection('bookings').doc().id,
        userId: userId,
        tailorId: tailorId,
        modelId: modelId,
        colors: colors,
        sizes: sizes,
        initialprice: initialPrice,
        modifiedprice: modifiedPrice,
        status: "requested",
        createdAt: DateTime.now(),
        categoryId: categoryId,
        note: note,
        progress: 0,
        imageUrl: imageUrl,
        
      );
      Map<String, dynamic> bookingMap = {
        'userId': newBooking.userId,
        'tailorId': newBooking.tailorId,
        'modelId': newBooking.modelId,
        'colors': newBooking.colors,
        'sizes': newBooking.sizes,
        'initialprice': newBooking.initialprice,
        'modifiedprice': newBooking.modifiedprice,
        'status': newBooking.status,
        'createdAt': newBooking.createdAt,
        'categoryId': newBooking.categoryId,
        'note': newBooking.note,
        'progres': "0",
        'imageUrl' : newBooking.imageUrl,
      };
      await FirebaseFirestore.instance.collection('bookings').add(bookingMap);
      print("Order placed successfully!");
    } catch (e) {
      print("Error placing order: $e");
    }
  }

  Future<void> _fetchTailorName() async {
    try {
      DocumentSnapshot tailorDoc = await FirebaseFirestore.instance
          .collection('tailors') 
          .doc(widget.tailorId)
          .get();

      if (tailorDoc.exists) {
        setState(() {
          tailorName = tailorDoc['username']; 
          tailorProfileImage = tailorDoc['profileImage'] ?? '';
        });
      }
    } catch (e) {
      print("Error fetching tailor name: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTailorName();
  }

  TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], 
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, 
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border,
              color: _isLiked ? Colors.red : Colors.black,
            ),
            onPressed: () {
              setState(() {
                _isLiked = !_isLiked; 
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView( 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
            child: Container(
              width: double.infinity,
              height: 300,
              color: Colors.grey[300],
              child: widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                  ? Image.network(
                      widget.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : Center(
                      child: Text(
                        "No Image Available",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
            ),
),
            
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TailorProfilePage(
                            name: tailorName,
                            image: tailorProfileImage,
                            tailorId: widget.tailorId,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        tailorProfileImage.isNotEmpty
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(tailorProfileImage),
                                  radius: 20,
                                )
                              : const CircleAvatar(
                                  backgroundImage: AssetImage("images/asset/5.jpg"),
                                  radius: 20,
                                ),
                          const SizedBox(width: 10),
                        
                        Text(
                          tailorName.isNotEmpty ? tailorName : "Loading...",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  
                  Text(widget.title,
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 16),

                 
                  Text(widget.description,
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.grey[600])),

                  const SizedBox(height: 16),

                  
                  Text("Color",
    style: GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.bold)),

Wrap(
  spacing: 8,
  children: widget.availableColors.map((hex) {
    final color = hexToColor(hex);
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColors.contains(hex)
              ? _selectedColors.remove(hex)
              : _selectedColors.add(hex);
        });
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
              color: _selectedColors.contains(hex)
                  ? Colors.black
                  : Colors.grey.shade300,
              width: 2),
        ),
      ),
    );
  }).toList(),
),

                  const SizedBox(height: 16),

                  
                  Text("Size",
    style: GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.bold)),

const SizedBox(height: 8),

Row(
  children: widget.availableSizes.map((size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(size, style: GoogleFonts.poppins()),
        selected: _selectedSize == size,
        onSelected: (selected) {
          setState(() {
            _selectedSize = size;
          });
        },
      ),
    );
  }).toList(),
),


                  const SizedBox(height: 16),

                  
                  Text("Total Price",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(
                    widget.price,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 255, 0, 204)),
                  ),

                  const SizedBox(height: 16),

                
                  Text("Notes",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                          TextField(
                    controller: _notesController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Enter your notes here...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  
                  SizedBox(
                    width: double.infinity,

                     child: ElevatedButton(
                      onPressed: () {
  String userId = Idcustomer;
  String tailorId = widget.tailorId;
  String modelId = widget.modelId;
  List<String> colors = _selectedColors;
  List<String> sizes = [_selectedSize];
  String initialPrice = widget.price;
  String modifiedPrice = widget.price;
  String note = _notesController.text;
  String categoryId = '6';
  int progress = 0;
  String imageUrl = widget.imageUrl ?? '';

  print("🧾 Placing order with:");
  print("User ID: $userId");
  print("Tailor ID: $tailorId");
  print("Model ID: $modelId");
  print("Colors: $colors");
  print("Sizes: $sizes");
  print("Initial Price: $initialPrice");
  print("Note: $note");


  placeOrder(userId, tailorId, modelId, colors, sizes, initialPrice, modifiedPrice, note, categoryId , progress , imageUrl);
},
                      child: Text("Order"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  // Widget _buildColorOption(Color color) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         _selectedColor = color; 
  //       });
  //     },
  //     child: Container(
  //       margin: const EdgeInsets.symmetric(horizontal: 4),
  //       width: 30,
  //       height: 30,
  //       decoration: BoxDecoration(
  //         color: color,
  //         shape: BoxShape.circle,
  //         border: Border.all(
  //             color:
  //                 _selectedColor == color ? Colors.black : Colors.transparent,
  //             width: 2),
  //       ),
  //     ),
  //   );
  // }
}
