import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminEmailsScreen extends StatefulWidget {
  @override
  _AdminEmailsScreenState createState() => _AdminEmailsScreenState();
}

class _AdminEmailsScreenState extends State<AdminEmailsScreen> {
  final List<Map<String, dynamic>> emails = [
    {
      'sender': 'Customer: Ahmed Ali',
      'recipient': 'Tailor: Ines Tailor',
      'subject': 'Custom Dress Request',
      'content': 'Hello, I would like to request a custom dress with specific measurements...',
      'date': 'May 15, 2023 - 10:30 AM',
      'status': 'pending', // pending, accepted, rejected
    },
    {
      'sender': 'Customer: Sara Mohamed',
      'recipient': 'Tailor: Youssef Tailor',
      'subject': 'Wedding Suit Inquiry',
      'content': 'I need a wedding suit tailored for my brother. What fabrics do you have available?',
      'date': 'May 14, 2023 - 3:45 PM',
      'status': 'pending',
    },
    {
      'sender': 'Customer: Fatima Zahra',
      'recipient': 'Tailor: Karim Design',
      'subject': 'Dress Modification',
      'content': 'Can you modify the sleeves of the dress I ordered last week?',
      'date': 'May 13, 2023 - 9:15 AM',
      'status': 'pending',
    },
  ];

  void _updateEmailStatus(int index, String status) {
    setState(() {
      emails[index]['status'] = status;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Email ${status} successfully'),
        backgroundColor: status == 'accepted' ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: emails.length,
        itemBuilder: (context, index) {
          final email = emails[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ExpansionTile(
              title: Text(
                email['subject'],
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From: ${email['sender']}',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  if (email['status'] != 'pending')
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        'Status: ${email['status']}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: email['status'] == 'accepted' 
                              ? Colors.green 
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'To: ${email['recipient']}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        email['content'],
                        style: GoogleFonts.poppins(fontSize: 15),
                      ),
                      SizedBox(height: 15),
                      Text(email['date'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 20),
                      if (email['status'] == 'pending')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () => _updateEmailStatus(index, 'rejected'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                'Reject',
                                style: GoogleFonts.poppins(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () => _updateEmailStatus(index, 'accepted'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                'Accept',
                                style: GoogleFonts.poppins(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ceci ne se developpe pas car impossibilite d'acceder a la boite email d'un autre compte google ! 
}