import 'package:flutter/material.dart';
import 'detail_page.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  final List<String> allImages = [
    'images/1.jpg', 'images/2.jpg', 'images/3.jpg', 'images/4.jpg',
    'images/5.jpg', 'images/6.jpg', 'images/7.jpg', 'images/8.jpg',
    'images/9.jpg', 'images/10.jpg', 'images/11.jpg', 'images/12.jpg',
    'images/13.jpg', 'images/14.jpg', 'images/15.jpg'
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
                      imagePath: imagePath,
                      title: "Kaftan",
                      price: "12000 DA",
                      description: "Modern kaftan with a beautiful touch.",
                      fabricType: "Silk",
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
