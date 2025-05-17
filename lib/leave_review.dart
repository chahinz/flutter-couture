// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class LeaveReview extends StatefulWidget {
//   final String orderImage; // Path to the order's image
//   final String orderTitle; // Title of the order being reviewed

//   const LeaveReview({
//     super.key,
//     required this.orderImage,
//     required this.orderTitle,
//   });

//   @override
//   _LeaveReviewState createState() => _LeaveReviewState();
// }

// class _LeaveReviewState extends State<LeaveReview> {
//   double _rating = 0; 

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Leave a Review",
//           style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0, // Remove app bar shadow for a cleaner look
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Displays the order image
//             ClipRRect(
//               borderRadius: BorderRadius.circular(15),
//               child: Image.asset(
//                 widget.orderImage,
//                 width: 180,
//                 height: 180,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(height: 10),

//             // Displays the order title
//             Text(
//               widget.orderTitle,
//               style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 20),

//             // Rating bar to allow users to give a star rating
//             RatingBar.builder(
//               initialRating: _rating,
//               minRating: 1,
//               direction: Axis.horizontal,
//               allowHalfRating: true,
//               itemCount: 5,
//               itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
//               itemBuilder: (context, _) => const Icon(
//                 Icons.star,
//                 color: Colors.amber,
//               ),
//               onRatingUpdate: (rating) {
//                 setState(() {
//                   _rating = rating;
//                 });
//               },
//             ),
//             const SizedBox(height: 20),

//             // Text field for users to write their review
//             TextField(
//               maxLines: 4,
//               decoration: InputDecoration(
//                 hintText: "Write your review here...",
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Submit review button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Display a confirmation message when the review is submitted
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Review Submitted!")),
//                   );
//                   Navigator.pop(context); // Return to the previous screen
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 163, 119, 178),
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30), // More rounded corners
//                   ),
//                 ),
//                 child: Text(
//                   "Submit Review",
//                   style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LeaveReview extends StatefulWidget {
  final String orderImage; 
  final String orderTitle;
  final String tailorId;
  final String? customerUid; 

  const LeaveReview({
    super.key,
    required this.orderImage,
    required this.orderTitle, 
    this.customerUid, 
    required this.tailorId,
  });

  @override
  _LeaveReviewState createState() => _LeaveReviewState();
}

class _LeaveReviewState extends State<LeaveReview> {
  double _rating = 0;
  final TextEditingController _reviewController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitReview() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("You must be logged in to leave a review.")),
    );
    return;
  }

  if (_rating == 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please provide a rating.")),
    );
    return;
  }

  setState(() {
    _isSubmitting = true;
  });

  try {
    await FirebaseFirestore.instance
        .collection('tailors')
        .doc(widget.tailorId)
        .collection('reviews')
        .doc(user.uid) // Using customer UID as document ID
        .set({
      'rating': _rating,
      'comment': _reviewController.text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
      'orderTitle': widget.orderTitle,
      'orderImage': widget.orderImage,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Review submitted successfully!")),
    );

    Navigator.pop(context);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to submit review: $e")),
    );
  }

  setState(() {
    _isSubmitting = false;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Leave a Review",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.orderImage,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.orderTitle,
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _reviewController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Write your comment (optional)",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submitReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 163, 119, 178),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: _isSubmitting
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text("Submit Review", style: GoogleFonts.poppins(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}