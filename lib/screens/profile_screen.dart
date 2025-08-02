import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gosh_app/core/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  String _userName = "User Name";

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    final imagePath = prefs.getString('profile_image_path');
    debugPrint('ProfileScreen: Attempting to load image from path: $imagePath');

    if (imagePath != null) {
      final imageFile = File(imagePath);
      if (await imageFile.exists()) {
        setState(() {
          _image = imageFile;
        });
        debugPrint('ProfileScreen: Image loaded successfully from path: $imagePath');
      } else {
        debugPrint('ProfileScreen: Image file does not exist at path: $imagePath');
        await prefs.remove('profile_image_path');
      }
    } else {
      debugPrint('ProfileScreen: No image path found in SharedPreferences.');
    }

    final savedUserName = prefs.getString('user_name');
    if (savedUserName != null && savedUserName.isNotEmpty) {
      setState(() {
        _userName = savedUserName;
      });
      debugPrint('ProfileScreen: User name loaded: $savedUserName');
    } else {
      debugPrint('ProfileScreen: No user name found in SharedPreferences. Using default.');
    }
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_path', picked.path);
      debugPrint('ProfileScreen: New image picked and saved to path: ${picked.path}');
    } else {
      debugPrint('ProfileScreen: Image picking cancelled.');
    }
  }

  Widget _buildStatItem(String label, int value, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Column(
              children: [
                Text(
                  '$value',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
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
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 48,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: _image != null
                                  ? FileImage(_image!)
                                  : const AssetImage('assets/default_avatar.png')
                              as ImageProvider,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kPrimaryColor,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: const Icon(Icons.edit,
                                    size: 18, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userName,
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap: () async {
                              await Navigator.pushNamed(context, '/editProfile');
                              _loadProfileData();
                            },
                            child: Text(
                              "Tap to edit bio",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 30),

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

                  const SizedBox(height: 24),

                  const _VipPromoTile(),

                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/agency'),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            margin: const EdgeInsets.only(right: 8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Column(
                                children: [
                                  Icon(Icons.business_center,
                                      color: kPrimaryColor, size: 28),
                                  const SizedBox(height: 8),
                                  Text('Agency',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                          fontSize: 15)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/addHost'),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            margin: const EdgeInsets.only(left: 8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Column(
                                children: [
                                  Icon(Icons.record_voice_over,
                                      color: kPrimaryColor, size: 28),
                                  const SizedBox(height: 8),
                                  Text('Add host',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                          fontSize: 15)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildProfileTile(Icons.account_balance_wallet, "Wallet",
                      trailingText: '0'),
                  _buildProfileTile(Icons.monetization_on, "Earn Money"),
                  _buildProfileTile(Icons.emoji_events, "Badge"),
                  _buildProfileTile(Icons.security, "Account Security"),
                  _buildProfileTile(Icons.settings, "Settings"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title,
      {String? trailingText, String? badge, bool showDot = false}) {
    Widget trailing;

    if (badge != null) {
      trailing = Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(badge,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 13)),
      );
    } else if (trailingText != null) {
      trailing = Text(
        trailingText,
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 14),
      );
    } else if (showDot) {
      trailing = CircleAvatar(radius: 4, backgroundColor: kPrimaryColor);
    } else {
      trailing = const Icon(Icons.arrow_forward_ios,
          size: 16, color: Colors.grey);
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(icon, color: kPrimaryColor, size: 26),
        title: Text(
          title,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 16),
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
      ),
    );
  }
}

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
          border: Border.all(color: kPrimaryColor, width: 1.2),
        ),
        child: Row(
          children: [
            Icon(Icons.star, color: kPrimaryColor, size: 24),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Join Friends HUB VIP',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              'Join',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}