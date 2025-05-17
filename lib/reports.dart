import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> tailorComplaints = [
    {
      "title": "Delayed Order",
      "description": "The tailor didn't deliver the dress on time.",
      "date": "March 15, 2025",
      "icon": Icons.warning,
      "color": Colors.red,
    },
    {
      "title": "Measurement Issue",
      "description": "The dress size was incorrect despite exact measurements.",
      "date": "March 12, 2025",
      "icon": Icons.error_outline,
      "color": Colors.orange,
    },
  ];

  final List<Map<String, dynamic>> customerComplaints = [
    {
      "title": "Customer Didn’t Pay",
      "description": "The customer refused to pay after receiving the order.",
      "date": "March 10, 2025",
      "icon": Icons.report_problem,
      "color": Colors.blue,
    },
    {
      "title": "Late Pickup",
      "description": "Customer delayed picking up their order for weeks.",
      "date": "March 8, 2025",
      "icon": Icons.access_time,
      "color": Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Complaints Against Tailors", Colors.red),
            complaintList(tailorComplaints),
            SizedBox(height: 20),
            sectionTitle("Complaints Against Customers", Colors.blue),
            complaintList(customerComplaints),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget complaintList(List<Map<String, dynamic>> complaints) {
    return Column(
      children: complaints.map((complaint) {
        return complaintCard(
          title: complaint["title"],
          description: complaint["description"],
          date: complaint["date"],
          icon: complaint["icon"],
          color: complaint["color"],
        );
      }).toList(),
    );
  }

  Widget complaintCard({
    required String title,
    required String description,
    required String date,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            SizedBox(height: 4),
            Text(
              date,
              style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}
