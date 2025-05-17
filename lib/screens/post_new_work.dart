import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_couture/models/model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';



class NewPostScreen extends StatefulWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _imageBytes;

  List<String> sizes = ['XXS', 'XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL'];
  List<String> selectedSizes = [];

  List<Color> colors = Colors.primaries;
  List<Color> selectedColors = [];

  List<String> selectedFabrics = [];
  TextEditingController fabricController = TextEditingController();

  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  



List<Map<String, dynamic>> categories = [
  {'idcategory': '1', 'name': 'Kids'},
  {'idcategory': '2', 'name': 'Graduation'},
  {'idcategory': '3', 'name': 'Men'},
  {'idcategory': '4', 'name': 'Babies'},
  {'idcategory': '5', 'name': 'Accessories'},
  {'idcategory': '6', 'name': 'Women'},
  {'idcategory': '7', 'name': 'Home textile'},
  {'idcategory': '8', 'name': 'Knitting'},
];


final Map<String, List<Map<String, dynamic>>> subcategoriesMap = {
    "Men": [
      {"subcategoryid": "1", "name": "Suits" },
      {"subcategoryid": "2", "name": "Jackets"},
      {"subcategoryid": "3", "name": "Trousers" },
      {"subcategoryid": "4", "name": "Shirts" },
      {"subcategoryid": "5", "name": "Traditional Wear" }
    ],
    "Women": [
      {"subcategoryid": "6", "name": "Special Occasions (Traditional)" },
      {"subcategoryid": "7", "name": "Modern Dresses" },
      {"subcategoryid": "8", "name": "Jackets" },
      {"subcategoryid": "9", "name": "Skirts" },
      {"subcategoryid": "10", "name": "Tops"}
    ],
    "Kids": [
      {"subcategoryid": "11", "name": "Girls" },
      {"subcategoryid": "12", "name": "Boys" },
      {"subcategoryid": "13", "name": "Traditional" },
      {"subcategoryid": "14", "name": "Uniforms"  }
    ],
    "Babies": [
      {"subcategoryid": "15", "name": "Newborn Sets" },
      {"subcategoryid": "16", "name": "Onesies" },
      {"subcategoryid": "17", "name": "Baby Dresses"}
    ],
    "Knitting": [
      {"subcategoryid": "18", "name": "Wool"  },
      {"subcategoryid": "19", "name": "Cotton"  },
      {"subcategoryid": "20", "name": "Crochet Pieces" }
    ],
    "Accessories": [
      {"subcategoryid": "21", "name": "Scarves"},
      {"subcategoryid": "22", "name": "Bags" },
      {"subcategoryid": "23", "name": "Belts" },
      {"subcategoryid": "24", "name": "Hijabs" }
    ],
    "Graduation": [
      {"subcategoryid": "25", "name": "Gowns" },
      {"subcategoryid": "26", "name": "Caps" },
      {"subcategoryid": "27", "name": "Custom Pieces" }
    ],
    "Home textile": [
      {"subcategoryid": "28", "name": "Cushion Covers" },
      {"subcategoryid": "29", "name": "Curtains" },
      {"subcategoryid": "30", "name": "Beddings" },
      {"subcategoryid": "31", "name": "Table Runners" }
    ]
  };

String? selectedCategory;
String? selectedSubcategory;
List<Map<String, dynamic>> subcategories = []; 



  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final Uint8List bytes = await image.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  Future<File> uint8ListToFile(Uint8List bytes) async {
  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
  await file.writeAsBytes(bytes);
  return file;
}

Future<String?> uploadImageToCloudinary(File file) async {
  
  final cloudinaryUrl = 'https://api.cloudinary.com/v1_1/dyxrwqehs/image/upload';
  var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl));
  request.fields['upload_preset'] = 'flutter_unsigned';

  request.files.add(await http.MultipartFile.fromPath('file', file.path));
  var response = await request.send();
  if (response.statusCode == 200) {
    var respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    return jsonResponse['secure_url'];
  } else {
    print('Upload failed: ${response.statusCode}');
    return null;
  }
}


//   Future<void> savePost(Post post) async {
//   final postJson = post.toJson();
//   await FirebaseFirestore.instance.collection('posts').add(postJson);
// }



// Future<void> saveModel(Model model) async {
//   try {
//     final modelJson = model.toMap(); 
//     await FirebaseFirestore.instance.collection('models').add(modelJson);
//   } catch (e) {
//     print("🔥 Error saving model: $e");
//     throw Exception("Error saving model: $e");
//   }
// }

