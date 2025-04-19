import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateOrderPage extends StatefulWidget {
  final String title;
  final String price;
  // final String image;
  final String color;
  final String size;
  final String notes;

  const UpdateOrderPage({
    super.key,
    required this.title,
    required this.price,
    // required this.image,
    required this.color,
    required this.size,
    required this.notes,
  });

  @override
  State<UpdateOrderPage> createState() => _UpdateOrderPageState();
}

class _UpdateOrderPageState extends State<UpdateOrderPage> {
  List<bool> isChecked = [false, false, false, false, false, false]; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Order")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Center(
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(12),
            //     child: Image.asset(
            //       widget.image,
            //       width: 250, 
            //       height: 250,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
            Text(
              widget.title,
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              "${widget.price} DA",
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              "Order Details:",
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            buildOrderDetail("Color", widget.color),
            buildOrderDetail("Size", widget.size),
            buildOrderDetail("Notes", widget.notes),
            const SizedBox(height: 20),
            Text(
              "Order Steps:",
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            buildTaskItem(0, "Step 1: Pattern Making (الباترون)"),
            buildTaskItem(1, "Step 2: Fabric Cutting (التفصيل)"),
            buildTaskItem(2, "Step 3: Preliminary Sewing (الخياطة الأولية)"),
            buildTaskItem(3, "Step 4: Edge Finishing (السرفلة)"),
            buildTaskItem(4, "Step 5: Accessories Assembly (تركيب الكماليات)"),
            buildTaskItem(5, "Step 6: Delivery (التوصيل)"),
          ],
        ),
      ),
    );
  }

  Widget buildOrderDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTaskItem(int index, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ),
          SizedBox(
            width: 28,
            height: 28,
            child: Checkbox(
              value: isChecked[index],
              onChanged: (bool? value) {
                setState(() {
                  isChecked[index] = value ?? false;
                });
              },
              shape: const CircleBorder(),
              activeColor: const Color.fromARGB(255, 163, 119, 178),
            ),
          ),
        ],
      ),
    );
  }
}