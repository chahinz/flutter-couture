import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'track_order.dart';
import 'detail_page.dart';
import 'leave_review.dart'; // Import LeaveReview page

class ManageOrders extends StatefulWidget {
  const ManageOrders({super.key});

  @override
  State<ManageOrders> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<ManageOrders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "My Orders",
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: const Color.fromARGB(255, 163, 119, 178),
            labelColor: const Color.fromARGB(255, 163, 119, 178),
            unselectedLabelColor: Colors.black,
            labelStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
            tabs: const [
              Tab(text: "Active"),
              Tab(text: "Completed"),
              Tab(text: "Cancelled"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            OrdersList(orderType: "Active"),
            OrdersList(orderType: "Completed"),
            OrdersList(orderType: "Cancelled"),
          ],
        ),
      ),
    );
  }
}

class OrdersList extends StatelessWidget {
  final String orderType;
  const OrdersList({super.key, required this.orderType});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> orders = [
      {
        "title": "Karako",
        "price": "11000 DA",
        "image": "images/1.jpg",
      },
      {
        "title": "Kafton",
        "price": "50000 DA",
        "image": "images/2.jpg",
      },
      {
        "title": "Skirt",
        "price": "6000 DA",
        "image": "images/3.jpg",
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                order["image"]!,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              order["title"]!,
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              order["price"]!,
              style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
            ),
            trailing: ElevatedButton(
              onPressed: () {
                if (orderType == "Active") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TrackOrderPage()),
                  );
                } else if (orderType == "Cancelled") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        imagePath: order["image"]!,
                        title: order["title"]!,
                        price: order["price"]!,
                        description: "High-quality fabric with elegant design.",
                        fabricType: "Silk",
                      ),
                    ),
                  );
                } else if (orderType == "Completed") {
                  // ✅ Navigate to LeaveReview with correct parameters
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LeaveReview(
                        orderImage: order["image"]!,
                        orderTitle: order["title"]!,
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 163, 119, 178),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: Text(
                orderType == "Completed" ? "Leave Review" :
                orderType == "Cancelled" ? "Re-Order" : "Track Order",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
