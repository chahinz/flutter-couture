import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'new_design_screen.dart';
import 'admin_emails_screen.dart'; // Add this import

class AdminNotificationsScreen extends StatefulWidget {
  @override
  _AdminNotificationsScreenState createState() =>
      _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState extends State<AdminNotificationsScreen> {
  final List<Map<String, String>> notifications = [
    {
      'title': 'New Login Detected',
      'description': 'A new login from an unknown device.',
      'icon': '🔑',
    },
    {
      'title': 'Emails sent',
      'description': 'A customer has submitted a new Email to a tailor.',
      'icon': '📩',
    },
    {
      'title': 'New Purchase',
      'description': 'A customer made a new purchase.',
      'icon': '💰',
    },
    {
      'title': 'Security Alert',
      'description': 'Multiple failed login attempts detected.',
      'icon': '⚠️',
    },
    {
      'title': 'New Design Uploaded',
      'description': 'Modern design with vibrant colors and sleek finish.',
      'icon': '🧵',
      'price': '150.00',
      'tailorName': 'John Doe',
      'fabricType': 'Cotton',
      'tailorImage': 'images/15.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: Text(
                notification['icon']!,
                style: GoogleFonts.poppins(fontSize: 24),
              ),
              title: Text(
                notification['title']!,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                notification['description']!,
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              trailing: Icon(Icons.notifications_active, color: Colors.redAccent),
              onTap: () {
                if (notification['title'] == 'New Design Uploaded') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewDesignScreen(
                        title: notification['title']!,
                        price: notification['price']!,
                        description: notification['description']!,
                        tailorName: notification['tailorName']!,
                        fabricType: notification['fabricType']!,
                        tailorImage: notification['tailorImage']!,
                      ),
                    ),
                  );
                } else if (notification['title'] == 'Emails sent') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminEmailsScreen(),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}