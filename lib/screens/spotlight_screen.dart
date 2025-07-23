import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gosh_app/screens/live_screen.dart'; // Still needed for LivePlayerScreen if spotlight content links to a live view

// A custom widget to display individual Spotlight Content details
class SpotlightCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String featuredPerson;
  final String featuredPersonAvatar;
  final String tag; // e.g., "Trending", "Featured", "Event"
  final String? liveVideoPath; // Optional: if tapping leads to a live stream

  const SpotlightCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.featuredPerson,
    required this.featuredPersonAvatar,
    required this.tag,
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Viewing Spotlight: $title')),
          );
          // You could navigate to a detailed spotlight page here
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.orangeAccent.withOpacity(0.15), // Spotlight themed shadow
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(color: Colors.orange.shade200, width: 1.5), // Added a subtle border
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Spotlight Image/Thumbnail
            Stack( // Use Stack to overlay LIVE tag if needed
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    imageUrl,
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 220,
                        color: Colors.grey.shade300,
                        child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                      );
                    },
                  ),
                ),
                if (liveVideoPath != null)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'LIVE',
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(featuredPersonAvatar),
                        backgroundColor: Colors.grey.shade200,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            featuredPerson,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Featured Creator',
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (liveVideoPath != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LivePlayerScreen(videoPath: liveVideoPath!),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Viewing profile of $featuredPerson')),
                            );
                          }
                        },
                        icon: Icon(liveVideoPath != null ? Icons.play_arrow : Icons.person),
                        label: Text(liveVideoPath != null ? 'Watch Now' : 'View Profile'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        ),
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

class SpotlightScreen extends StatelessWidget {
  const SpotlightScreen({super.key});

  // Dummy data for Spotlight Content - Varied use of existing thumbnails
  final List<Map<String, dynamic>> spotlightData = const [
    {
      'title': 'Meet the Rising Star: Anika Sharma',
      'description': 'Anika\'s journey from a small town to a social media sensation. Discover her secrets to success!',
      'imageUrl': 'assets/live_thumbnails/thumb1.jpg', // Distinct thumbnail
      'featuredPerson': 'Anika Sharma',
      'featuredPersonAvatar': 'assets/live_thumbnails/thumb2.jpg',
      'tag': 'Featured Creator',
      'liveVideoPath': 'assets/live_videos/live1.mp4',
    },
    {
      'title': 'Exclusive: Behind the Scenes of GOSH LIVE Event',
      'description': 'Get an inside look at how we put together our biggest live event of the year. Unseen footage!',
      'imageUrl': 'assets/live_thumbnails/thumb3.jpg', // Distinct thumbnail
      'featuredPerson': 'GOSH Team',
      'featuredPersonAvatar': 'assets/live_thumbnails/thumb4.jpg',
      'tag': 'Special Event',
      'liveVideoPath': null,
    },
    {
      'title': 'Trending Challenge: #DanceFever',
      'description': 'Join the hottest dance challenge sweeping the nation! Show us your moves and win exciting prizes.',
      'imageUrl': 'assets/live_thumbnails/thumb5.jpg', // Distinct thumbnail
      'featuredPerson': 'Community',
      'featuredPersonAvatar': 'assets/live_thumbnails/thumb6.jpg',
      'tag': 'Trending Topic',
      'liveVideoPath': 'assets/live_videos/live3.mp4',
    },
    {
      'title': 'Creator Spotlight: The Art of Digital Painting',
      'description': 'Learn from the best! Master the techniques of digital art with our featured artist, Rohan.',
      'imageUrl': 'assets/live_thumbnails/thumb7.jpg', // Distinct thumbnail
      'featuredPerson': 'Rohan Verma',
      'featuredPersonAvatar': 'assets/live_thumbnails/thumb8.jpg',
      'tag': 'Skill Showcase',
      'liveVideoPath': null,
    },
    {
      'title': 'Live Interview: Top Gamer "ProPlayerX"',
      'description': 'Catch an exclusive live interview with the legendary gamer, ProPlayerX, discussing his strategies.',
      'imageUrl': 'assets/live_thumbnails/thumb1.jpg', // Reusing existing thumb, but for a new context
      'featuredPerson': 'ProPlayerX',
      'featuredPersonAvatar': 'assets/live_thumbnails/thumb5.jpg',
      'tag': 'Live Interview',
      'liveVideoPath': 'assets/live_videos/live2.mp4',
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
      backgroundColor: Colors.orange.shade50, // A distinct spotlight-like background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Spotlight', // Distinct title
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: spotlightData.length,
        itemBuilder: (context, index) {
          final item = spotlightData[index];
          return SpotlightCard(
            title: item['title'],
            description: item['description'],
            imageUrl: item['imageUrl'],
            featuredPerson: item['featuredPerson'],
            featuredPersonAvatar: item['featuredPersonAvatar'],
            tag: item['tag'],
            liveVideoPath: item['liveVideoPath'],
          );
        },
      ),
    );
  }
}
