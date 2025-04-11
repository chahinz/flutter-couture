import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class LeaveReview extends StatefulWidget {
  final String orderImage; // Path to the order's image
  final String orderTitle; // Title of the order being reviewed

  const LeaveReview({
    super.key,
    required this.orderImage,
    required this.orderTitle,
  });

  @override
  _LeaveReviewState createState() => _LeaveReviewState();
}

class _LeaveReviewState extends State<LeaveReview> {
  double _rating = 0; 

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
        elevation: 0, // Remove app bar shadow for a cleaner look
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Displays the order image
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                widget.orderImage,
                width: 180,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),

            // Displays the order title
            Text(
              widget.orderTitle,
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),

            // Rating bar to allow users to give a star rating
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            const SizedBox(height: 20),

            // Text field for users to write their review
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write your review here...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),

            // Submit review button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Display a confirmation message when the review is submitted
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Review Submitted!")),
                  );
                  Navigator.pop(context); // Return to the previous screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 163, 119, 178),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // More rounded corners
                  ),
                ),
                child: Text(
                  "Submit Review",
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
