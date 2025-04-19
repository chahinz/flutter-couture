import 'package:flutter/material.dart';
import 'detail_page.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  final List<String> allImages = [
    'images/1.jpg', 'images/asset/2.jpg', 'images/asset/3.jpg', 'images/asset/4.jpg',
    'images/asset/5.jpg', 'images/asset/6.jpg', 'images/asset/7.jpg', 'images/asset/8.jpg',
    'images/asset/9.jpg', 'images/asset/10.jpg', 'images/asset/11.jpg', 'images/asset/12.jpg',
    'images/asset/13.jpg', 'images/asset/14.jpg', 'images/asset/15.jpg'
  ];

  void _removeImage(String imagePath) {
    setState(() {
      allImages.remove(imagePath);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
     
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: allImages.length,
          itemBuilder: (context, index) {
            final imagePath = allImages[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      // imagePath: imagePath,
                      tailorId: "",
                      modelId: "",
                      title: "Kaftan",
                      price: "12000 DA",
                      description: "Modern kaftan with a beautiful touch.",
                      fabricType: "Silk",
                      availableSizes: [],
                      availableColors:  [],
                    ),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.center,
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
                    child: IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 30,
                      ),
                      onPressed: () => _removeImage(imagePath),
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