Future<void> saveModel(Model model) async {
  try {
    final docRef = FirebaseFirestore.instance.collection('models').doc(); 
    model.modelId = docRef.id; 
    final modelJson = model.toMap();
    await docRef.set(modelJson); // Save using the custom ID
  } catch (e) {
    print("🔥 Error saving model: $e");
    throw Exception("Error saving model: $e");
  }
}

Future<String> uploadImage(Uint8List imageBytes) async {
  final storageRef = FirebaseStorage.instance.ref().child('posts/${DateTime.now().millisecondsSinceEpoch}.jpg');
  await storageRef.putData(imageBytes);
  return await storageRef.getDownloadURL();
}


  void showColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Colors", style: GoogleFonts.poppins()),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 8.0,
              children: colors.map((color) {
                bool isSelected = selectedColors.contains(color);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected ? selectedColors.remove(color) : selectedColors.add(color);
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: isSelected ? Colors.black : Colors.transparent, width: 2),
                    ),
                    child: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Done", style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Post", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Title",
                  hintStyle: GoogleFonts.poppins(),
                ),
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: _imageBytes == null
                        ? Center(child: Text("There is no image", style: GoogleFonts.poppins()))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(
                              _imageBytes!,
                              fit: BoxFit.contain,
                            ),
                          ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.photo_library, size: 30, color: Colors.purpleAccent),
                    onPressed: pickImage,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Text("Select Sizes:", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              Wrap(
                spacing: 8.0,
                children: sizes.map((size) {
                  return ChoiceChip(
                    label: Text(size, style: GoogleFonts.poppins()),
                    selected: selectedSizes.contains(size),
                    onSelected: (selected) {
                      setState(() {
                        selected ? selectedSizes.add(size) : selectedSizes.remove(size);
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              Text("Select Colors:", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              Wrap(
                spacing: 8.0,
                children: selectedColors.map((color) {
                  return Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  );
                }).toList(),
              ),
              IconButton(
                icon: const Icon(Icons.color_lens),
                onPressed: showColorPicker,
              ),
              const SizedBox(height: 20),

              Text("Enter Fabric Type:", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: fabricController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Type fabric name...",
                        hintStyle: GoogleFonts.poppins(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      String newFabric = fabricController.text.trim();
                      if (newFabric.isNotEmpty && !selectedFabrics.contains(newFabric)) {
                        setState(() {
                          selectedFabrics.add(newFabric);
                          fabricController.clear();
                        });
                      }
                    },
                  ),
                ],
              ),
              Wrap(
                children: selectedFabrics.map((fabric) {
                  return Chip(
                    label: Text(fabric, style: GoogleFonts.poppins()),
                    onDeleted: () {
                      setState(() {
                        selectedFabrics.remove(fabric);
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

            DropdownButtonFormField<String>(
  value: selectedCategory,
  hint: Text("Select Category", style: GoogleFonts.poppins()),
  items: categories.map((category) {
    return DropdownMenuItem<String>(
      value: category['name'],  
      child: Text(category['name'], style: GoogleFonts.poppins()),
    );
  }).toList(),
  onChanged: (value) {
    setState(() {
      selectedCategory = value;  
      selectedSubcategory = null; 
      subcategories = subcategoriesMap[value] ?? [];  
    });
  },
),


DropdownButtonFormField<String>(
  value: selectedSubcategory,
  hint: Text("Select Subcategory", style: GoogleFonts.poppins()),
  items: subcategories.isEmpty
      ? [DropdownMenuItem<String>(value: '', child: Text("No subcategories available", style: GoogleFonts.poppins()))]
      : subcategories.map((subcategory) {
          return DropdownMenuItem<String>(
            value: subcategory['subcategoryid'],
            child: Text(subcategory['name'], style: GoogleFonts.poppins()),
          );
        }).toList(),
  onChanged: (value) {
    setState(() {
      selectedSubcategory = value;  
    });
  },
),




const SizedBox(height: 20),
Text("Enter Price:", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
TextField(
  controller: priceController,
  keyboardType: TextInputType.number,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    hintText: "Enter price",
    hintStyle: GoogleFonts.poppins(),
  ),
),

const SizedBox(height: 20),

              Text("Description:", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              TextField(
                controller: detailsController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Write more details...",
                  hintStyle: GoogleFonts.poppins(),
                ),
              ),
              const SizedBox(height: 20),


///// 
///
const SizedBox(height: 20),


              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  ///////
                  ///
//                   onPressed: () async {

//   try {
//     // if (_imageBytes != null) {
//     //   String imageUrl = await uploadImage(_imageBytes!);
//       final user = FirebaseAuth.instance.currentUser;

//        if (user == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("User not logged in!", style: GoogleFonts.poppins())),
//       );
//       return;
//     }
    
//       Post newPost = Post(
        
//         title: titleController.text.trim(),
//         description: detailsController.text.trim(),
//         sizes: selectedSizes,
//         fabrics: selectedFabrics,
//         colors: selectedColors.map((c) => '#${c.value.toRadixString(16).padLeft(8, '0')}').toList(),
//         // imageUrl: imageUrl,
//         createdAt: DateTime.now(),
//         authorId: user.uid,
//       );

//       await savePost(newPost);

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Post uploaded!", style: GoogleFonts.poppins())),
//       );
//     // } 
//     // else {
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     SnackBar(content: Text("Please select an image.", style: GoogleFonts.poppins())),
//     //   );
//     // }
//   } catch (e) {
//     print("🔥 Error saving post: $e");
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Error: $e", style: GoogleFonts.poppins())),
//     );
//   }
// },








// onPressed: () async {
//   try {

//     if (_imageBytes != null) {
//   File imageFile = await uint8ListToFile(_imageBytes!); 
//   String? imageUrl = await uploadImageToCloudinary(imageFile);

//   if (imageUrl != null) {
//     print('Image uploaded: $imageUrl');
//   } else {
//     print('Upload failed');
//   }
// } 

//     final user = FirebaseAuth.instance.currentUser;

//     if (user == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("User not logged in!", style: GoogleFonts.poppins())),
//       );
//       return;
//     }

//     if (selectedCategory == null || selectedSubcategory == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please select a category and subcategory.", style: GoogleFonts.poppins())),
//       );
//       return;
//     }

//     // String imageUrl = await uploadImage(_imageBytes!);

//      final modelDoc = FirebaseFirestore.instance.collection('models').doc();
//     String generatedId = modelDoc.id;

    
//     Model newModel = Model(

//       colors: selectedColors
//           .map((c) => '#${c.value.toRadixString(16).padLeft(8, '0')}')
//           .toList(),

//       description: detailsController.text.trim(),
//       fabrics: selectedFabrics,
//       modelId: generatedId,  
//       idTailor: user.uid,  
//       name: titleController.text.trim(),
//       notes: detailsController.text.trim(),  
//       price:  priceController.text,
//       sizes: selectedSizes,
//       subcategoryId: selectedSubcategory ?? '',
//       idcategory: selectedCategory ?? '', 
//       imageUrl: imageUrl,
    
      
//     );

//     print('Model Data: ${newModel.toMap()}');
//      print("Post saved with image URL: $imageUrl");

//     await modelDoc.set(newModel.toMap());

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Model uploaded!", style: GoogleFonts.poppins())),
//     );

//     setState(() {
//       _imageBytes = null;
//       titleController.clear();
//       detailsController.clear();
//       fabricController.clear();
//       selectedSizes.clear();
//       priceController.clear();
//       selectedColors.clear();
//       selectedFabrics.clear();
//     });
//   } catch (e) {
//     print("🔥 Error saving model: $e");
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Error: $e", style: GoogleFonts.poppins())),
//     );
//   }
// },

onPressed: () async {
  try {
    String? imageUrl; 

    if (_imageBytes != null) {
      File imageFile = await uint8ListToFile(_imageBytes!);
      imageUrl = await uploadImageToCloudinary(imageFile); 

      if (imageUrl != null) {
        print('Image uploaded: $imageUrl');
      } else {
        print('Upload failed');
      }
    }

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User not logged in!", style: GoogleFonts.poppins())),
      );
      return;
    }

    if (selectedCategory == null || selectedSubcategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a category and subcategory.", style: GoogleFonts.poppins())),
      );
      return;
    }

    final modelDoc = FirebaseFirestore.instance.collection('models').doc();
    String generatedId = modelDoc.id;

    Model newModel = Model(
      colors: selectedColors
          .map((c) => '#${c.value.toRadixString(16).padLeft(8, '0')}')
          .toList(),
      description: detailsController.text.trim(),
      fabrics: selectedFabrics,
      modelId: generatedId,
      idTailor: user.uid,
      name: titleController.text.trim(),
      notes: detailsController.text.trim(),
      price: priceController.text,
      sizes: selectedSizes,
      subcategoryId: selectedSubcategory ?? '',
      idcategory: selectedCategory ?? '',
      imageUrl: imageUrl,  
    );

    print('Model Data: ${newModel.toMap()}');

    await modelDoc.set(newModel.toMap());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Model uploaded!", style: GoogleFonts.poppins())),
    );

    setState(() {
      _imageBytes = null;
      titleController.clear();
      detailsController.clear();
      fabricController.clear();
      selectedSizes.clear();
      priceController.clear();
      selectedColors.clear();
      selectedFabrics.clear();
    });
  } catch (e) {
    print("🔥 Error saving model: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e", style: GoogleFonts.poppins())),
    );
  }
},

                  child: Text("Post", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
