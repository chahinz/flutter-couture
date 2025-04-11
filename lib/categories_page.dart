import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sub_categories_page.dart';

// StatelessWidget for displaying the main categories page
class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of categories with their titles and corresponding image paths
    final List<Map<String, String>> categories = [
      {'title': "Men", 'image': 'images/menswear2.jpg'},
      {'title': "Women", 'image': 'images/womenswear2.jpg'},
      {'title': "Kids", 'image': 'images/kidswear.jpg'},
      {'title': "Babies", 'image': 'images/kidswear2.jpg'},
      {'title': "Knitting", 'image': 'images/fabricbased.jpg'},
      {'title': "Accessories & Add-ons", 'image': 'images/accessories.jpg'},
      {'title': "Graduation", 'image': 'images/55.jpg'},
      {'title': "Home textile", 'image': 'images/hometextiles.jpg'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        centerTitle: true, // Centers the title in the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(), // Adds a bounce effect when scrolling
          itemCount: categories.length, // Number of categories to display
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigates to the sub-category page when a category is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubCategoriesPage(
                      mainCategory: categories[index]['title']!, // Passes selected category title
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners for card
                ),
                margin: const EdgeInsets.symmetric(vertical: 8), // Adds vertical spacing between cards
                elevation: 4, // Adds shadow effect to the card
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Clips child widgets to match card's rounded corners
                  child: Stack(
                    alignment: Alignment.center, // Aligns all child widgets to the center
                    children: [
                      // Displays category image
                      Image.asset(
                        categories[index]['image']!,
                        height: 180, 
                        width: double.infinity, 
                        fit: BoxFit.cover, 
                      ),
                      // Adds a semi-transparent black overlay for better text visibility
                      Container(
                        height: 180, // Matches image height
                        color: Colors.black.withOpacity(0.3),
                      ),
                      // Displays category title at the bottom of the card
                      Positioned(
                        bottom: 15, // Adjusts position of text inside the card
                        child: Text(
                          categories[index]['title']!,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // White color for contrast
                          ),
                          textAlign: TextAlign.center, // Centers text
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
