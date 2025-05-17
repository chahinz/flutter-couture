

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_couture/models/model.dart';
import 'notifications_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedRectangle = 0; 
  final Set<String> _likedModelIds = {}; 

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Model> _models = [];

  @override
  void initState() {
    super.initState();
    _fetchModels();
  }


//   Future<void> _fetchModels() async {
//   try {
//     final snapshot = await _firestore.collection('models').get();
//     setState(() {
//       _models = snapshot.docs.map((doc) {
//         var modelData = doc.data() as Map<String, dynamic>;

//         // Debug the data here
//         print(modelData); 

//         modelData['colors'] = modelData['colors'] != null
//             ? List<String>.from(modelData['colors'].map((e) => e.toString()))
//             : [];
//         modelData['sizes'] = modelData['sizes'] != null
//             ? List<String>.from(modelData['sizes'].map((e) => e.toString()))
//             : [];

//         return Model.fromJson(modelData); 
//       }).toList();
//     });
//   } catch (e) {
//     print('Error fetching models: $e');
//   }
// }

Future<void> _fetchModels() async {
  try {
    final snapshot = await _firestore.collection('models').get();

    final models = snapshot.docs.map((doc) {
      var modelData = doc.data() as Map<String, dynamic>;

      print("🔍 Raw Firestore model data: $modelData");

      modelData['colors'] = modelData['colors'] != null
          ? List<String>.from(modelData['colors'].map((e) => e.toString()))
          : [];
      modelData['sizes'] = modelData['sizes'] != null
          ? List<String>.from(modelData['sizes'].map((e) => e.toString()))
          : [];

      final model = Model.fromJson(modelData);

      print("✅ Model parsed: Name=${model.name}, ID=${model.modelId}, ImageURL=${model.imageUrl}");

      return model;
    }).toList();

    setState(() {
      _models = models;
    });
  } catch (e) {
    print('❌ Error fetching models: $e');
  }
}


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
    'Shirts': ['images/1.jpg', 'images/asset/2.jpg'],
    'Pants': ['images/asset/3.jpg', 'images/asset/4.jpg'],
    'Dresses': ['images/asset/5.jpg', 'images/asset/6.jpg'],
    'Jackets': ['images/asset/7.jpg', 'images/asset/8.jpg'],
    'Accessories': ['images/asset/9.jpg', 'images/asset/10.jpg'],
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

  // Function to toggle like state for a model using its modelId
  void _toggleLike(String modelId) {
    setState(() {
      if (_likedModelIds.contains(modelId)) {
        _likedModelIds.remove(modelId);
      } else {
        _likedModelIds.add(modelId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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

          // Grid of models (from Firestore)
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8, // Adjust this for image proportions
              ),
              itemCount: _models.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final model = _models[index];
                final String modelId = model.modelId ?? 'unknown'; 
                final String name = model.name ;
                final String price = model.price;
                final String description = model.description ?? 'No description available';
                final String tailorId = model.idTailor ?? '';
                final String? imageUrl = model.imageUrl;

                print("✅ Model parsed: Name=${model.name}, ID=${model.modelId}, ImageURL=${model.imageUrl}");

                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        tailorId: tailorId,
                        modelId: modelId,
                        title: name,
                        price: price,
                        description: description,
                        fabricType: 'satin' ,
                        availableColors: model.colors ?? [],
                        availableSizes: model.sizes ?? [],
                        imageUrl :  model.imageUrl,
                      ),
                    ),
                  ),
                  onDoubleTap: () => _toggleLike(modelId),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: model.imageUrl != null && model.imageUrl!.isNotEmpty
                                  ? Image.network(
                                      model.imageUrl!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return const Center(child: CircularProgressIndicator());
                                      },
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        color: Colors.grey,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Image error',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      color: Colors.grey[300],
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'pas disponiible',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                            ),

                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: Icon(
                            _likedModelIds.contains(modelId)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _likedModelIds.contains(modelId)
                                ? Colors.red
                                : Colors.white,
                          ),
                          onPressed: () {
                            _toggleLike(modelId);
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
