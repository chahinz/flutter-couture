// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class EditProfile extends StatefulWidget {
//   const EditProfile({super.key});

//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _bioController = TextEditingController();

//   String? _selectedWilaya;
//   File? _profileImage;
//   File? _bannerImage;

//   final List<String> _wilayas = [
//     '1. Adrar', '2. Chlef', '3. Laghouat', '4. Oum El Bouaghi',
//     '5. Batna', '6. Béjaïa', '7. Biskra', '8. Béchar', '9. Blida',
//     '10. Bouira', '11. Tamanrasset', '12. Tébessa', '13. Tlemcen',
//     '14. Tiaret', '15. Tizi Ouzou', '16. Algiers', '17. Djelfa',
//     '18. Jijel', '19. Sétif', '20. Saïda', '21. Skikda',
//     '22. Sidi Bel Abbès', '23. Annaba', '24. Guelma', '25. Constantine',
//     '26. Médéa', '27. Mostaganem', '28. M\'Sila', '29. Mascara',
//     '30. Ouargla', '31. Oran', '32. El Bayadh', '33. Illizi',
//     '34. Bordj Bou Arréridj', '35. Boumerdès', '36. El Tarf',
//     '37. Tindouf', '38. Tissemsilt', '39. El Oued', '40. Khenchela',
//     '41. Souk Ahras', '42. Tipaza', '43. Mila', '44. Aïn Defla',
//     '45. Naâma', '46. Aïn Témouchent', '47. Ghardaïa', '48. Relizane',
//     '49. Timimoun', '50. Bordj Badji Mokhtar', '51. Ouled Djellal',
//     '52. Béni Abbès', '53. In Salah', '54. In Guezzam', '55. Touggourt',
//     '56. Djanet', '57. El M\'Ghair', '58. El Meniaa'
//   ];

//   Future<void> _pickImage(bool isProfile, ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         if (isProfile) {
//           _profileImage = File(pickedFile.path);
//         } else {
//           _bannerImage = File(pickedFile.path);
//         }
//       });
//     }
//   }


// void _saveProfile() async {
//   if (_formKey.currentState!.validate()) {
//     final uid = FirebaseAuth.instance.currentUser?.uid;
//     if (uid == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("User not logged in", style: GoogleFonts.poppins())),
//       );
//       return;
//     }

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => Center(child: CircularProgressIndicator()),
//     );

//     try {
//       final docRef = FirebaseFirestore.instance.collection('tailors').doc(uid);
//       final currentData = await docRef.get();

//       Map<String, dynamic> updates = {};

//       // Compare phone number
//       final phoneInput = _phoneController.text.trim();
//       if (phoneInput.isNotEmpty && phoneInput != currentData['phoneNumber']) {
//         updates['phoneNumber'] = phoneInput;
//       }

//       // Compare bio
//       final bioInput = _bioController.text.trim();
//       if (bioInput.isNotEmpty && bioInput != currentData['bio']) {
//         updates['bio'] = bioInput;
//       }

//       // Compare wilaya
//       if (_selectedWilaya != null && _selectedWilaya != currentData['wilaya']) {
//         updates['wilaya'] = _selectedWilaya;
//       }

//       // Upload profile image if changed
//       if (_profileImage != null) {
//         final profileRef = FirebaseStorage.instance.ref().child('users/$uid/profile.jpg');
//         await profileRef.putFile(_profileImage!);
//         final profileImageUrl = await profileRef.getDownloadURL();
//         updates['profileImage'] = profileImageUrl;
//       }

//       // Upload banner image if changed
//       if (_bannerImage != null) {
//         final bannerRef = FirebaseStorage.instance.ref().child('users/$uid/banner.jpg');
//         await bannerRef.putFile(_bannerImage!);
//         final bannerImageUrl = await bannerRef.getDownloadURL();
//         updates['bannerImage'] = bannerImageUrl;
//       }

//       // Only update if there are changes
//       if (updates.isNotEmpty) {
//         await docRef.set(updates, SetOptions(merge: true));
//       }

