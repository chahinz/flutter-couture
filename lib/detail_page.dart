import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tailor_profile_page.dart';

/// DetailPage represents the detailed view of a product.
/// It includes product images, description, color and size selection,
/// pricing, notes section, and an order button.
class DetailPage extends StatefulWidget {
  final String imagePath; // Path to the product image
  final String title; // Product name
  final String price; // Product price
  final String description; // Description of the product
  final String fabricType; // Fabric type of the product

  // Constructor to receive product details
  const DetailPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.description,
    required this.fabricType,
  });

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // Selected color for the product
  Color _selectedColor = Colors.brown;

  // Selected size for the product
  String _selectedSize = "S";

  // Boolean flag to track whether the product is liked or not
  bool _isLiked = false;

  // Tailor's details (Hardcoded for now)
  static const String tailorName = "Ines Tailor";
  static const String tailorProfileImage = "images/5.jpg";

  // Controller for the notes text field
  TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light grey background
      appBar: AppBar(
        backgroundColor: Colors.white, // White app bar
        elevation: 0, // Removes shadow effect
        iconTheme: const IconThemeData(color: Colors.black), // Black back button
        actions: [
          // Favorite (Like) button
          IconButton(
            icon: Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border,
              color: _isLiked ? Colors.red : Colors.black,
            ),
            onPressed: () {
              setState(() {
                _isLiked = !_isLiked; // Toggle like status
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView( // Makes the screen scrollable
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Display
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Rounded corners
                child: Image.asset(
                  widget.imagePath,
                  height: 300,
                  fit: BoxFit.cover, // Maintains aspect ratio
                ),
              ),
            ),
            
            // Product Details Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [// Tailor's Profile (Clickable)
                  GestureDetector(
                    onTap: () {
                      // Navigate to Tailor's Profile Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TailorProfilePage(
                            name: tailorName,
                            image: tailorProfileImage,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        // Tailor's Profile Picture
                        const CircleAvatar(
                          backgroundImage: AssetImage(tailorProfileImage),
                          radius: 20,
                        ),
                        const SizedBox(width: 10),
                        // Tailor's Name
                        Text(
                          tailorName,
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Product Title
                  Text(widget.title,
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 16),

                  // Product Description
                  Text(widget.description,
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.grey[600])),

                  const SizedBox(height: 16),

                  // Color Selection Section
                  Text("Color",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold)),

                  Row(
                    children: [
                      _buildColorOption(Colors.brown),
                      _buildColorOption(Colors.blue),
                      _buildColorOption(Colors.black),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Size Selection Section
                  Text("Size",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold)),

                  Row(
                    children: ["S", "M", "L", "XL"].map((size) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ChoiceChip(
                          label: Text(size, style: GoogleFonts.poppins()),
                          selected: _selectedSize == size,
                          onSelected: (selected) {
                            setState(() {
                              _selectedSize = size; // Update selected size
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16),

                  // Price Display
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

                  // Notes Section
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

                  // Order Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Show a confirmation message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text("The product has been added to the cart")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 163, 119, 178),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text("Order",
                          style: GoogleFonts.poppins(
                              fontSize: 20, color: Colors.white)),
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

  /// Widget to display color options for selection.
  Widget _buildColorOption(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color; // Update selected color
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
              color:
                  _selectedColor == color ? Colors.black : Colors.transparent,
              width: 2),
        ),
      ),
    );
  }
}