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
        {'title': "Suits", 'image': 'images/asset/22.jpg'},
        {'title': "Jackets", 'image': 'images/asset/23.jpg'},
        {'title': "Hoodies", 'image': 'images/asset/24.jpg'},
        {'title': "Trousers", 'image': 'images/asset/25.jpg'},
        {'title': "T-Shirts", 'image': 'images/asset/26.jpg'},
        {'title': "Traditional", 'image': 'images/asset/27.jpg'},
        {'title': "Shorts", 'image': 'images/asset/28.jpg'},
        {'title': "Swimsuits", 'image': 'images/asset/29.jpg'},
        {'title': "Kamis", 'image': 'images/asset/30.jpg'},
        {'title': "Hats", 'image': 'images/asset/32.jpg'},
        {'title': "Sport Outfits", 'image': 'images/asset/33.jpg'},
        {'title': "Pajamas", 'image': 'images/asset/31.jpg'},
      ],
      "women": [
        {'title': "Special Occasions (Traditional)", 'image': 'images/asset/34.jpg'},
        {'title': "Special Occasions (Soirées)", 'image': 'images/asset/35.jpg'},
        {'title': "Wedding Dresses", 'image': 'images/asset/36.jpg'},
        {'title': "Hijabat", 'image': 'images/asset/37.jpg'},
        {'title': "Classic", 'image': 'images/asset/38.jpg'},
        {'title': "Gandoura", 'image': 'images/asset/39.jpg'},
        {'title': "Jeans", 'image': 'images/asset/40.jpg'},
        {'title': "Pajamas", 'image': 'images/asset/41.jpg'},
        {'title': "Casual Dresses", 'image': 'images/asset/42.jpg'},
        {'title': "Chemises", 'image': 'images/asset/43.jpg'},
        {'title': "T-Shirts", 'image': 'images/asset/44.jpg'},
        {'title': "Swimsuits", 'image': 'images/asset/83.jpg'},
        {'title': "Sport Outfits", 'image': 'images/asset/82.jpg'},
        {'title': "Skirts", 'image': 'images/asset/85.jpg'},
        {'title': "Jackets", 'image': 'images/asset/84.jpg'},


          
      ],
      "kids": [
        {'title': "Traditional", 'image': 'images/asset/45.jpg'},
        {'title': "Dresses", 'image': 'images/asset/46.jpg'},
        {'title': "Trousers", 'image': 'images/asset/47.jpg'},
        {'title': "T-Shirts", 'image': 'images/asset/48.jpg'},
        {'title': "Jackets", 'image': 'images/asset/49.jpg'},
        {'title': "Swimsuit", 'image': 'images/asset/50.jpg'},
        {'title': "Sport Clothes", 'image': 'images/asset/51.jpg'},
        {'title': "Pajamas", 'image': 'images/asset/53.jpg'},
      ],
      "babies": [
        {'title': "Dresses", 'image': 'images/asset/54.jpg'},
        {'title': "T-Shirts", 'image': 'images/asset/57.jpg'},
        {'title': "Trousers", 'image': 'images/asset/58.jpg'},
        {'title': "Pajamas", 'image': 'images/asset/59.jpg'},
        {'title': "Gloves", 'image': 'images/asset/60.jpg'},
        {'title': "Jackets", 'image': 'images/asset/61.jpg'},
      ],
      "knitting": [
        {'title': "cardigan", 'image': 'images/asset/62.jpg'},
        {'title': "Dresses", 'image': 'images/asset/63.jpg'},
        {'title': "Hats", 'image': 'images/asset/64.jpg'},
        {'title': "Gloves", 'image': 'images/asset/65.jpg'},
        {'title': "Scarf", 'image': 'images/asset/66.jpg'},
        {'title': "Socks", 'image': 'images/asset/67.jpg'},
      ],
      "home textile": [
        {'title': "Curtains", 'image': 'images/asset/68.jpg'},
        {'title': "Table Coverings", 'image': 'images/asset/69.jpg'},
        {'title': "Bedding Set", 'image': 'images/asset/70.jpg'},
        {'title': "Tafrisha", 'image': 'images/asset/71.jpg'},
        {'title': "Carpets", 'image': 'images/asset/72.jpg'},
      ],
      "accessories & add-ons": [
        {'title': "Necklace", 'image': 'images/asset/73.jpg'},
        {'title': "Bags", 'image': 'images/asset/74.jpg'},
        {'title': "Earrings", 'image': 'images/asset/75.jpg'},
        {'title': "Rings", 'image': 'images/asset/76.jpg'},
        {'title': "Gloves", 'image': 'images/asset/77.jpg'},
        {'title': "Hairclips", 'image': 'images/asset/78.jpg'},
        {'title': "Flowers Bouquet (Brides)", 'image': 'images/asset/79.jpg'},
      ],
      "graduation": [
        {'title': "Simple", 'image': 'images/asset/80.jpg'},
        {'title': "Complicated", 'image': 'images/asset/81.jpg'},
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
