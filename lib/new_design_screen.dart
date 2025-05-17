import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// NewDesignScreen represents the detailed view of a tailor's design submission
/// for admin review. It includes design images, description, fabric details,
/// and admin approval controls.
class NewDesignScreen extends StatefulWidget {
  final String title; // Design name
  final String price; // Design price
  final String description; // Description of the design
  final String fabricType; // Fabric type of the design
  final String tailorName; // Name of the tailor who submitted
  final String tailorImage; // Profile image of the tailor

  // Constructor to receive design details
  const NewDesignScreen({
    super.key,
    required this.title,
    required this.price,
    required this.description,
    required this.fabricType,
    required this.tailorName,
    required this.tailorImage,
  });

  @override
  _NewDesignScreenState createState() => _NewDesignScreenState();
}

class _NewDesignScreenState extends State<NewDesignScreen> {
  // List of available sizes for this design
  final List<String> availableSizes = ["S", "M", "L", "XL"];

  // List of available colors for this design
  final List<Color> availableColors = [Colors.brown, Colors.blue, Colors.black];

  // List of available modifications with prices (read-only for admin)
  final List<Map<String, dynamic>> availableModifications = [
    {"modification": "Sleeve Adjustment", "price": "500"},
    {"modification": "Length Adjustment", "price": "300"},
    {"modification": "Neckline Change", "price": "400"},
    {"modification": "Waist Adjustment", "price": "350"},
  ];

  // Function to show confirmation dialog for approval
  Future<void> _showApprovalConfirmation(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Approval', style: GoogleFonts.poppins()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to approve this design?', 
                     style: GoogleFonts.poppins()),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: GoogleFonts.poppins()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Approve', style: GoogleFonts.poppins(color: Colors.green)),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Design approved successfully")),
                );
                Navigator.pop(context); // Close the design screen
              },
            ),
          ],
        );
      },
    );
  }
  
  // Function to show confirmation dialog for rejection
  Future<void> _showRejectionConfirmation(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Rejection', style: GoogleFonts.poppins()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to reject this design?', 
                     style: GoogleFonts.poppins()),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: GoogleFonts.poppins()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Reject', style: GoogleFonts.poppins(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Design rejected")),
                );
                Navigator.pop(context); // Close the design screen
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: null, // Removed the app bar
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Design Image Display - Now using images/18.jpg
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "images/18.jpg", // Changed to use the specified image
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Design Details Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tailor Information
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(widget.tailorImage),
                        radius: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.tailorName,
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Design Title
                  Text("Design Title: ${widget.title}",
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 16),

                  // Design Description
                  Text("Description:",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(widget.description,
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.grey[600])),
                          const SizedBox(height: 16),
                  // Fabric Type
                  Text("Fabric Type:",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(widget.fabricType,
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.grey[600])),

                  const SizedBox(height: 16),
  
                  // Pricing Information
                  Text("Pricing:",
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

                  // Available Sizes
                  Text("Available Sizes:",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Wrap(
                    spacing: 8,
                    children: availableSizes.map((size) {
                      return Chip(
                        label: Text(size, style: GoogleFonts.poppins()),
                        backgroundColor: Colors.grey[300],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  
                  // Available Colors
                  Text("Available Colors:",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    children: availableColors.map((color) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 30,height: 30,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16),

                  // Requested Modifications Section (read-only)
                  Text("Requested Modifications:",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Column(
                    children: availableModifications.map((modification) {
                      return ListTile(
                        title: Text(modification['modification'],
                            style: GoogleFonts.poppins()),
                        trailing: Text("${modification['price']} DA",
                            style: GoogleFonts.poppins()),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Reject Button
                      ElevatedButton(
                        onPressed: () {
                          _showRejectionConfirmation(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        child: Text("Reject",
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: Colors.white)),
                      ),

                      // Approve Button
                      ElevatedButton(
                        onPressed: () {
                          _showApprovalConfirmation(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        child: Text("Accept",
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}