// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'notifications_page.dart';
// import 'detail_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
  

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedRectangle = 0; // Stores the index of the selected category
//   final Set<String> _likedImages = {}; // Set to track liked images

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List<Map<String, dynamic>> _models = [];
//    @override
//   void initState() {
//     super.initState();
//     // Fetch models from Firestore
//     _fetchModels();
//   }

//    Future<void> _fetchModels() async {
//     try {
//       final snapshot = await _firestore.collection('models').get();
//       setState(() {
//         _models = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//       });
//     } catch (e) {
//       print('Error fetching models: $e');
//     }
//   }


//   // List of categories
//   final List<String> categories = [
//     'Shirts',
//     'Pants',
//     'Dresses',
//     'Jackets',
//     'Accessories'
//   ];

//   // Mapping categories to image lists
//   final Map<String, List<String>> categoryImages = {
//     'Shirts': [
//       'images/1.jpg',
//       'images/asset/2.jpg',
//       'images/asset/11.jpg',
//       'images/asset/12.jpg',
//       'images/asset/9.jpg',
//       'images/asset/5.jpg',
//       'images/asset/8.jpg'
//     ],
//     'Pants': ['images/asset/3.jpg', 'images/asset/4.jpg', 'images/asset/12.jpg'],
//     'Dresses': ['images/asset/5.jpg', 'images/asset/6.jpg', 'images/asset/13.jpg'],
//     'Jackets': ['images/asset/7.jpg', 'images/asset/8.jpg', 'images/asset/14.jpg'],
//     'Accessories': ['images/asset/9.jpg', 'images/asset/10.jpg', 'images/asset/15.jpg'],
//   };

//   // Function to navigate to the notifications screen
//   void openNotificationScreen(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const NotificationPage()),
//     );
//   }

//   // Function to handle category selection
//   void _onRectangleTapped(int index) {
//     setState(() {
//       _selectedRectangle = index;
//     });
//   }

//   // Function to toggle image like state
//   void _toggleLike(String imagePath) {
//     setState(() {
//       if (_likedImages.contains(imagePath)) {
//         _likedImages.remove(imagePath);
//       } else {
//         _likedImages.add(imagePath);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],

//       // App bar with search and notification icon
//       appBar: AppBar(
//         backgroundColor: Colors.grey[200],
//         elevation: 0,
//         title: Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   hintText: "Search",
//                   prefixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide.none,
//                   ),
//                   fillColor: const Color.fromARGB(255, 221, 211, 223),
//                   filled: true,
//                   contentPadding: const EdgeInsets.symmetric(vertical: 0),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             IconButton(
//               icon: const Icon(Icons.notifications,
//                   color: Color.fromARGB(255, 78, 64, 57)),
//               onPressed: () => openNotificationScreen(context),
//             ),
//           ],
//         ),
//       ),

//       body: Column(
//         children: [
//           const SizedBox(height: 10),

//           // Horizontal category list
//           SizedBox(
//             height: 40,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: categories.length,
//               itemBuilder: (context, index) => GestureDetector(
//                 onTap: () => _onRectangleTapped(index),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   margin: const EdgeInsets.symmetric(horizontal: 5),
//                   width: 120,
//                   decoration: BoxDecoration(
//                     color: _selectedRectangle == index
//                         ? Color.fromARGB(255, 163, 119, 178)
//                         : Color.fromARGB(255, 207, 186, 221),
//                     borderRadius: BorderRadius.circular(50),
//                     boxShadow: _selectedRectangle == index
//                         ? [
//                             BoxShadow(
//                               color: Color.fromARGB(
//                                   (255 * 0.4).toInt(), 224, 99, 247),
//                               blurRadius: 6,
//                               offset: const Offset(0, 2),
//                             )
//                           ]
//                         : [],
//                   ),
//                   alignment: Alignment.center,
//                   child: Text(
//                     categories[index],
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: _selectedRectangle == index
//                           ? Colors.white
//                           : Color.fromARGB(255, 0, 0, 0),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 10),

//           // Grid of images
//           Expanded(
//             child: GridView.builder(
//               shrinkWrap: true,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 0.8, // Adjust this for image proportions
//               ),
//               itemCount: categoryImages[categories[_selectedRectangle]]!.length,
//               padding: const EdgeInsets.all(10),
//               itemBuilder: (context, index) {
//                 final images = categoryImages[categories[_selectedRectangle]]!;
//                 final imagePath = images[index];

