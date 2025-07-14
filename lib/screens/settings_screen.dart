import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage = 'English';
  bool _notificationsEnabled = true;
  bool _hideFavorites = false;
  bool _hideLikes = false;
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Language', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          DropdownButton<String>(
            value: _selectedLanguage,
            items: ['English', 'Hindi', 'Spanish', 'French']
                .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
                .toList(),
            onChanged: (value) => setState(() => _selectedLanguage = value!),
          ),
          const Divider(),

          SwitchListTile(
            title: const Text('Notifications'),
            value: _notificationsEnabled,
            onChanged: (value) => setState(() => _notificationsEnabled = value),
          ),

          const Divider(),
          const Text('Privacy Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SwitchListTile(
            title: const Text('Hide my favorites'),
            value: _hideFavorites,
            onChanged: (value) => setState(() => _hideFavorites = value),
          ),
          SwitchListTile(
            title: const Text('Hide my likes'),
            value: _hideLikes,
            onChanged: (value) => setState(() => _hideLikes = value),
          ),

          const Divider(),
          ListTile(
            title: const Text('Privilege Setting'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Blacklist'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),

          const Divider(),
          ListTile(
            title: const Text('Clear Cache'),
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cache cleared')),
            ),
          ),

          const Divider(),
          const Text('About Us', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Center(
            child: Column(
              children: [
                Icon(Icons.live_tv, size: 60),
                SizedBox(height: 5),
                Text('GOSH LIVE v1.0.0', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),

          const Divider(),
          ListTile(
            title: const Text('Terms and Conditions'),
            onTap: () => _showLongTextDialog(context, 'Terms and Conditions', _termsText),
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            onTap: () => _showLongTextDialog(context, 'Privacy Policy', _privacyText),
          ),

          const Divider(),
          const Text('Feedback', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) => IconButton(
              icon: Icon(
                index < _selectedRating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: () => setState(() => _selectedRating = index + 1),
            )),
          ),
        ],
      ),
    );
  }

  void _showLongTextDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: Text(content)),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
      ),
    );
  }
}

const String _termsText = 'These are the terms and conditions... (you can expand this)';
const String _privacyText = 'This is the privacy policy... (you can expand this)';
