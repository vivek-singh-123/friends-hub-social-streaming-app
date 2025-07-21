import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'discover_search_screen.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  final List<String> categories = ["Freshers", "Popular", "Spotlight", "Party", "PK Matches"];
  int selectedIndex = 1;

  final List<String> videoPaths = List.generate(
    8,
        (index) => 'assets/live_videos/live${index + 1}.mp4',
  );

  void onTabChanged(int index) {
    setState(() => selectedIndex = index);
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

            // 🔷 Top Row: Scrollable Tabs + Fixed Discover Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  // ⬅️ Scrollable Categories
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(categories.length, (index) {
                          final isSelected = selectedIndex == index;
                          return GestureDetector(
                            onTap: () => onTabChanged(index),
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.black : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.grey.shade300,
                                ),
                              ),
                              child: Text(
                                categories[index],
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // 🔍 Fixed Discover Bar
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const DiscoverSearchScreen()),
                      );
                    },
                    child: Container(
                      width: 75,
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.search, color: Colors.grey, size: 26),
                    ),
                  ),


                ],
              ),
            ),

            // 🔷 Grid of Live Cards
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 9 / 14,
                ),
                itemCount: videoPaths.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              LivePlayerScreen(videoPath: videoPaths[index]),
                        ),
                      );
                    },
                    child: LiveVideoCard(index: index),
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

class LiveVideoCard extends StatelessWidget {
  final int index;
  const LiveVideoCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final List<String> thumbnails = [
      'assets/live_thumbnails/thumb1.jpg',
      'assets/live_thumbnails/thumb2.jpg',
      'assets/live_thumbnails/thumb3.jpg',
      'assets/live_thumbnails/thumb4.jpg',
      'assets/live_thumbnails/thumb5.jpg',
      'assets/live_thumbnails/thumb6.jpg',
      'assets/live_thumbnails/thumb7.jpg',
      'assets/live_thumbnails/thumb8.jpg',
    ];

    final List<String> viewCounts = [
      "3.7K", "13K", "12K", "17.6K", "5.1K", "4.3K", "8.9K", "1.2K"
    ];

    final String thumbnail = thumbnails[index % thumbnails.length];
    final String views = viewCounts[index % viewCounts.length];

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(thumbnail),
              fit: BoxFit.cover,
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
            ),
            child: Row(
              children: [
                const Icon(Icons.whatshot, color: Colors.orangeAccent, size: 16),
                const SizedBox(width: 4),
                Text(
                  views,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
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