//                 return GestureDetector(
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DetailPage(
//                         imagePath: imagePath,
//                         title: "Kaftan", 
//                         price: "12000 DA", 
//                         description: "Modern kaftan with a beautiful touch.",
//                         fabricType: "Silk", // Added missing required argument
//                       ),
//                     ),
//                   ),
//                   onDoubleTap: () => _toggleLike(imagePath),
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(20),
//                         child: Image.asset(
//                           imagePath,
//                           fit: BoxFit.contain, // Preserve original aspect ratio
//                         ),
//                       ),
//                       Positioned(
//                         top: 8,
//                         right: 8,
//                         child: IconButton(
//                           icon: Icon(
//                             _likedImages.contains(imagePath)
//                                 ? Icons.favorite
//                                 : Icons.favorite_border,
//                             color: _likedImages.contains(imagePath)
//                                 ? Colors.red
//                                 : Colors.white,
//                           ),
//                           onPressed: () {
//                             _toggleLike(imagePath);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }









// /////////////////
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'notifications_page.dart';
// import 'detail_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedRectangle = 0; // Stores the index of the selected category
//   final Set<String> _likedModelIds = {}; // Set to track liked model IDs

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List<Map<String, dynamic>> _models = [];
  
//   @override
//   void initState() {
//     super.initState();
//     // Fetch models from Firestore
//     _fetchModels();
//   }

//   // Future<void> _fetchModels() async {
//   //   try {
//   //     final snapshot = await _firestore.collection('models').get();
//   //     setState(() {
//   //       _models = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//   //     });
//   //   } catch (e) {
//   //     print('Error fetching models: $e');
//   //   }
//   // }

// // Future<void> _fetchModels() async {
// //   try {
// //     final snapshot = await _firestore.collection('models').get();
// //     setState(() {
// //       _models = snapshot.docs.map((doc) {
// //         var modelData = doc.data() as Map<String, dynamic>;
// //         modelData['colors'] = List<String>.from(modelData['colors'] ?? []);
// //         modelData['sizes'] = List<String>.from(modelData['sizes'] ?? []);

// //         return modelData;
// //       }).toList();
// //     });
// //   } catch (e) {
// //     print('Error fetching models: $e');
// //   }
// // }

// Future<void> _fetchModels() async {
//   try {
//     final snapshot = await _firestore.collection('models').get();
//     setState(() {
//       _models = snapshot.docs.map((doc) {
//         var modelData = doc.data() as Map<String, dynamic>;

//         modelData['colors'] = modelData['colors'] != null
//             ? List<String>.from(modelData['colors'].map((e) => e.toString()))
//             : [];

//         modelData['sizes'] = modelData['sizes'] != null
//             ? List<String>.from(modelData['sizes'].map((e) => e.toString()))
//             : [];

//         return modelData;
//       }).toList();
//     });
//   } catch (e) {
//     print('Error fetching models: $e');
//   }
// }


//   // List of categories
//   final List<String> categories = [
//     'Shirts',
//     'Pants',
//     'Dresses',
//     'Jackets',
//     'Accessories'
//   ];

//   // Mapping categories to image lists
//   final Map<String, List<String>> categoryImages = {
//     'Shirts': ['images/1.jpg', 'images/asset/2.jpg'],
//     'Pants': ['images/asset/3.jpg', 'images/asset/4.jpg'],
//     'Dresses': ['images/asset/5.jpg', 'images/asset/6.jpg'],
//     'Jackets': ['images/asset/7.jpg', 'images/asset/8.jpg'],
//     'Accessories': ['images/asset/9.jpg', 'images/asset/10.jpg'],
//   };

//   // Function to navigate to the notifications screen
//   void openNotificationScreen(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const NotificationPage()),
//     );
//   }

//   // Function to handle category selection
//   void _onRectangleTapped(int index) {
//     setState(() {
//       _selectedRectangle = index;
//     });
//   }

//   // Function to toggle like state for a model using its modelId
//   void _toggleLike(String modelId) {
//     setState(() {
//       if (_likedModelIds.contains(modelId)) {
//         _likedModelIds.remove(modelId);
//       } else {
//         _likedModelIds.add(modelId);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],

//       // App bar with search and notification icon
//       appBar: AppBar(
//         backgroundColor: Colors.grey[200],
//         elevation: 0,
//         title: Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   hintText: "Search",
//                   prefixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide.none,
//                   ),
//                   fillColor: const Color.fromARGB(255, 221, 211, 223),
//                   filled: true,
//                   contentPadding: const EdgeInsets.symmetric(vertical: 0),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             IconButton(
//               icon: const Icon(Icons.notifications,
//                   color: Color.fromARGB(255, 78, 64, 57)),
//               onPressed: () => openNotificationScreen(context),
//             ),
//           ],
//         ),
//       ),

//       body: Column(
//         children: [
//           const SizedBox(height: 10),

//           // Horizontal category list
//           SizedBox(
//             height: 40,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: categories.length,
//               itemBuilder: (context, index) => GestureDetector(
//                 onTap: () => _onRectangleTapped(index),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   margin: const EdgeInsets.symmetric(horizontal: 5),
//                   width: 120,
//                   decoration: BoxDecoration(
//                     color: _selectedRectangle == index
//                         ? Color.fromARGB(255, 163, 119, 178)
//                         : Color.fromARGB(255, 207, 186, 221),
//                     borderRadius: BorderRadius.circular(50),
//                     boxShadow: _selectedRectangle == index
//                         ? [
//                             BoxShadow(
//                               color: Color.fromARGB(
//                                   (255 * 0.4).toInt(), 224, 99, 247),
//                               blurRadius: 6,
//                               offset: const Offset(0, 2),
//                             )
//                           ]
//                         : [],
//                   ),
//                   alignment: Alignment.center,
//                   child: Text(
//                     categories[index],
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: _selectedRectangle == index
//                           ? Colors.white
//                           : Color.fromARGB(255, 0, 0, 0),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 10),

//           // Grid of models (from Firestore)
//           Expanded(
//             child: GridView.builder(
//               shrinkWrap: true,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 0.8, // Adjust this for image proportions
//               ),
//               itemCount: _models.length,
//               padding: const EdgeInsets.all(10),
//               itemBuilder: (context, index) {
//                 final model = _models[index];
//                 final String modelId = model['id'] ?? 'unknown'; // Fetch model ID
//                 final String name = model['name'] ?? 'Unknown';
//                 final String price = model['price'] ?? 'N/A';
//                 final String description = model['description'] ?? 'No description available';
//                 final String tailorId = model['idTailor'] ?? '';

//                 return GestureDetector(
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DetailPage(
//                         tailorId: tailorId,
//                         modelId: modelId,  
//                         title: name,
//                         price: price,
//                         description: description,
//                         fabricType: model['fabrics'] ?? 'Unknown',
//                         availableColors: (model['colors'] as List<dynamic>).map((e) => e.toString()).toList(),
//                         availableSizes: (model['sizes'] as List<dynamic>).map((e) => e.toString()).toList(),
//                       ),
//                     ),
//                   ),
//                   onDoubleTap: () => _toggleLike(modelId), // Now passing the modelId
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(20),
//                         child: Container(
//                           color: Colors.grey[300],
//                           alignment: Alignment.center,
//                           child: const Text(
//                             'No image available for now',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: 8,
//                         right: 8,
//                         child: IconButton(
//                           icon: Icon(
//                             _likedModelIds.contains(modelId)
//                                 ? Icons.favorite
//                                 : Icons.favorite_border,
//                             color: _likedModelIds.contains(modelId)
//                                 ? Colors.red
//                                 : Colors.white,
//                           ),
//                           onPressed: () {
//                             _toggleLike(modelId); // Using modelId to track likes
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




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
  int _selectedRectangle = 0; // Stores the index of the selected category
  final Set<String> _likedModelIds = {}; // Set to track liked model IDs

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Model> _models = [];

  @override
  void initState() {
    super.initState();
    _fetchModels();
  }

  // Future<void> _fetchModels() async {
  //   try {
  //     final snapshot = await _firestore.collection('models').get();
  //     setState(() {
  //       _models = snapshot.docs.map((doc) {
  //         var modelData = doc.data() as Map<String, dynamic>;

  //         modelData['colors'] = modelData['colors'] != null
  //             ? List<String>.from(modelData['colors'].map((e) => e.toString()))
  //             : [];

  //         modelData['sizes'] = modelData['sizes'] != null
  //             ? List<String>.from(modelData['sizes'].map((e) => e.toString()))
  //             : [];

  //         return Model.fromMap(modelData); 
  //       }).toList();
  //     });
  //   } catch (e) {
  //     print('Error fetching models: $e');
  //   }
  // }


  Future<void> _fetchModels() async {
  try {
    final snapshot = await _firestore.collection('models').get();
    setState(() {
      _models = snapshot.docs.map((doc) {
        var modelData = doc.data() as Map<String, dynamic>;

        // Debug the data here
        print(modelData); 

        modelData['colors'] = modelData['colors'] != null
            ? List<String>.from(modelData['colors'].map((e) => e.toString()))
            : [];
        modelData['sizes'] = modelData['sizes'] != null
            ? List<String>.from(modelData['sizes'].map((e) => e.toString()))
            : [];

        return Model.fromMap(modelData); 
      }).toList();
    });
  } catch (e) {
    print('Error fetching models: $e');
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
                final String modelId = model.modelId ?? 'unknown'; // Fetch model ID
                final String name = model.name ?? 'Unknown';
                final String price = model.price ?? 'N/A';
                final String description = model.description ?? 'No description available';
                final String tailorId = model.idTailor ?? '';

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
                        fabricType: "kadifa" ,
                        availableColors: model.colors ?? [],
                        availableSizes: model.sizes ?? [],
                      ),
                    ),
                  ),
                  onDoubleTap: () => _toggleLike(modelId),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.grey[300],
                          alignment: Alignment.center,
                          child: const Text(
                            'No image available for now',
                            textAlign: TextAlign.center,
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
