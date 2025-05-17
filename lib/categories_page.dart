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
      {'title': "Men", 'image': 'images/asset/menswear2.jpg'},
      {'title': "Women", 'image': 'images/asset/womenswear2.jpg'},
      {'title': "Kids", 'image': 'images/asset/kidswear.jpg'},
      {'title': "Babies", 'image': 'images/asset/kidswear2.jpg'},
      {'title': "Knitting", 'image': 'images/asset/fabricbased.jpg'},
      {'title': "Accessories & Add-ons", 'image': 'images/asset/accessories.jpg'},
      {'title': "Graduation", 'image': 'images/asset/55.jpg'},
      {'title': "Home textile", 'image': 'images/asset/hometextiles.jpg'},
    ];


    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        centerTitle: true, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(), 
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubCategoriesPage(
                      mainCategory: categories[index]['title']!,
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8), 
                elevation: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), 
                  child: Stack(
                    alignment: Alignment.center, 
                    children: [
                     
                      Image.asset(
                        categories[index]['image']!,
                        height: 180, 
                        width: double.infinity, 
                        fit: BoxFit.cover, 
                      ),
                     
                      Container(
                        height: 180, 
                        color: Colors.black.withOpacity(0.3),
                      ),
                    
                      Positioned(
                        bottom: 15, 
                        child: Text(
                          categories[index]['title']!,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, 
                          ),
                          textAlign: TextAlign.center, 
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
