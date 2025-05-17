import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';


class TailorProfilePage extends StatefulWidget {
  final String name;
  final String image;
  final String tailorId;

  const TailorProfilePage({super.key, required this.name, required this.image , required this.tailorId});

  @override
  State<TailorProfilePage> createState() => _TailorProfilePageState();
}


class _TailorProfilePageState extends State<TailorProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFollowing = false; 
  final Set<String> _likedImages = {}; 


String tailorName = "";
String profileImage = "";
String bio = "";
String phone = "";
String bannerImage = "";
String wilaya = "";
String type = "";
List<String> categories = [];
List<String> portfolioImages = [];
List<String> followers = [];

  bool _isLoading = true;


final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
List<Map<String, dynamic>> reviews = [];


@override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    fetchTailorData();

     fetchReviews(widget.tailorId).then((fetchedReviews) {
    setState(() {
      reviews = fetchedReviews;
    });
  });
  }



// Future<void> fetchTailorData() async {
//   final doc = await FirebaseFirestore.instance.collection('tailors').doc(widget.tailorId).get();

//   final postsSnapshot = await FirebaseFirestore.instance
//       .collection('tailors')
//       .doc(widget.tailorId)
//       .collection('models')
//       .get();

//       final currentUserId = FirebaseAuth.instance.currentUser?.uid;

//   setState(() {
//     tailorName = doc['username'];
//     profileImage = doc['profileImage'] ?? ''; 
//     bio = doc['bio'];
//     bannerImage = doc['bannerImage'] ?? ''; 
//     phone = doc['phoneNumber'];
//     wilaya = doc['wilaya'];
//     type = doc['businessType'];
//     categories = List<String>.from(doc['categories']);
//     followers = doc.data() != null && doc.data()!.containsKey('followers')
//     ? List<String>.from(doc['followers'])
//     : [];
//     isFollowing = currentUserId != null && followers.contains(currentUserId);
//     portfolioImages = postsSnapshot.docs.map((d) => d['imageUrl'] as String).toList();

//   });
// }


Future<void> fetchTailorData() async {
  final doc = await FirebaseFirestore.instance.collection('tailors').doc(widget.tailorId).get();

  final postsSnapshot = await FirebaseFirestore.instance
      .collection('tailors')
      .doc(widget.tailorId)
      .collection('models')
      .get();

  print("Tailor doc data: ${doc.data()}");
  print("Models count: ${postsSnapshot.docs.length}");
  for (var d in postsSnapshot.docs) {
    print("Model imageUrl: ${d['imageUrl']}");
  }

  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  setState(() {
    tailorName = doc['username'];
    profileImage = doc['profileImage'] ?? '';
    bio = doc['bio'];
    bannerImage = doc['bannerImage'] ?? '';
    phone = doc['phoneNumber'];
    wilaya = doc['wilaya'];
    type = doc['businessType'];
    categories = List<String>.from(doc['categories']);
    followers = doc.data() != null && doc.data()!.containsKey('followers')
      ? List<String>.from(doc['followers'])
      : [];
    isFollowing = currentUserId != null && followers.contains(currentUserId);
    portfolioImages = postsSnapshot.docs.map((d) => d['imageUrl'] as String).toList();
  });
}


