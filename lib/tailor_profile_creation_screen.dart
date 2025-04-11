import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_couture/tailor_categories.dart'; // Add this import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TailorProfileCreationScreen extends StatefulWidget {
  const TailorProfileCreationScreen({super.key});

  @override
  State<TailorProfileCreationScreen> createState() =>
      _TailorProfileCreationScreenState();
}

class _TailorProfileCreationScreenState
    extends State<TailorProfileCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  String? _selectedWilaya;
  String? _selectedBusinessType;
  File? _profileImage;
  File? _bannerImage;

  final List<String> _businessTypes = ['Home Based', 'Atelier (Workshop)'];
  final List<String> _wilayas = [
    '1. Adrar',
    '2. Chlef',
    '3. Laghouat',
    '4. Oum El Bouaghi',
    '5. Batna',
    '6. Béjaïa',
    '7. Biskra',
    '8. Béchar',
    '9. Blida',
    '10. Bouira',
    '11. Tamanrasset',
    '12. Tébessa',
    '13. Tlemcen',
    '14. Tiaret',
    '15. Tizi Ouzou',
    '16. Algiers',
    '17. Djelfa',
    '18. Jijel',
    '19. Sétif',
    '20. Saïda',
    '21. Skikda',
    '22. Sidi Bel Abbès',
    '23. Annaba',
    '24. Guelma',
    '25. Constantine',
    '26. Médéa',
    '27. Mostaganem',
    '28. MSila',
    '29. Mascara',
    '30. Ouargla',
    '31. Oran',
    '32. El Bayadh',
    '33. Illizi',
    '34. Bordj Bou Arréridj',
    '35. Boumerdès',
    '36. El Tarf',
    '37. Tindouf',
    '38. Tissemsilt',
    '39. El Oued',
    '40. Khenchela',
    '41. Souk Ahras',
    '42. Tipaza',
    '43. Mila',
    '44. Aïn Defla',
    '45. Naâma',
    '46. Aïn Témouchent',
    '47. Ghardaïa',
    '48. Relizane',
    '49. El M\'Ghair',
    '50. El Menia',
    '51. Ouled Djellal',
    '52. Bordj Baji Mokhtar',
    '53. Beni Abbes',
    '54. Timimoun',
    '55. Touggourt',
    '56. Djanet',
    '57. In Salah',
    '58. In Guezzam'
  ];

  Future<void> _pickImage(bool isProfile) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isProfile) {
          _profileImage = File(pickedFile.path);
        } else {
          _bannerImage = File(pickedFile.path);
        }
      });
    }
  }

//   Future<String> _uploadImageToFirebase(File imageFile, String path) async {
//   final userId = FirebaseAuth.instance.currentUser?.uid;
//   final ref = FirebaseStorage.instance
//       .ref()
//       .child('tailors/$userId/$path.jpg');

//   final uploadTask = ref.putFile(imageFile);
//   final snapshot = await uploadTask.whenComplete(() {});
//   final downloadUrl = await snapshot.ref.getDownloadURL();
//   return downloadUrl;
// }

Future<String?> _uploadImage(File image, String path) async {
  try {
    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = await ref.putFile(image);
    final url = await ref.getDownloadURL();
    return url;
  } catch (e) {
    print('Image upload error: $e');
    return null;
  }
}

//   void _saveAndNavigate() async {
//   if (_formKey.currentState!.validate()) {
//      final userId = FirebaseAuth.instance.currentUser?.uid;
//     if (userId != null) {
//     try {
//       await FirebaseFirestore.instance.collection('tailors').doc(userId).set({
//         'businessType': _selectedBusinessType,
//         'wilaya': _selectedWilaya,
//         'phoneNumber': _phoneController.text.trim(),
//         'bio': _bioController.text.trim(),
//         'createdAt': FieldValue.serverTimestamp(),
//       }, SetOptions(merge: true)); 
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const TailorCategoriesScreen()),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error saving data: $e')),
//       );
//     }
//   }
// }
// }

void _saveAndNavigate() async {
  if (_formKey.currentState!.validate()) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
        String? profileUrl;
        String? bannerUrl;

        if (_profileImage != null) {
          profileUrl = await _uploadImage(
              _profileImage!, 'tailors/$userId/profile.jpg');
        }

        if (_bannerImage != null) {
          bannerUrl = await _uploadImage(
              _bannerImage!, 'tailors/$userId/banner.jpg');
        }

        await FirebaseFirestore.instance.collection('tailors').doc(userId).set({
          'businessType': _selectedBusinessType,
          'wilaya': _selectedWilaya,
          'phoneNumber': _phoneController.text.trim(),
          'bio': _bioController.text.trim(),
          'profileImage': profileUrl,
          'bannerImage': bannerUrl,
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const TailorCategoriesScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving data: $e')),
        );
      }
    }
  }
}



  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    if (!RegExp(r'^(05|06|07)\d{8}$').hasMatch(value)) {
      return 'Invalid Algerian phone number (05/06/07 followed by 8 digits)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.purple),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Setup Your Profile',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () => _pickImage(false),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      image: _bannerImage != null
                          ? DecorationImage(
                              image: FileImage(_bannerImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _bannerImage == null
                        ? const Center(
                            child: Text(
                              'Tap to add a banner image',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                          )
                        : null,
                  ),
                ),
                Positioned(
                  bottom: -50,
                  child: GestureDetector(
                    onTap: () => _pickImage(true),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.purple[200],
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : null,
                            child: _profileImage == null
                                ? const Icon(Icons.camera_alt,
                                    size: 40, color: Colors.white)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Tap to add profile picture',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Business Type",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    DropdownButtonFormField<String>(
                      value: _selectedBusinessType,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      items: _businessTypes.map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() => _selectedBusinessType = newValue);
                      },
                      validator: (value) =>
                          value == null ? 'Please select business type' : null,
                    ),
                    const SizedBox(height: 20),
                    const Text("Select Wilaya",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    DropdownButtonFormField<String>(
                      value: _selectedWilaya,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      items: _wilayas.map((String wilaya) {
                        return DropdownMenuItem<String>(
                          value: wilaya,
                          child: Text(wilaya),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() => _selectedWilaya = newValue);
                      },
                      validator: (value) =>
                          value == null ? 'Please select your wilaya' : null,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      "Phone Number",
                      _phoneController,
                      validator: _validatePhoneNumber,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField("Bio/Description", _bioController,
                        maxLines: 3),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple[200],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                        ),
                        onPressed: _saveAndNavigate,
                        child: const Text('Next'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          maxLines: maxLines,
          validator: validator,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
