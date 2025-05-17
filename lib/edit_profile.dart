import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // void _saveProfile() async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       await updateUserProfile(
  //         newEmail: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
  //         oldPassword: _oldPasswordController.text.trim().isEmpty ? null : _oldPasswordController.text.trim(),
  //         newPassword: _newPasswordController.text.trim().isEmpty ? null : _newPasswordController.text.trim(),
  //         confirmPassword: _confirmPasswordController.text.trim().isEmpty ? null : _confirmPasswordController.text.trim(),
  //         address: _addressController.text.trim().isEmpty ? null : _addressController.text.trim(),
  //       );

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Profile updated successfully!', style: GoogleFonts.poppins())),
  //       );
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error: $e', style: GoogleFonts.poppins())),
  //       );
  //     }
  //   }
  // }

//   void _saveProfile() async {
//   if (_formKey.currentState!.validate()) {
//     try {
//       await updateUserProfile(
//         newEmail: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
//         oldPassword: _oldPasswordController.text.trim().isEmpty ? null : _oldPasswordController.text.trim(),
//         newPassword: _newPasswordController.text.trim().isEmpty ? null : _newPasswordController.text.trim(),
//         confirmPassword: _confirmPasswordController.text.trim().isEmpty ? null : _confirmPasswordController.text.trim(),
//         address: _addressController.text.trim().isEmpty ? null : _addressController.text.trim(),
//       );

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Profile updated successfully!', style: GoogleFonts.poppins())),
//       );

//       Navigator.pop(context);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e', style: GoogleFonts.poppins())),
//       );
//     }
//   }
// }

void _saveProfile() async {
  if (_formKey.currentState!.validate()) {
    try {
      await updateUserProfile(
        newEmail: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
        oldPassword: _oldPasswordController.text.trim().isEmpty ? null : _oldPasswordController.text.trim(),
        newPassword: _newPasswordController.text.trim().isEmpty ? null : _newPasswordController.text.trim(),
        confirmPassword: _confirmPasswordController.text.trim().isEmpty ? null : _confirmPasswordController.text.trim(),
        address: _addressController.text.trim().isEmpty ? null : _addressController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!', style: GoogleFonts.poppins())),
      );
      Navigator.pop(context, _addressController.text.trim());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e', style: GoogleFonts.poppins())),
      );
    }
  }
}


  Future<void> updateUserProfile({
    required String? newEmail,
    required String? oldPassword,
    required String? newPassword,
    required String? confirmPassword,
    required String? address,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    // Re-authenticate if email or password is being updated
    if ((newEmail != null && newEmail != user.email) ||
        (newPassword != null && newPassword.isNotEmpty)) {
      if (oldPassword == null || oldPassword.isEmpty) {
        throw Exception("Old password is required to update email or password.");
      }

      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );
      await user.reauthenticateWithCredential(credential);

      if (newEmail != null && newEmail.isNotEmpty && newEmail != user.email) {
        await user.updateEmail(newEmail);
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({'email': newEmail});
        await FirebaseFirestore.instance.collection('customer').doc(user.uid).update({'email': newEmail});
      }

      if (newPassword != null &&
          newPassword.isNotEmpty &&
          newPassword == confirmPassword) {
        await user.updatePassword(newPassword);
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({'password': newPassword});
        await FirebaseFirestore.instance.collection('customer').doc(user.uid).update({'password': newPassword});
      }
    }

    // Update address regardless
    if (address != null && address.isNotEmpty) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
        {'address': address},
        SetOptions(merge: true),
      );

      await FirebaseFirestore.instance.collection('customer').doc(user.uid).set(
        {'address': address},
        SetOptions(merge: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Edit Your Informations',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFA377B2),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _buildSectionTitle("Edit Email"),
                _buildTextField("Email", _emailController, keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 30),
                _buildSectionTitle("Change Password"),
                _buildTextField("Old Password", _oldPasswordController, isPassword: true),
                const SizedBox(height: 15),
                _buildTextField("New Password", _newPasswordController, isPassword: true),
                const SizedBox(height: 15),
                _buildTextField("Confirm New Password", _confirmPasswordController, isPassword: true),
                const SizedBox(height: 30),
                _buildSectionTitle("Edit Address"),
                _buildTextField("Address", _addressController),
                const SizedBox(height: 40),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA377B2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: _saveProfile,
                    child: Text('Save Profile', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isPassword = false, TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          style: GoogleFonts.poppins(),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFFA377B2),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}