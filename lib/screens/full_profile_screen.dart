import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/user_data.dart';
import '../utils/user_list_screen.dart';

class FullProfileScreen extends StatefulWidget {
  const FullProfileScreen({super.key});

  @override
  State<FullProfileScreen> createState() => _FullProfileScreenState();
}

class _FullProfileScreenState extends State<FullProfileScreen>
    with SingleTickerProviderStateMixin {
  File? _backgroundImage;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      setState(() {
        _backgroundImage = File(picked.path);
      });
    }
  }

  void _showImagePickerOptions() {
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
              _pickImage(ImageSource.gallery);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Take a Photo"),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
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
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    image: _backgroundImage != null
                        ? DecorationImage(
                      image: FileImage(_backgroundImage!),
                      fit: BoxFit.cover,
                    )
                        : const DecorationImage(
                      image:
                      AssetImage('assets/cover_placeholder.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 32,
                  right: 16,
                  child: GestureDetector(
                    onTap: _showImagePickerOptions,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.edit, color: Colors.black87),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -40,
                  left: 20,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: const CircleAvatar(
                      radius: 42,
                      backgroundImage:
                      AssetImage('assets/default_avatar.png'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Vivek Singh",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  const Text("ID 10639434"),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text("Post"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TabBar(
              controller: _tabController,
              labelColor: Colors.deepPurple,
              unselectedLabelColor: Colors.black54,
              indicatorColor: Colors.deepPurple,
              tabs: const [
                Tab(text: "Post"),
                Tab(text: "About"),
                Tab(text: "Favorites"),
                Tab(text: "Likes"),
              ],
            ),
            SizedBox(
              height: 250,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Center(child: Text("No posts yet")),
                  Center(child: Text("About Vivek Singh")),
                  Center(child: Text("No favorites added")),
                  Center(child: Text("No likes yet")),
                ],
              ),
            )
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
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
