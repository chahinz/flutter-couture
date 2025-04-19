import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, String>> notifications = [
    {"title": "Order Shipped", "message": "Your order #1234 has been shipped.", "time": "2h ago"},
    {"title": "New Discount", "message": "Get 20% off on your next order!", "time": "5h ago"},
    {"title": "Order Delivered", "message": "Your order #1234 has been delivered.", "time": "1d ago"},
    {"title": "Payment Received", "message": "Your payment of \$50.00 was successful.", "time": "2d ago"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 245, 243, 249),
        foregroundColor: Colors.black,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor:const Color.fromARGB(255, 163, 119, 178),
              child: Icon(Icons.notifications, color: Colors.white),
            ),
            title: Text(
              notification["title"]!,
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              notification["message"]!,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
            ),
            trailing: Text(
              notification["time"]!,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
