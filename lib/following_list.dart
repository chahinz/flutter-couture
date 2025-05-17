// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'tailor_profile_page.dart'; 

// class FollowingList extends StatefulWidget {
//   const FollowingList({super.key});

//   @override
//   State<FollowingList> createState() => _FollowingListState();
// }

// class _FollowingListState extends State<FollowingList> {
//   List<Map<String, String>> followers = [
//     {"name": "Ismail", "image": "images/1.jpg"},
//     {"name": "Amira", "image": "images/2.jpg"},
//     {"name": "Khaled", "image": "images/3.jpg"},
//     {"name": "Sarah", "image": "images/4.jpg"},
//     {"name": "Omar", "image": "images/5.jpg"},
//   ];

//   void confirmRemoveFollower(int index) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Remove Follower"),
//         content: Text("Are you sure you want to remove ${followers[index]["name"]}?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 followers.removeAt(index);
//               });
//               Navigator.pop(context);
//             },
//             child: const Text("Remove", style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Customers",
//           style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0.5,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: followers.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//                   leading: CircleAvatar(
//                     radius: 25,
//                     backgroundImage: AssetImage(followers[index]["image"]!),
//                   ),
//                   title: Text(
//                     followers[index]["name"]!,
//                     style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.remove_circle, color: Colors.red),
//                     onPressed: () => confirmRemoveFollower(index),
//                   ),
//                   onTap: () {
//                    // Navigate to the profile page with data passing


//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //     builder: (context) => TailorProfilePage(
//                     //       name: followers[index]["name"]!,
//                     //       image: followers[index]["image"]!,
//                     //       tailorId: widget.tailorId,
//                     //     ),
//                     //   ),
//                     // );

//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'tailor_profile_page.dart';

class FollowingList extends StatefulWidget {
  const FollowingList({super.key});

  @override
  State<FollowingList> createState() => _FollowingListState();
}

class _FollowingListState extends State<FollowingList> {
  List<Map<String, dynamic>> followingTailors = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFollowingTailors();
  }

  Future<void> fetchFollowingTailors() async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    final customerDoc = await FirebaseFirestore.instance
        .collection('customer')
        .doc(currentUserId)
        .get();

    final followingIds = List<String>.from(customerDoc.data()?['following'] ?? []);

    List<Map<String, dynamic>> fetchedTailors = [];

    for (String tailorId in followingIds) {
      final tailorDoc = await FirebaseFirestore.instance
          .collection('tailors')
          .doc(tailorId)
          .get();

      if (tailorDoc.exists) {
        final data = tailorDoc.data()!;
        fetchedTailors.add({
          "tailorId": tailorId,
          "name": data["username"] ?? "Unknown",
          "image": data["profileImage"] ?? "images/default.jpg",
        });
      }
    }

    setState(() {
      followingTailors = fetchedTailors;
      isLoading = false;
    });
  }

  void confirmUnfollow(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Unfollow Tailor"),
        content: Text("Are you sure you want to unfollow ${followingTailors[index]["name"]}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              final currentUserId = FirebaseAuth.instance.currentUser!.uid;
              final tailorId = followingTailors[index]['tailorId'];

              await FirebaseFirestore.instance.collection('customer').doc(currentUserId).update({
                'following': FieldValue.arrayRemove([tailorId])
              });

              await FirebaseFirestore.instance.collection('tailors').doc(tailorId).update({
                'followers': FieldValue.arrayRemove([currentUserId])
              });

              setState(() {
                followingTailors.removeAt(index);
              });

              Navigator.pop(context);
            },
            child: const Text("Unfollow", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Following",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : followingTailors.isEmpty
              ? const Center(child: Text("You are not following any tailors."))
              : ListView.builder(
                  itemCount: followingTailors.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(followingTailors[index]["image"]),
                      ),
                      title: Text(
                        followingTailors[index]["name"],
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () => confirmUnfollow(index),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TailorProfilePage(
                              tailorId: followingTailors[index]["tailorId"],
                              name: followingTailors[index]["name"],
                              image: followingTailors[index]["image"]
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
