import 'package:flutter/material.dart';

class TermsAndPrivacyScreen extends StatelessWidget {
  const TermsAndPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Added a subtle background color
      appBar: AppBar(
        title: const Text(
          'Terms & Privacy Policy',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1, // Slightly increased elevation for AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              icon: Icons.description,
              title: 'Terms of Service',
              content:
              'Welcome to Friends HUB! These terms and conditions outline the rules and regulations for the use of Friends HUB\'s Website, located at [Your Website URL].\n\nBy accessing this website we assume you accept these terms and conditions. Do not continue to use Friends HUB if you do not agree to take all of the terms and conditions stated on this page.',
            ),
            const SizedBox(height: 20),
            _buildSection(
              context,
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              content:
              'Your privacy is important to us. It is Friends HUB\'s policy to respect your privacy regarding any information we may collect from you across our website, [Your Website URL], and other sites we own and operate.\n\nWe only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent. We also let you know why we’re collecting it and how it will be used.',
            ),
            const SizedBox(height: 20),
            _buildSection(
              context,
              icon: Icons.people_alt_outlined,
              title: 'User Conduct',
              content:
              'Users are expected to behave respectfully and adhere to community guidelines. Any form of harassment, hate speech, or inappropriate content is strictly prohibited and may result in account termination.',
            ),
            const SizedBox(height: 20),
            _buildSection(
              context,
              icon: Icons.update,
              title: 'Changes to Terms',
              content:
              'We reserve the right to modify these terms at any time. Your continued use of the service after any such changes constitutes your acceptance of the new Terms of Service.',
            ),
            const SizedBox(height: 20),
            _buildSection(
              context,
              icon: Icons.contact_support_outlined,
              title: 'Contact Us',
              content:
              'If you have any questions about these Terms, please contact us at support@friendshub.com.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required IconData icon, required String title, required String content}) {
    return Card(
      elevation: 2, // Added elevation for card effect
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero, // Remove default card margin
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.deepOrange, size: 24), // Added icon
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87), // Enhanced title style
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.5), // Enhanced content style
            ),
          ],
        ),
      ),
    );
  }
}
