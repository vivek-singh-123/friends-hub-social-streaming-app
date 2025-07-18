import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'package:google_fonts/google_fonts.dart'; // For consistent typography
import '../core/constant/constant.dart'; // For kPrimaryColor
import '../utils/user_data.dart'; // Assuming this contains followersList, etc.
import '../utils/user_list_screen.dart';
import 'package:flutter/foundation.dart'; // For debugPrint

class FullProfileScreen extends StatefulWidget {
  const FullProfileScreen({super.key});

  @override
  State<FullProfileScreen> createState() => _FullProfileScreenState();
}

class _FullProfileScreenState extends State<FullProfileScreen>
    with SingleTickerProviderStateMixin {
  File? _coverImage; // For the background image
  File? _profileImage; // For the circular profile picture
  late TabController _tabController;

  // User data loaded from preferences
  String _userName = "User Name"; // Default value
  String _userId = "ID 00000000"; // Default value

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadProfileData(); // Load all saved profile data when screen initializes
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Load saved profile data (images, name, etc.) from SharedPreferences
  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    // Load image paths
    final savedCoverImagePath = prefs.getString('cover_image_path');
    final savedProfileImagePath = prefs.getString('profile_image_path');

    if (savedCoverImagePath != null && File(savedCoverImagePath).existsSync()) {
      setState(() {
        _coverImage = File(savedCoverImagePath);
      });
    }
    if (savedProfileImagePath != null && File(savedProfileImagePath).existsSync()) {
      setState(() {
        _profileImage = File(savedProfileImagePath);
      });
    }

    // Load user name
    final savedUserName = prefs.getString('user_name');
    if (savedUserName != null && savedUserName.isNotEmpty) {
      setState(() {
        _userName = savedUserName;
      });
    } else {
      debugPrint('FullProfileScreen: No user name found in SharedPreferences. Using default.');
    }

    // You can load other data here as well, e.g., user ID if you save it
    // final savedUserId = prefs.getString('user_id');
    // if (savedUserId != null && savedUserId.isNotEmpty) {
    //   setState(() {
    //     _userId = 'ID $savedUserId';
    //   });
    // }
  }

  // Pick image for the cover photo
  Future<void> _pickCoverImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      setState(() {
        _coverImage = File(picked.path);
      });
      // Save the new cover image path
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cover_image_path', picked.path);
    }
  }

  // Pick image for the profile picture (This method is no longer directly used by an edit icon on the profile picture)
  Future<void> _pickProfileImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });
      // Save the new profile image path
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_path', picked.path);
    }
  }

  // Options for picking images (gallery/camera)
  void _showImagePickerOptions(Function(ImageSource) onPick) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text("Choose from Gallery"),
            onTap: () {
              Navigator.pop(context);
              onPick(ImageSource.gallery);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Take a Photo"),
            onTap: () {
              Navigator.pop(context);
              onPick(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }

  void _navigateToList(String title, List<String> list) async {
    final updatedList = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserListScreen(title: title, users: List.from(list)),
      ),
    );

    if (updatedList != null && updatedList is List<String>) {
      setState(() {
        if (title == "Followers") {
          followersList = updatedList;
        } else if (title == "Following") {
          followingList = updatedList;
        } else if (title == "Sent") {
          sentList = updatedList;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none, // Allows children to overflow
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    image: _coverImage != null
                        ? DecorationImage(
                      image: FileImage(_coverImage!),
                      fit: BoxFit.cover,
                    )
                        : const DecorationImage(
                      image: AssetImage('assets/cover_placeholder.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // 🔙 Back Button (Top Left)
                Positioned(
                  top: 32,
                  left: 16,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8), // Larger tap area
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child:
                      const Icon(Icons.arrow_back, color: Colors.black87),
                    ),
                  ),
                ),

                // ✏️ Edit Cover Button (Top Right) - This is for the cover photo
                Positioned(
                  top: 32,
                  right: 16,
                  child: GestureDetector(
                    onTap: () => _showImagePickerOptions(_pickCoverImage),
                    child: Container(
                      padding: const EdgeInsets.all(8), // Larger tap area
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.edit, color: Colors.black87),
                    ),
                  ),
                ),

                // 👤 Profile Picture (Edit icon removed from here)
                Positioned(
                  bottom: -50, // Adjusted to overlap more
                  left: 20, // Adjusted for better alignment
                  child: Container( // White border around profile picture
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 50, // Slightly larger
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : const AssetImage('assets/default_avatar.png')
                      as ImageProvider,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60), // Space for the profile picture to sit in

            // 📦 Profile Box
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20), // Increased padding
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8, // More blur
                    offset: Offset(0, 4), // More offset
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    _userName, // Use state variable
                    style: GoogleFonts.poppins( // Use GoogleFonts
                        fontSize: 24, // Larger
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 6), // Increased spacing
                  Text(
                    _userId, // Use state variable
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]), // Styled
                  ),
                  const SizedBox(height: 20), // Increased spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem("Followers", followersList.length, () {
                        _navigateToList("Followers", followersList);
                      }),
                      _buildStatItem("Following", followingList.length, () {
                        _navigateToList("Following", followingList);
                      }),
                      _buildStatItem("Sent", sentList.length, () {
                        _navigateToList("Sent", sentList);
                      }),
                    ],
                  ),
                  const SizedBox(height: 20), // Increased spacing
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add, size: 20), // Larger icon
                    label: Text("Post", style: GoogleFonts.poppins(fontSize: 16)), // Styled text
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple, // Consistent color
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // More rounded
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14), // Larger padding
                      elevation: 4, // Subtle shadow
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 📌 Tabs
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.deepPurple,
                    unselectedLabelColor: Colors.black54,
                    indicatorColor: Colors.deepPurple,
                    labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15),
                    unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
                    tabs: const [
                      Tab(text: "Post"),
                      Tab(text: "About"),
                      Tab(text: "Favorites"),
                      Tab(text: "Likes"),
                    ],
                  ),
                  Divider(height: 1, color: Colors.grey[300]), // Visual separator

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35, // Dynamic height
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Center(child: Text("No posts yet", style: GoogleFonts.poppins(color: Colors.grey[700]))),
                        Center(child: Text("About Vivek Singh", style: GoogleFonts.poppins(color: Colors.grey[700]))),
                        Center(child: Text("No favorites added", style: GoogleFonts.poppins(color: Colors.grey[700]))),
                        Center(child: Text("No likes yet", style: GoogleFonts.poppins(color: Colors.grey[700]))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Extra space at the bottom
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, int value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            '$value',
            style: GoogleFonts.poppins( // Use GoogleFonts
                fontWeight: FontWeight.bold,
                fontSize: 18, // Slightly larger
                color: Colors.black),
          ),
          const SizedBox(height: 6), // Increased spacing
          Text(
            label,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87), // Slightly larger
          ),
        ],
      ),
    );
  }
}

// _ProfileTile and _VipPromoTile remain unchanged from your original code
// as they are not directly part of the FullProfileScreen's main layout.
// If you want to use them, ensure they are defined in their respective files
// or included here.
// For this response, I'm assuming they are separate widgets or you'd include them.

// For demonstration purposes, assuming kPrimaryColor is defined elsewhere
// If not, you might need to define it or replace with a direct color value.
// const Color kPrimaryColor = Colors.orange; // Example if not defined in constant.dart
