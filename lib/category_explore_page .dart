import 'package:flutter/material.dart';
import 'detail_page.dart';

class CategoryExplorePage extends StatefulWidget {
  final String subCategoryTitle;

  const CategoryExplorePage({super.key, required this.subCategoryTitle});

  @override
  State<CategoryExplorePage> createState() => _CategoryExplorePageState();
}

class _CategoryExplorePageState extends State<CategoryExplorePage> {
  final List<String> allImages = [
    'images/asset/1.jpg', 'images/asset/2.jpg', 'images/asset/3.jpg', 'images/asset/4.jpg',
    'images/asset/5.jpg', 'images/asset/6.jpg', 'images/asset/7.jpg', 'images/asset/8.jpg',
    'images/asset/9.jpg', 'images/asset/10.jpg', 'images/asset/11.jpg', 'images/asset/12.jpg',
  ];

  // قائمة لحالة الإعجاب بالصور
  final Set<String> likedImages = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subCategoryTitle),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.65, // تعديل الأبعاد لتكون أقرب للصورة المرفقة
          ),
          itemCount: allImages.length,
          itemBuilder: (context, index) {
            final imagePath = allImages[index];
            final isLiked = likedImages.contains(imagePath); // ✅ تحديد حالة الإعجاب

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      // imagePath: imagePath,
                      title: widget.subCategoryTitle,
                      price: "12000 DA",
                      description: "Modern kaftan with a beautiful touch.",
                      fabricType: "Silk",
                      modelId: "",
                      tailorId: "",
                       // mofiy this
                       availableColors: [], // list of hex strings
                      availableSizes: [],
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isLiked) {
                            likedImages.remove(imagePath);
                          } else {
                            likedImages.add(imagePath);
                          }
                        });
                      },
                      child: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.white, 
                        size: 30, 
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      color: Colors.black54,
                      child: Text(
                        widget.subCategoryTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}