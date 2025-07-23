import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'discover_search_screen.dart';

// Import your newly created separate category screens
import 'freshers_screen.dart';
import 'popular_screen.dart';
import 'spotlight_screen.dart';
import 'party_screen.dart';
import 'pk_matches_screen.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  final List<String> categories = ["Freshers", "Popular", "Spotlight", "Party", "PK Matches"];

  final List<String> defaultLiveScreenVideoPaths = List.generate(
    8,
        (index) => 'assets/live_videos/live${index + 1}.mp4', // Default videos for the main LiveScreen
  );

  // Default thumbnails and view counts for the main LiveScreen
  final List<String> defaultThumbnails = [
    'assets/live_thumbnails/thumb1.jpg',
    'assets/live_thumbnails/thumb2.jpg',
    'assets/live_thumbnails/thumb3.jpg',
    'assets/live_thumbnails/thumb4.jpg',
    'assets/live_thumbnails/thumb5.jpg',
    'assets/live_thumbnails/thumb6.jpg',
    'assets/live_thumbnails/thumb7.jpg',
    'assets/live_thumbnails/thumb8.jpg',
  ];

  final List<String> defaultViewCounts = [
    "3.7K", "13K", "12K", "17.6K", "5.1K", "4.3K", "8.9K", "1.2K"
  ];


  // This method will directly handle navigation to the respective screen
  void navigateToCategoryScreen(int index) {
    Widget screen;
    switch (index) {
      case 0:
        screen = const FreshersScreen();
        break;
      case 1:
        screen = const PopularScreen();
        break;
      case 2:
        screen = const SpotlightScreen();
        break;
      case 3:
        screen = const PartyScreen();
        break;
      case 4:
        screen = const PKMatchesScreen();
        break;
      default:
        screen = const PopularScreen(); // Fallback
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // 🔷 Top Row: Categories and Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                children: [
                  // ⬅️ Scrollable Categories (Chips/Pills)
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(categories.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: OutlinedButton(
                              onPressed: () => navigateToCategoryScreen(index),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black87,
                                side: BorderSide(color: Colors.grey.shade300, width: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                backgroundColor: Colors.white,
                                elevation: 1,
                                shadowColor: Colors.grey.withOpacity(0.1),
                              ),
                              child: Text(
                                categories[index],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // 🔍 Fixed Discover Search Bar (now with emoji)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const DiscoverSearchScreen()),
                      );
                    },
                    child: Container(
                      width: 45, // Adjusted width for just an emoji
                      height: 45, // Adjusted height for just an emoji
                      padding: const EdgeInsets.symmetric(horizontal: 0), // No horizontal padding needed
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(25), // Keep it rounded
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Text( // Using Text widget for emoji
                        '🔍', // Search emoji
                        style: TextStyle(fontSize: 26), // Adjust font size for emoji
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🔷 Grid of Live Cards (This is the default content for the LiveScreen itself)
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 9 / 14,
                ),
                itemCount: defaultLiveScreenVideoPaths.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              LivePlayerScreen(videoPath: defaultLiveScreenVideoPaths[index]),
                        ),
                      );
                    },
                    // Pass default thumbnails and view counts to LiveVideoCard
                    child: LiveVideoCard(
                      index: index,
                      thumbnails: defaultThumbnails,
                      viewCounts: defaultViewCounts,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// MODIFIED LiveVideoCard to accept thumbnails and viewCounts
class LiveVideoCard extends StatelessWidget {
  final int index;
  final List<String> thumbnails; // Now a required parameter
  final List<String> viewCounts; // Now a required parameter

  const LiveVideoCard({
    super.key,
    required this.index,
    required this.thumbnails, // Added to constructor
    required this.viewCounts, // Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    // Use the passed lists instead of internal hardcoded ones
    final String thumbnail = thumbnails[index % thumbnails.length];
    final String views = viewCounts[index % viewCounts.length];

    return Container( // Wrap with Container to add shadow
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [ // Add subtle shadow to the card
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect( // Clip the image to the rounded corners
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.asset( // Use Image.asset directly here
              thumbnail,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),

            // Optional: A subtle gradient overlay for better text contrast
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.3),
                    ],
                    stops: const [0.6, 0.8, 1.0],
                  ),
                ),
              ),
            ),

            // 🟢 LIVE tag
            Positioned(
              bottom: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green[600],
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [ // Subtle shadow for the LIVE tag
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Text(
                  "LIVE",
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // 🔥 Views
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [ // Subtle shadow for the views tag
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.whatshot, color: Colors.orangeAccent, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      views,
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LivePlayerScreen extends StatefulWidget {
  final String videoPath;
  const LivePlayerScreen({super.key, required this.videoPath});

  @override
  State<LivePlayerScreen> createState() => _LivePlayerScreenState();
}

class _LivePlayerScreenState extends State<LivePlayerScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));

    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void togglePlayPause() {
    setState(() {
      _isPlaying ? _controller.pause() : _controller.play();
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Live Stream', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? GestureDetector(
          onTap: togglePlayPause,
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        )
            : const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
