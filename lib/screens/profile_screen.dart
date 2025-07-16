import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  Widget _buildStatItem(String label, int value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.black),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/profile_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Profile Info
                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 42,
                            backgroundImage: _image != null
                                ? FileImage(_image!)
                                : const AssetImage('assets/default_avatar.png')
                            as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black26),
                                ),
                                child: const Icon(Icons.edit,
                                    size: 16, color: Colors.black87),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Vivek Singh",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/editProfile');
                            },
                            child: const Text(
                              "Tap to edit bio",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 24),

                  // 🔸 Followers Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem("Followers", 132, () {
                        Navigator.pushNamed(context, '/followers');
                      }),
                      _buildStatItem("Following", 89, () {
                        Navigator.pushNamed(context, '/following');
                      }),
                      _buildStatItem("Sent", 22, () {
                        Navigator.pushNamed(context, '/sent');
                      }),
                    ],
                  ),

                  const _VipPromoTile(),

                  // 🔸 Agency & Add Host Row
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/agency'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Column(
                              children: const [
                                Icon(Icons.business_center, color: Colors.red),
                                SizedBox(height: 6),
                                Text('Agency',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/addHost'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            margin: const EdgeInsets.only(left: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Column(
                              children: const [
                                Icon(Icons.record_voice_over,
                                    color: Colors.orange),
                                SizedBox(height: 6),
                                Text('Add host',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  const _ProfileTile(
                    icon: Icons.account_balance_wallet,
                    title: "Wallet",
                    titleColor: Colors.teal,
                    trailingText: '0',
                  ),
                  const _ProfileTile(
                    icon: Icons.monetization_on,
                    title: "Earn Money",
                    titleColor: Colors.indigo,
                  ),
                  const _ProfileTile(
                    icon: Icons.redeem,
                    title: "Get Rupees",
                    showDot: true,
                    titleColor: Colors.orange,
                  ),
                  const _ProfileTile(
                    icon: Icons.message,
                    title: "Messages",
                    badge: '11',
                    titleColor: Colors.purple,
                  ),
                  const _ProfileTile(
                    icon: Icons.task_alt,
                    title: "Task",
                    badge: "Check In",
                    titleColor: Colors.green,
                  ),
                  const _ProfileTile(
                    icon: Icons.emoji_events,
                    title: "Badge",
                    titleColor: Colors.pink,
                  ),
                  const _ProfileTile(
                    icon: Icons.security,
                    title: "Account Security",
                    titleColor: Colors.deepPurple,
                  ),
                  const _ProfileTile(
                    icon: Icons.settings,
                    title: "Settings",
                    titleColor: Colors.brown,
                  ),
                ],
              ),
            ),

            // 🔘 Go to Full Profile
            Positioned(
              top: 70,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/fullProfile');
                },
                child: const Icon(Icons.arrow_forward_ios,
                    size: 24, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🌟 Custom Tile
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
      trailing = Text(
        trailingText!,
        style: const TextStyle(fontWeight: FontWeight.bold),
      );
    } else if (showDot) {
      trailing = const CircleAvatar(radius: 4, backgroundColor: Colors.red);
    } else {
      trailing = const Icon(Icons.arrow_forward_ios,
          size: 14, color: Colors.grey);
    }

    return ListTile(
      leading: Icon(icon, color: titleColor ?? Colors.black),
      title: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.w500, color: Colors.black87),
      ),
      trailing: trailing,
      onTap: () {
        switch (title) {
          case 'Wallet':
            Navigator.pushNamed(context, '/wallet');
            break;
          case 'Earn Money':
            Navigator.pushNamed(context, '/earn');
            break;
          case 'Get Rupees':
            Navigator.pushNamed(context, '/getRupees');
            break;
          case 'Messages':
            Navigator.pushNamed(context, '/messages');
            break;
          case 'Task':
            Navigator.pushNamed(context, '/task');
            break;
          case 'Badge':
            Navigator.pushNamed(context, '/badge');
            break;
          case 'Account Security':
            Navigator.pushNamed(context, '/accountSecurity');
            break;
          case 'Settings':
            Navigator.pushNamed(context, '/settings');
            break;
        }
      },
    );
  }
}

// 🔶 VIP Promo Box
class _VipPromoTile extends StatelessWidget {
  const _VipPromoTile();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/vip'),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3CD),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.amber, width: 1.2),
        ),
        child: Row(
          children: const [
            Icon(Icons.star, color: Colors.amber),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Join Friends HUB VIP',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              'Join',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
