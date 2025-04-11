import 'package:flutter/material.dart';
import 'notifications_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedRectangle = 0; // Stores the index of the selected category
  final Set<String> _likedImages = {}; // Set to track liked images

  // List of categories
  final List<String> categories = [
    'Shirts',
    'Pants',
    'Dresses',
    'Jackets',
    'Accessories'
  ];

  // Mapping categories to image lists
  final Map<String, List<String>> categoryImages = {
    'Shirts': [
      'images/1.jpg',
      'images/2.jpg',
      'images/11.jpg',
      'images/12.jpg',
      'images/9.jpg',
      'images/5.jpg',
      'images/8.jpg'
    ],
    'Pants': ['images/3.jpg', 'images/4.jpg', 'images/12.jpg'],
    'Dresses': ['images/5.jpg', 'images/6.jpg', 'images/13.jpg'],
    'Jackets': ['images/7.jpg', 'images/8.jpg', 'images/14.jpg'],
    'Accessories': ['images/9.jpg', 'images/10.jpg', 'images/15.jpg'],
  };

  // Function to navigate to the notifications screen
  void openNotificationScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationPage()),
    );
  }

  // Function to handle category selection
  void _onRectangleTapped(int index) {
    setState(() {
      _selectedRectangle = index;
    });
  }

  // Function to toggle image like state
  void _toggleLike(String imagePath) {
    setState(() {
      if (_likedImages.contains(imagePath)) {
        _likedImages.remove(imagePath);
      } else {
        _likedImages.add(imagePath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      // App bar with search and notification icon
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: const Color.fromARGB(255, 221, 211, 223),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.notifications,
                  color: Color.fromARGB(255, 78, 64, 57)),
              onPressed: () => openNotificationScreen(context),
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          // Horizontal category list
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => _onRectangleTapped(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 120,
                  decoration: BoxDecoration(
                    color: _selectedRectangle == index
                        ? Color.fromARGB(255, 163, 119, 178)
                        : Color.fromARGB(255, 207, 186, 221),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: _selectedRectangle == index
                        ? [
                            BoxShadow(
                              color: Color.fromARGB(
                                  (255 * 0.4).toInt(), 224, 99, 247),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            )
                          ]
                        : [],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      fontSize: 14,
                      color: _selectedRectangle == index
                          ? Colors.white
                          : Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Grid of images
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8, // Adjust this for image proportions
              ),
              itemCount: categoryImages[categories[_selectedRectangle]]!.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final images = categoryImages[categories[_selectedRectangle]]!;
                final imagePath = images[index];

                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        imagePath: imagePath,
                        title: "Kaftan", 
                        price: "12000 DA", 
                        description: "Modern kaftan with a beautiful touch.",
                        fabricType: "Silk", // Added missing required argument
                      ),
                    ),
                  ),
                  onDoubleTap: () => _toggleLike(imagePath),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.contain, // Preserve original aspect ratio
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: Icon(
                            _likedImages.contains(imagePath)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _likedImages.contains(imagePath)
                                ? Colors.red
                                : Colors.white,
                          ),
                          onPressed: () {
                            _toggleLike(imagePath);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
