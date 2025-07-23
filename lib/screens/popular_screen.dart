import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gosh_app/screens/live_screen.dart'; // Still needed for LivePlayerScreen if popular content links to a live view

// A custom widget to display individual Popular Content details
class PopularContentCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String creatorName;
  final String creatorAvatar;
  final String views;
  final String duration; // e.g., "3:45", "LIVE"
  final bool isLive;
  final String? liveVideoPath; // Optional: if tapping leads to a live stream

  const PopularContentCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.creatorName,
    required this.creatorAvatar,
    required this.views,
    required this.duration,
    required this.isLive,
    this.liveVideoPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isLive && liveVideoPath != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LivePlayerScreen(videoPath: liveVideoPath!),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Playing $title by $creatorName')),
          );
          // You could navigate to a detailed content view screen here
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.1), // Popular themed shadow
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Content Image/Thumbnail
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey.shade300,
                    child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(creatorAvatar),
                        backgroundColor: Colors.grey.shade200,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        creatorName,
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                      const Spacer(),
                      Text(
                        '$views views',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                      const SizedBox(width: 8),
                      if (isLive)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'LIVE',
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        )
                      else
                        Text(
                          duration,
                          style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopularScreen extends StatelessWidget {
  const PopularScreen({super.key});

  // Dummy data for Popular Content
  final List<Map<String, dynamic>> popularContentData = const [
    {
      'title': 'Top 10 Dance Moves of 2024',
      'imageUrl': 'assets/live_thumbnails/thumb1.jpg', // Use existing thumbnails
      'creatorName': 'DanceGuru',
      'creatorAvatar': 'assets/live_thumbnails/thumb2.jpg',
      'views': '1.5M',
      'duration': '8:30',
      'isLive': false,
      'liveVideoPath': null,
    },
    {
      'title': 'Morning Yoga Flow for Beginners',
      'imageUrl': 'assets/live_thumbnails/thumb3.jpg',
      'creatorName': 'ZenLife',
      'creatorAvatar': 'assets/live_thumbnails/thumb4.jpg',
      'views': '800K',
      'duration': 'LIVE',
      'isLive': true,
      'liveVideoPath': 'assets/live_videos/live1.mp4', // Link to an existing video
    },
    {
      'title': 'Cooking Challenge: MasterChef Edition',
      'imageUrl': 'assets/live_thumbnails/thumb5.jpg',
      'creatorName': 'FoodieFun',
      'creatorAvatar': 'assets/live_thumbnails/thumb6.jpg',
      'views': '2.1M',
      'duration': '12:15',
      'isLive': false,
      'liveVideoPath': null,
    },
    {
      'title': 'Live Q&A with a Celebrity Guest',
      'imageUrl': 'assets/live_thumbnails/thumb7.jpg',
      'creatorName': 'StarTalk',
      'creatorAvatar': 'assets/live_thumbnails/thumb8.jpg',
      'views': '3.5M',
      'duration': 'LIVE',
      'isLive': true,
      'liveVideoPath': 'assets/live_videos/live2.mp4',
    },
    {
      'title': 'Travel Vlog: Exploring Bali',
      'imageUrl': 'assets/live_thumbnails/thumb1.jpg',
      'creatorName': 'Wanderlust',
      'creatorAvatar': 'assets/live_thumbnails/thumb2.jpg',
      'views': '950K',
      'duration': '15:00',
      'isLive': false,
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
      backgroundColor: Colors.blue.shade50, // A distinct popular-like background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Popular Content', // Distinct title
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: popularContentData.length,
        itemBuilder: (context, index) {
          final content = popularContentData[index];
          return PopularContentCard(
            title: content['title'],
            imageUrl: content['imageUrl'],
            creatorName: content['creatorName'],
            creatorAvatar: content['creatorAvatar'],
            views: content['views'],
            duration: content['duration'],
            isLive: content['isLive'],
            liveVideoPath: content['liveVideoPath'],
          );
        },
      ),
    );
  }
}
