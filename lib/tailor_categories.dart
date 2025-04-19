import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_couture/main_screentailor.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:firebase_auth/firebase_auth.dart";

class TailorCategoriesScreen extends StatefulWidget {
  const TailorCategoriesScreen({super.key});

  @override
  State<TailorCategoriesScreen> createState() => _TailorCategoriesScreenState();
}

class _TailorCategoriesScreenState extends State<TailorCategoriesScreen> {
  final Set<String> _selectedCategories = {};
  final Color _primaryColor = const Color(0xFF6C5CE7);
  final List<String> _categories = [
    'White Gown',
    'Traditional Wear',
    'Modern Dresses',
    'Pants',
    'Shirts',
    'Prayer Sets',
    'Hijabs',
    'Abayas',
    'Baby Clothing',
    'Gandoura',
    'Classic Wear',
  ];

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });
  }


  void _completeSelection() async {
    if (_selectedCategories.isNotEmpty) {
      final userId = FirebaseAuth.instance.currentUser?.uid;
       if (userId != null) {
      try {
        await FirebaseFirestore.instance.collection('tailors').doc(userId).update({
          'categories': _selectedCategories.toList(),
        });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selected ${_selectedCategories.length} categories'),
          duration: const Duration(seconds: 2),
        ),
      );
       Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreentailor()),
        );
    } catch(e) {
       print("Error updating categories: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save categories'),
            backgroundColor: Colors.red,
          ),  );
    }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: _primaryColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Select Specialties',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // Categories Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final isSelected = _selectedCategories.contains(category);

                    return ElevatedButton(
                      onPressed: () => _toggleCategory(category),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSelected ? _primaryColor : Colors.white,
                        foregroundColor:
                            isSelected ? Colors.white : _primaryColor,
                        side: BorderSide(color: _primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: isSelected ? 4 : 0,
                      ),
                      child: Text(
                        category,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Done Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton.icon(
                onPressed:
                    _selectedCategories.isEmpty ? null : _completeSelection,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 40,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.check, color: Colors.white),
                label: Text(
                  'Done',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
