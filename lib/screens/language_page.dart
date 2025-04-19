import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language'),
        backgroundColor: Colors.grey[50],
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          _buildLanguageOption('English'),
          _buildLanguageOption('Français'),
          _buildLanguageOption('العربية'),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String language) {
    return RadioListTile<String>(
      title: Text(language, style: TextStyle()),
      value: language,
      groupValue: _selectedLanguage,
      activeColor: Color.fromARGB(255, 184, 142, 113), 
      onChanged: (value) {
        setState(() {
          _selectedLanguage = value!;
        });
      },
    );
  }
}
