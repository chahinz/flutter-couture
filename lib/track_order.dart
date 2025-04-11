import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackOrderPage extends StatelessWidget {
  const TrackOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Track Order",
          style: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "images/1.jpg",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kaftan Royal",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    Text("Tailor: Ines",
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: Colors.grey)),
                    const SizedBox(height: 5),
                    Text("Price: 25000DA",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Text("Order Details",
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  orderDetailRow("Order Number", "#123456"),
                  orderDetailRow("Order Date", "10 Jan 2024"),
                  orderDetailRow("Estimated Delivery", "12 Jan 2024"),
                  orderDetailRow("Shipping Address", "Algiers, Algeria"),
                  const Divider(),
                  orderDetailRow("Size", "M"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Color",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey)),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  orderDetailRow("Notes", "Custom embroidery on sleeves"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text("Order Status", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Column(
              children: List.generate(6, (index) {
                return orderStep(
                  [
                    "Pattern Making (الباترون)",
                    "Fabric Cutting (التفصيل)",
                    "Preliminary Sewing (الخياطة الأولية)",
                    "Edge Finishing (السرفلة)",
                    "Accessories Assembly (تركيب الكماليات)",
                    "Delivery (التوصيل)"
                  ][index],
                  [
                    "10 Jan 2024 10:00 AM",
                    "10 Jan 2024 02:00 PM",
                    "11 Jan 2024 08:00 AM",
                    "11 Jan 2024",
                    "11 Jan 2024",
                    "11 Jan 2024"
                  ][index],
                  index < 2,
                  index != 5,
                );
              }),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: const Color.fromARGB(255, 163, 119, 178),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: Text("Cancel Order",
                    style: GoogleFonts.poppins(
                        fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderStep(String title, String date, bool isCompleted, bool hasLine) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? const Color.fromARGB(255, 163, 119, 178)
                        : Colors.grey.shade400,
                  ),
                  child: const Icon(Icons.check, size: 16, color: Colors.white),
                ),
                if (hasLine)
                  Container(
                    width: 2,
                    height: 60,
                    color: isCompleted
                        ? const Color.fromARGB(255, 163, 119, 178)
                        : Colors.grey.shade300,
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold)),
                Text(date, style: GoogleFonts.poppins(
                    fontSize: 14, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget orderDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey)),
          Text(value, style: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}