//       Navigator.of(context).pop();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Profile updated successfully!', style: GoogleFonts.poppins())),
//       );
//     } catch (e) {
//       Navigator.of(context).pop();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error updating profile: $e', style: GoogleFonts.poppins())),
//       );
//     }
//   }
// }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         backgroundColor: Colors.grey[200],
//         title: Text('Edit Profile', style: GoogleFonts.poppins(color: Colors.black)),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Stack(
//               clipBehavior: Clip.none,
//               alignment: Alignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: () => _pickImage(false, ImageSource.gallery),
//                   child: Container(
//                     width: double.infinity,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       image: _bannerImage != null
//                           ? DecorationImage(
//                               image: FileImage(_bannerImage!),
//                               fit: BoxFit.cover,
//                             )
//                           : null,
//                     ),
//                     child: _bannerImage == null
//                         ? Center(
//                             child: Text('Tap to change banner image', style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54)),
//                           )
//                         : null,
//                   ),
//                 ),
//                 Positioned(
//                   bottom: -50,
//                   child: GestureDetector(
//                     onTap: () => _pickImage(true, ImageSource.camera),
//                     child: Column(
//                       children: [
//                         CircleAvatar(
//                           radius: 55,
//                           backgroundColor: Colors.white,
//                           child: CircleAvatar(
//                             radius: 50,
//                             backgroundColor: Colors.purple[200],
//                             backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
//                             child: _profileImage == null
//                                 ? Icon(Icons.camera_alt, size: 40, color: Colors.white)
//                                 : null,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Text('Tap to change profile picture', style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 60),
//             Center(
//               child: Text('Edit Your Profile', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFA377B2))),
//             ),
//             SizedBox(height: 20),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Select Wilaya", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
//                     DropdownButtonFormField<String>(
//                       value: _selectedWilaya,
//                       decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//                       items: _wilayas.map((String wilaya) {
//                         return DropdownMenuItem<String>(
//                           value: wilaya,
//                           child: Text(wilaya, style: GoogleFonts.poppins()),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() => _selectedWilaya = newValue);
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     _buildTextField("Phone Number", _phoneController),
//                     SizedBox(height: 20),
//                     _buildTextField("Bio/Description", _bioController, maxLines: 3),
//                     SizedBox(height: 30),
//                     Center(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xFFA377B2),
//                           foregroundColor: Colors.white,
//                           padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                         ),
//                         onPressed: _saveProfile,
//                         child: Text('Save Profile', style: GoogleFonts.poppins()),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
//         SizedBox(height: 5),
//         TextFormField(
//           controller: controller,
//           decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//           maxLines: maxLines,
//           style: GoogleFonts.poppins(),
//         ),
//       ],
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  String? _selectedWilaya;
  File? _profileImage;
  File? _bannerImage;
  String? _profileImageUrl;
  String? _bannerImageUrl;

  final List<String> _wilayas = [];

  final String cloudName = 'dyxrwqehs';
  final String uploadPreset = 'flutter_unsigned';

  Future<String?> _uploadToCloudinary(File file, String folderName) async {
    final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
    final mimeTypeData = lookupMimeType(file.path)?.split('/') ?? ['image', 'jpeg'];

    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..fields['folder'] = folderName
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        file.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      ));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await http.Response.fromStream(response);
      final url = RegExp(r'"url":"(.*?)"').firstMatch(responseData.body)?.group(1);
      return url?.replaceAll(r'\/', '/');
    } else {
      return null;
    }
  }

  Future<void> _pickImage(bool isProfile) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        if (isProfile) {
          _profileImage = file;
        } else {
          _bannerImage = file;
        }
      });

      final folder = isProfile ? 'profile_pictures' : 'banner_images';
      final url = await _uploadToCloudinary(file, folder);

      if (url != null) {
        final uid = FirebaseAuth.instance.currentUser?.uid;
        if (uid != null) {
          try {
            final docRef = FirebaseFirestore.instance.collection('tailors').doc(uid);

            // Update Firestore immediately with new image URL
            if (isProfile) {
              await docRef.set({'profileImage': url}, SetOptions(merge: true));
              setState(() => _profileImageUrl = url);
            } else {
              await docRef.set({'bannerImage': url}, SetOptions(merge: true));
              setState(() => _bannerImageUrl = url);
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to update Firestore: $e', style: GoogleFonts.poppins())),
            );
          }
        }

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image to Cloudinary', style: GoogleFonts.poppins())),
        );
      }
    }
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User not logged in", style: GoogleFonts.poppins())),
        );
        return;
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Center(child: CircularProgressIndicator()),
      );

      try {
        final docRef = FirebaseFirestore.instance.collection('tailors').doc(uid);
        final currentData = await docRef.get();

        Map<String, dynamic> updates = {};

        final phoneInput = _phoneController.text.trim();
        if (phoneInput.isNotEmpty && phoneInput != currentData['phoneNumber']) {
          updates['phoneNumber'] = phoneInput;
        }

        final bioInput = _bioController.text.trim();
        if (bioInput.isNotEmpty && bioInput != currentData['bio']) {
          updates['bio'] = bioInput;
        }

        if (_selectedWilaya != null && _selectedWilaya != currentData['wilaya']) {
          updates['wilaya'] = _selectedWilaya;
        }

        // No need to update images here, already updated in _pickImage

        if (updates.isNotEmpty) {
          await docRef.set(updates, SetOptions(merge: true));
        }

        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!', style: GoogleFonts.poppins())),
        );
      } catch (e) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e', style: GoogleFonts.poppins())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // ... your existing build method unchanged ...
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.grey[200],
        title: Text('Edit Profile', style: GoogleFonts.poppins(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                      color: Colors.grey[200],
                      image: _bannerImage != null
                          ? DecorationImage(image: FileImage(_bannerImage!), fit: BoxFit.cover)
                          : null,
                    ),
                    child: _bannerImage == null
                        ? Center(child: Text('Tap to change banner image', style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54)))
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
                            backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                            child: _profileImage == null ? Icon(Icons.camera_alt, size: 40, color: Colors.white) : null,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Tap to change profile picture', style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            Center(
              child: Text('Edit Your Profile', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFA377B2))),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Select Wilaya", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    DropdownButtonFormField<String>(
                      value: _selectedWilaya,
                      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                      items: _wilayas.map((String wilaya) {
                        return DropdownMenuItem<String>(
                          value: wilaya,
                          child: Text(wilaya, style: GoogleFonts.poppins()),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() => _selectedWilaya = newValue);
                      },
                    ),
                    SizedBox(height: 20),
                    _buildTextField("Phone Number", _phoneController),
                    SizedBox(height: 20),
                    _buildTextField("Bio/Description", _bioController, maxLines: 3),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFA377B2),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        ),
                        onPressed: _saveProfile,
                        child: Text('Save Profile', style: GoogleFonts.poppins()),
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

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins
(fontWeight: FontWeight.bold)),
SizedBox(height: 8),
TextFormField(
controller: controller,
maxLines: maxLines,
decoration: InputDecoration(
border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
filled: true,
fillColor: Colors.grey[200],
),
validator: (value) {
if (label == "Phone Number" && (value == null || value.isEmpty)) {
return 'Please enter your phone number';
}
return null;
},
),
],
);
}

@override
void dispose() {
_phoneController.dispose();
_bioController.dispose();
super.dispose();
}
}