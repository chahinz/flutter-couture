// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'screens/customer_list.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';



// class TailorProfilePage extends StatefulWidget {
//   const TailorProfilePage({super.key});

//   @override
//   TailorProfilePageState createState() => TailorProfilePageState();
// }

// class TailorProfilePageState extends State<TailorProfilePage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final List<String> portfolioImages = [
//     'images/1.jpg',
//     'images/2.jpg',
//     'images/3.jpg',
//     'images/4.jpg',
//     'images/5.jpg',
//     'images/6.jpg',
//     'images/8.jpg',
//   ];

//   String username = '';
//   String bio = '';
//   String phone = '';

//   @override
// void initState() {
//   super.initState();
//   fetchUserData();
// }



// Future<void> fetchUserData() async {
//   final uid = FirebaseAuth.instance.currentUser?.uid;
//   if (uid != null) {
//     final doc = await FirebaseFirestore.instance.collection('tailors').doc(uid).get();
//     if (doc.exists) {
//       final data = doc.data();
//       setState(() {
//         username = data?['username'] ?? '';
//         bio = data?['bio'] ?? '';
//         phone = data?['phoneNumber'] ?? '';
//       });
//     }
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.grey[200],
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               clipBehavior: Clip.none,
//               alignment: Alignment.topCenter,
//               children: [
//                 Container(
//                   height: 180,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('images/6.jpg'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: -40,
//                   child: Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                       border: Border.all(color: Colors.white, width: 3),
//                     ),
//                     child: ClipOval(
//                       child: Image.asset(
//                         'images/2.jpg',
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 50),
//             Text(
//               username,
//               style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               bio  ,  
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
//             ),
//             const SizedBox(height: 3),
//             Text(
//               phone,  
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
//             ),
//             const SizedBox(height: 5),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(width: 10),
//                 _buildTextButton(context, const CustomerList()),
//                 const SizedBox(width: 10),
//               ],
//             ),
//             const Divider(),
//             _buildPortfolioGrid(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPortfolioGrid() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: MasonryGridView.count(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         crossAxisCount: 2,
//         mainAxisSpacing: 8,
//         crossAxisSpacing: 8,
//         itemCount: portfolioImages.length,
//         itemBuilder: (context, index) {
//           return ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.asset(
//               portfolioImages[index],
//               fit: BoxFit.cover,
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTextButton(BuildContext context, Widget page) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => page));
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25),
//           color: const Color.fromARGB(255, 163, 119, 178),
//         ),
//         child: Text(
//           "Customer",
//           style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_couture/following_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'screens/customer_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'models/model.dart';

String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;

class TailorProfilePage extends StatefulWidget {
  const TailorProfilePage({super.key});

  @override
  TailorProfilePageState createState() => TailorProfilePageState();
}

class TailorProfilePageState extends State<TailorProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Model> userModels = [];
  late String tailorId;
  


  @override
  void initState() {
    super.initState();
    tailorId = FirebaseAuth.instance.currentUser!.uid;
    _fetchUserModels(); 
    setState(() {});
     
  }

  void _fetchUserModels() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final snapshot = await FirebaseFirestore.instance
        .collection('models') 
        .where('idTailor', isEqualTo: uid)  
        .get();

    setState(() {
      userModels = snapshot.docs
          .map((doc) => Model.fromJson(doc.data()))
          .toList();
    });
  }

  



  @override
  Widget build(BuildContext context) {
    
    final uid = FirebaseAuth.instance.currentUser?.uid;
    

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('tailors').doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final data = snapshot.data!.data() as Map<String, dynamic>?;

          final username = data?['username'] ?? '';
          final bio = data?['bio'] ?? '';
          final phone = data?['phoneNumber'] ?? '';

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                    height: 210,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(data?['bannerImage'] ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                    Positioned(
                      bottom: -40,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child:ClipOval(
              child: data?['profileImage'] != null && data!['profileImage'].isNotEmpty
                  ? Image.network(
                      data['profileImage'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.person, size: 50, color: Colors.grey),
                      ),
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.person, size: 50, color: Colors.grey),
                    ),
),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Text(
                  username,
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  bio,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 3),
                Text(
                  phone,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    const SizedBox(width: 10),
                    _buildTextButton(context, CustomerList(tailorId : tailorId)),
                    const SizedBox(width: 10),
                  ],
                ),
                const Divider(),

                  StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('models') 
                      .where('idTailor', isEqualTo: uid)
                      .snapshots(),
                  builder: (context, modelSnapshot) {
                    if (!modelSnapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final models = modelSnapshot.data!.docs.map((doc) {
                      return Model.fromJson(doc.data() as Map<String, dynamic>);
                    }).toList();

                    return _buildPortfolioGrid(models);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget _buildPortfolioGrid(List<Model> models) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: MasonryGridView.count(
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       crossAxisCount: 2,
  //       mainAxisSpacing: 8,
  //       crossAxisSpacing: 8,
  //       itemCount: models.length,  
  //       itemBuilder: (context, index) {
  //         final model = models[index];
  //         return ClipRRect(
  //           borderRadius: BorderRadius.circular(10),
  //           child: _buildPlaceholderImage(),
  //         );
  //       },
  //     ),
  //   );
  // }

  // Widget _buildPlaceholderImage() {
  //   return Container(
  //     width: double.infinity,
  //     height: 200, 
  //     color: Colors.grey[300], 
  //     child: Center(
  //       child: Text(
  //         'Image Unavailable', 
  //         style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildPortfolioGrid(List<Model> models) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: MasonryGridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: models.length,
      itemBuilder: (context, index) {
        final model = models[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: model.imageUrl != null && model.imageUrl!.isNotEmpty
              ? Image.network(
                  model.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildErrorImage(); // fallback if image fails to load
                  },
                )
              : _buildErrorImage(),
        );
      },
    ),
  );
}

Widget _buildErrorImage() {
  return Container(
    width: double.infinity,
    height: 200,
    color: Colors.grey[300],
    child: Center(
      child: Text(
        'Image Unavailable',
        style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
        textAlign: TextAlign.center,
      ),
    ),
  );
}


  Widget _buildTextButton(BuildContext context, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromARGB(255, 163, 119, 178),
        ),
        child: Text(
          "Customer",
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
