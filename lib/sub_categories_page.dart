import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'category_explore_page .dart';

class SubCategoriesPage extends StatelessWidget {
  final String mainCategory;

  const SubCategoriesPage({super.key, required this.mainCategory});

  @override
  Widget build(BuildContext context) {
    final selectedCategory = mainCategory.toLowerCase();

    final Map<String, List<Map<String, String>>> subcategories = {
      "men": [
        {'title': "Suits", 'image': 'images/22.jpg'},
        {'title': "Jackets", 'image': 'images/23.jpg'},
        {'title': "Hoodies", 'image': 'images/24.jpg'},
        {'title': "Trousers", 'image': 'images/25.jpg'},
        {'title': "T-Shirts", 'image': 'images/26.jpg'},
        {'title': "Traditional", 'image': 'images/27.jpg'},
        {'title': "Shorts", 'image': 'images/28.jpg'},
        {'title': "Swimsuits", 'image': 'images/29.jpg'},
        {'title': "Kamis", 'image': 'images/30.jpg'},
        {'title': "Hats", 'image': 'images/32.jpg'},
        {'title': "Sport Outfits", 'image': 'images/33.jpg'},
        {'title': "Pajamas", 'image': 'images/31.jpg'},
      ],
      "women": [
        {'title': "Special Occasions (Traditional)", 'image': 'images/34.jpg'},
        {'title': "Special Occasions (Soirées)", 'image': 'images/35.jpg'},
        {'title': "Wedding Dresses", 'image': 'images/36.jpg'},
        {'title': "Hijabat", 'image': 'images/37.jpg'},
        {'title': "Classic", 'image': 'images/38.jpg'},
        {'title': "Gandoura", 'image': 'images/39.jpg'},
        {'title': "Jeans", 'image': 'images/40.jpg'},
        {'title': "Pajamas", 'image': 'images/41.jpg'},
        {'title': "Casual Dresses", 'image': 'images/42.jpg'},
        {'title': "Chemises", 'image': 'images/43.jpg'},
        {'title': "T-Shirts", 'image': 'images/44.jpg'},
        {'title': "Swimsuits", 'image': 'images/83.jpg'},
        {'title': "Sport Outfits", 'image': 'images/82.jpg'},
        {'title': "Skirts", 'image': 'images/85.jpg'},
        {'title': "Jackets", 'image': 'images/84.jpg'},


          
      ],
      "kids": [
        {'title': "Traditional", 'image': 'images/45.jpg'},
        {'title': "Dresses", 'image': 'images/46.jpg'},
        {'title': "Trousers", 'image': 'images/47.jpg'},
        {'title': "T-Shirts", 'image': 'images/48.jpg'},
        {'title': "Jackets", 'image': 'images/49.jpg'},
        {'title': "Swimsuit", 'image': 'images/50.jpg'},
        {'title': "Sport Clothes", 'image': 'images/51.jpg'},
        {'title': "Pajamas", 'image': 'images/53.jpg'},
      ],
      "babies": [
        {'title': "Dresses", 'image': 'images/54.jpg'},
        {'title': "T-Shirts", 'image': 'images/57.jpg'},
        {'title': "Trousers", 'image': 'images/58.jpg'},
        {'title': "Pajamas", 'image': 'images/59.jpg'},
        {'title': "Gloves", 'image': 'images/60.jpg'},
        {'title': "Jackets", 'image': 'images/61.jpg'},
      ],
      "knitting": [
        {'title': "cardigan", 'image': 'images/62.jpg'},
        {'title': "Dresses", 'image': 'images/63.jpg'},
        {'title': "Hats", 'image': 'images/64.jpg'},
        {'title': "Gloves", 'image': 'images/65.jpg'},
        {'title': "Scarf", 'image': 'images/66.jpg'},
        {'title': "Socks", 'image': 'images/67.jpg'},
      ],
      "home textile": [
        {'title': "Curtains", 'image': 'images/68.jpg'},
        {'title': "Table Coverings", 'image': 'images/69.jpg'},
        {'title': "Bedding Set", 'image': 'images/70.jpg'},
        {'title': "Tafrisha", 'image': 'images/71.jpg'},
        {'title': "Carpets", 'image': 'images/72.jpg'},
      ],
      "accessories & add-ons": [
        {'title': "Necklace", 'image': 'images/73.jpg'},
        {'title': "Bags", 'image': 'images/74.jpg'},
        {'title': "Earrings", 'image': 'images/75.jpg'},
        {'title': "Rings", 'image': 'images/76.jpg'},
        {'title': "Gloves", 'image': 'images/77.jpg'},
        {'title': "Hairclips", 'image': 'images/78.jpg'},
        {'title': "Flowers Bouquet (Brides)", 'image': 'images/79.jpg'},
      ],
      "graduation": [
        {'title': "Simple", 'image': 'images/80.jpg'},
        {'title': "Complicated", 'image': 'images/81.jpg'},
      ],
    };

    final List<Map<String, String>>? selectedSubcategories =
        subcategories[selectedCategory];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          mainCategory,
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: selectedSubcategories == null
          ? Center(
              child: Text(
                "No Subcategories Available",
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: selectedSubcategories.length,
              itemBuilder: (context, index) {
                final subcategory = selectedSubcategories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryExplorePage(
                          subCategoryTitle: subcategory['title']!,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding:
                 const EdgeInsets.symmetric(vertical: 8),
                 
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            subcategory['image']!,
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
                              subcategory['title']!,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
