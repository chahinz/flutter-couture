import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Your privacy is important to us. This Privacy Policy outlines how we collect, use, and protect your personal information when you use our application.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildSection("1. Information We Collect", "We collect personal information such as your name, email, and usage data to improve our services."),
            _buildSection("2. How We Use Your Data", "Your data is used to enhance your experience, provide support, and improve our services. We do not sell or share your personal information with third parties without your consent."),
            _buildSection("3. Data Security", "We implement strict security measures to protect your data. However, no method of transmission over the internet is 100% secure."),
            _buildSection("4. Your Rights", "You have the right to access, modify, or delete your personal data. Contact us for any privacy-related requests."),
            _buildSection("5. Changes to This Policy", "We may update our Privacy Policy from time to time. We encourage you to review this page periodically for any changes."),
            const SizedBox(height: 20),
            const Text(
              "If you have any questions regarding our Privacy Policy, please contact us at support@example.com.",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
