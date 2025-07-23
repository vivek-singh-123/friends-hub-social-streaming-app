import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gosh_app/screens/live_screen.dart'; // Still needed for LivePlayerScreen if a profile links to a live view

// A custom widget to display individual Fresher Profile details
class FresherProfileCard extends StatelessWidget {
  final String name;
  final String avatar;
  final String bio;
  final String followers;
  final String? liveVideoPath; // Optional: if the fresher is currently live

  const FresherProfileCard({
    super.key,
    required this.name,
    required this.avatar,
    required this.bio,
    required this.followers,
    this.liveVideoPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (liveVideoPath != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LivePlayerScreen(videoPath: liveVideoPath!),
            ),
          );
        } else {
          // You can navigate to a full profile page here, or show a message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Viewing profile of $name')),
          );
          // Example: Navigator.push(context, MaterialPageRoute(builder: (_) => FullProfileScreen(userName: name)));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(avatar),
                  backgroundColor: Colors.grey.shade200,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        bio,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$followers Followers',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  children: [
                    if (liveVideoPath != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'LIVE',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Offline',
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Following $name')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      ),
                      child: const Text('Follow'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FreshersScreen extends StatelessWidget {
  const FreshersScreen({super.key});

  // Dummy data for Freshers Profiles
  final List<Map<String, dynamic>> freshersData = const [
    {
      'name': 'Ananya Sharma',
      'avatar': 'assets/live_thumbnails/thumb1.jpg', // Using existing thumbnails
      'bio': 'Passionate dancer and aspiring content creator. Join my journey!',
      'followers': '1.2K',
      'liveVideoPath': 'assets/live_videos/live1.mp4', // Link to an existing video
    },
    {
      'name': 'Rahul Singh',
      'avatar': 'assets/live_thumbnails/thumb2.jpg',
      'bio': 'New to streaming, love gaming and chatting with my audience.',
      'followers': '850',
      'liveVideoPath': null, // Offline
    },
    {
      'name': 'Priya Devi',
      'avatar': 'assets/live_thumbnails/thumb3.jpg',
      'bio': 'Singer and musician, sharing my voice with the world.',
      'followers': '2.5K',
      'liveVideoPath': 'assets/live_videos/live3.mp4',
    },
    {
      'name': 'Vikram Kumar',
      'avatar': 'assets/live_thumbnails/thumb4.jpg',
      'bio': 'Fitness enthusiast and motivational speaker. Let\'s get fit!',
      'followers': '1.8K',
      'liveVideoPath': null,
    },
    {
      'name': 'Sneha Gupta',
      'avatar': 'assets/live_thumbnails/thumb5.jpg',
      'bio': 'Artist and vlogger, exploring creativity every day.',
      'followers': '980',
      'liveVideoPath': 'assets/live_videos/live5.mp4',
    },
    {
      'name': 'Arjun Reddy',
      'avatar': 'assets/live_thumbnails/thumb6.jpg',
      'bio': 'Tech reviewer and gadget lover. Stay tuned for cool stuff!',
      'followers': '1.1K',
      'liveVideoPath': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));

    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Slightly different background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Freshers',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: freshersData.length,
        itemBuilder: (context, index) {
          final fresher = freshersData[index];
          return FresherProfileCard(
            name: fresher['name'],
            avatar: fresher['avatar'],
            bio: fresher['bio'],
            followers: fresher['followers'],
            liveVideoPath: fresher['liveVideoPath'],
          );
        },
      ),
    );
  }
}
