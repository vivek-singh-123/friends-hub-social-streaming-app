import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          children: [
            // Profile Picture & Name
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : const AssetImage('assets/default_avatar.png')
                  as ImageProvider,
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.grey[700]),
                  onPressed: _pickImage,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "Your Name",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text("Tap to edit bio", style: TextStyle(fontSize: 14)),

            const SizedBox(height: 20),

            // Followers Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _StatTile(label: "Following", value: "0"),
                _StatTile(label: "Followers", value: "0"),
                _StatTile(label: "Sent", value: "0"),
              ],
            ),

            const Divider(height: 30),

            // Profile Tiles with Different Colors
            const _ProfileTile(icon: Icons.account_balance_wallet, title: "Wallet", titleColor: Colors.teal, trailingText: '0'),
            const _ProfileTile(icon: Icons.monetization_on, title: "Earn Money", titleColor: Colors.indigo),
            const _ProfileTile(icon: Icons.redeem, title: "Get Rupees", showDot: true, titleColor: Colors.orange),
            const _ProfileTile(icon: Icons.message, title: "Messages", badge: '11', titleColor: Colors.purple),
            const _ProfileTile(icon: Icons.task_alt, title: "Task", badge: "Check In", titleColor: Colors.green),
            const _ProfileTile(icon: Icons.emoji_events, title: "Badge", titleColor: Colors.pink),
            const _ProfileTile(icon: Icons.security, title: "Account Security", titleColor: Colors.deepPurple),
            const _ProfileTile(icon: Icons.settings, title: "Settings", titleColor: Colors.brown),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;

  const _StatTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailingText;
  final String? badge;
  final bool showDot;
  final Color? titleColor;

  const _ProfileTile({
    required this.icon,
    required this.title,
    this.trailingText,
    this.badge,
    this.showDot = false,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget trailing;

    if (badge != null) {
      trailing = Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red[600],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(badge!, style: const TextStyle(color: Colors.white)),
      );
    } else if (trailingText != null) {
      trailing = Text(trailingText!,
          style: const TextStyle(fontWeight: FontWeight.bold));
    } else if (showDot) {
      trailing = const CircleAvatar(radius: 4, backgroundColor: Colors.red);
    } else {
      trailing = const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey);
    }

    return ListTile(
      leading: Icon(icon, color: Colors.grey[800]),
      title: Text(
        title,
        style: TextStyle(color: titleColor ?? Colors.black87),
      ),
      trailing: trailing,
    );
  }
}