Future<List<Map<String, dynamic>>> fetchReviews(String tailorId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('tailors')
      .doc(tailorId)
      .collection('reviews')
      .orderBy('timestamp', descending: true)
      .get();

  List<Map<String, dynamic>> reviewsWithNames = [];

  for (var doc in snapshot.docs) {
    final data = doc.data();
    final customerId = data['userId'] as String?; 

    String customerName = "Customer";

    if (customerId != null && customerId.isNotEmpty) {

      final customerDoc = await FirebaseFirestore.instance
          .collection('customer')
          .doc(customerId)
          .get();

      if (customerDoc.exists) {
        final customerData = customerDoc.data();
        if (customerData != null && customerData.containsKey('username')) {
          customerName = customerData['username'];
        }
      }
    }

    // Print customer name
    print("Customer name: $customerName");

    reviewsWithNames.add({
      "comment": data['comment'] ?? "",
      "orderImage": data['orderImage'] ?? "",
      "orderTitle": data['orderTitle'] ?? "",
      "rating": data['rating'] ?? 0,
      "timestamp": data['timestamp'] ?? null,
      "name": customerName,
    });
  }

  return reviewsWithNames;
}

  // final List<Map<String, dynamic>> reviewss = [
  //   {"name": "Sarah M.", "rating": 5, "comment": "Amazing work! Loved it."},
  //   {"name": "John D.", "rating": 4, "comment": "Great quality, just a bit late."},
  //   {"name": "Emma R.", "rating": 5, "comment": ""},
  //   {"name": "Ahmed K.", "rating": 3, "comment": "Good, but could be better."},
  // ];


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
  clipBehavior: Clip.none,
  alignment: Alignment.topCenter,
  children: [
    Container(
      height: 180,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: bannerImage.isNotEmpty
              ? NetworkImage(bannerImage) 
              : AssetImage('images/6.jpg') as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    ),
    Positioned(
      top: 40,
      left: 10,
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
        onPressed: () => Navigator.pop(context),
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
        child: ClipOval(
          child: profileImage.isNotEmpty
              ? Image.network(profileImage, fit: BoxFit.cover)
              : Image.asset(widget.image, fit: BoxFit.cover),
        ),
      ),
    ),
  ],
),
          const SizedBox(height: 50),
          Text(widget.name,
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(
            bio,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          _buildFollowButton(),
          const SizedBox(height: 20),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Color.fromARGB(255, 163, 119, 178),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color.fromARGB(255, 163, 119, 178),
              tabs: const [
                Tab(text: "Portfolio"),
                Tab(text: "Reviews"),
                Tab(text: "About"),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPortfolioTab(),
                  _buildReviewsTab(),
                  _buildAboutTab(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowButton() {
    return GestureDetector(
      
      onTap: () async {
        final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
        final customerRef = FirebaseFirestore.instance.collection('customer').doc(currentUserId);
        if (!isFollowing) {
          await FirebaseFirestore.instance.collection('tailors').doc(widget.tailorId).update({
            'followers': FieldValue.arrayUnion([currentUserId]),
          });
          await customerRef.update({
            'following': FieldValue.arrayUnion([widget.tailorId]),
          });
        } else {
          await FirebaseFirestore.instance.collection('tailors').doc(widget.tailorId).update({
            'followers': FieldValue.arrayRemove([currentUserId]),
          });
           await customerRef.update({
            'following': FieldValue.arrayRemove([widget.tailorId]),
          });
        }
        setState(() {
          isFollowing = !isFollowing;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: isFollowing ? Colors.grey : const Color.fromARGB(255, 163, 119, 178),
        ),
        child: Text(
          isFollowing ? "Unfollow" : "Follow",
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  // Widget _buildPortfolioTab() {
  //   return Padding(
  //     padding: const EdgeInsets.all(10),
  //     child: GridView.builder(
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         crossAxisSpacing: 10,
  //         mainAxisSpacing: 10,
  //         childAspectRatio: 0.8,
  //       ),
  //       itemCount: allImages.length,
  //       itemBuilder: (context, index) {
  //         final imagePath = allImages[index];
  //         return GestureDetector(
  //           onDoubleTap: () => setState(() => _likedImages.contains(imagePath)
  //               ? _likedImages.remove(imagePath)
  //               : _likedImages.add(imagePath)),
  //           child: Stack(
  //             alignment: Alignment.center,
  //             children: [
  //               ClipRRect(
  //                 borderRadius: BorderRadius.circular(20),
  //                 child: Image.asset(imagePath, fit: BoxFit.cover),
  //               ),
  //               Positioned(
  //                 top: 10,
  //                 right: 10,
  //                 child: Icon(
  //                   _likedImages.contains(imagePath) ? Icons.favorite : Icons.favorite_border,
  //                   color: _likedImages.contains(imagePath) ? Colors.red : Colors.white,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _buildPortfolioTab() {
  if (portfolioImages.isEmpty) {
    return Center(
      child: Text(
        "Aucun modèle pour le moment.",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  return GridView.builder(
    padding: const EdgeInsets.all(10),
    itemCount: portfolioImages.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemBuilder: (context, index) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          portfolioImages[index],
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[300],
            child: Icon(Icons.error, color: Colors.red),
          ),
        ),
      );
    },
  );
}

  // Widget _buildReviewsTab() {
  //   return ListView.builder(
  //     padding: const EdgeInsets.all(16),
  //     itemCount: reviews.length,
  //     itemBuilder: (context, index) {
  //       final review = reviews[index];
  //       return Column(
  //         children: [
  //           Row(
  //             children: [
  //               const Icon(Icons.account_circle, size: 40, color: Colors.grey),
  //               const SizedBox(width: 10),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(review["name"], style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
  //                   Row(
  //                     children: List.generate(5, (i) => Icon(
  //                       i < review["rating"] ? Icons.star : Icons.star_border,
  //                       color: Colors.amber,
  //                     )),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //           if (review["comment"].isNotEmpty)
  //             Padding(
  //               padding: const EdgeInsets.only(left: 50, top: 5),
  //               child: Text(review["comment"], style: GoogleFonts.poppins(fontSize: 14)),
  //             ),
  //           const Divider(),
  //         ],
  //       );
  //     },
  //   );
  // }


  Widget _buildReviewsTab() {
  if (reviews.isEmpty) {
    return Center(child: Text("No reviews yet."));
  }

  return ListView.builder(
    itemCount: reviews.length,
    itemBuilder: (context, index) {
      final review = reviews[index];

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review['name'] ?? "Customer",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                    SizedBox(width: 4),
                    Text(
                      review['rating'].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  review['comment'] ?? "",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 5),

                Text(
                  review['orderTitle'] ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                review['timestamp'] != null
                    ? Text(
                        DateFormat.yMMMMd().add_jm().format(
                              (review['timestamp'] as Timestamp).toDate(),
                            ),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      );
    },
  );
}


Widget _buildAboutTab() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        _buildInfoRow(Icons.phone, phone),
        const SizedBox(height: 20),
        _buildInfoRow(Icons.location_on, wilaya),
        const SizedBox(height: 20),
        _buildInfoRow(Icons.work, type),
        const SizedBox(height: 20),
        
        
        Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Icon(Icons.grid_view, color: Color.fromARGB(255, 163, 119, 178)),
    const SizedBox(width: 10),
    Expanded(
      child: Text(
        categories.isNotEmpty ? categories.join(", ") : "No categories",
        style: GoogleFonts.poppins(fontSize: 14),
        softWrap: true,
      ),
    ),
  ],
),

      ],
    ),
  );
}

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Color.fromARGB(255, 163, 119, 178)),
        const SizedBox(width: 10),
        Text(text, style: GoogleFonts.poppins(fontSize: 14)),
      ],
    );
  }
}

