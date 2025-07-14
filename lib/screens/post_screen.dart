import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late VideoPlayerController _controller;
  int likes = 0;
  bool isLiked = false;
  final List<String> comments = [];
  bool _showUI = true;
  bool _autoplay = true;
  double _playbackSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/video1.mp4')
      ..initialize().then((_) {
        setState(() {});
        if (_autoplay) _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likes += isLiked ? 1 : -1;
    });
  }

  void _openCommentSheet() {
    final TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return StatefulBuilder(
              builder: (context, setModalState) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Comments', style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const CircleAvatar(
                                radius: 16,
                                backgroundImage: AssetImage('assets/default_avatar.png'),
                              ),
                              title: Text(comments[index], style: const TextStyle(color: Colors.white)),
                            );
                          },
                        ),
                      ),
                      const Divider(color: Colors.grey),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: commentController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Write a comment...',
                                  hintStyle: const TextStyle(color: Colors.white54),
                                  filled: true,
                                  fillColor: Colors.grey[850],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.send, color: Colors.green),
                              onPressed: () {
                                String comment = commentController.text.trim();
                                if (comment.isNotEmpty) {
                                  setModalState(() {
                                    comments.add(comment);
                                    commentController.clear();
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _shareReel() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Share with', style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _shareIcon('WhatsApp', 'assets/icons/whatsapp.png'),
              _shareIcon('Snapchat', 'assets/icons/snapchat.png'),
              _shareIcon('Instagram', 'assets/icons/instagram.png'),
              _shareIcon('Facebook', 'assets/icons/facebook.png'),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _shareIcon(String name, String assetPath) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Shared on $name')),
            );
          },
          child: CircleAvatar(
            backgroundImage: AssetImage(assetPath),
            radius: 30,
            backgroundColor: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 6),
        Text(name, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  void _showSpeedDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text("Playback Speed", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [0.5, 1.0, 1.5, 2.0].map((speed) {
            return ListTile(
              title: Text('${speed}x', style: const TextStyle(color: Colors.white)),
              onTap: () {
                setState(() {
                  _playbackSpeed = speed;
                  _controller.setPlaybackSpeed(speed);
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showOptionsMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _optionItem("Share", Icons.share, _shareReel),
          _optionItem("Speed", Icons.speed, _showSpeedDialog),
          _optionItem("Clear Screen", Icons.cleaning_services, () {
            setState(() => _showUI = !_showUI);
            Navigator.pop(context);
          }),
          _optionItem("Autoplay (${_autoplay ? 'On' : 'Off'})", Icons.play_circle, () {
            setState(() => _autoplay = !_autoplay);
            Navigator.pop(context);
          }),
          _optionItem("Not Interested", Icons.thumb_down, () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("We'll show fewer videos like this.")),
            );
          }),
          _optionItem("Report", Icons.flag, () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Reported. Our team will review it.")),
            );
          }),
        ],
      ),
    );
  }

  ListTile _optionItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _controller.value.isInitialized
          ? Stack(
        children: [
          // ✅ Video background with tap to pause/play
          GestureDetector(
            onTap: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              });
            },
            child: SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
          ),

          // Right side icons
          if (_showUI)
            Positioned(
              bottom: 120,
              right: 16,
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.white,
                      size: 30,
                    ),
                    onPressed: _toggleLike,
                  ),
                  Text('$likes', style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 16),
                  IconButton(
                    icon: const Icon(Icons.comment, color: Colors.white, size: 30),
                    onPressed: _openCommentSheet,
                  ),
                  const SizedBox(height: 16),
                  IconButton(
                    icon: const Icon(Icons.share, color: Colors.white, size: 30),
                    onPressed: _shareReel,
                  ),
                  const SizedBox(height: 16),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.white, size: 30),
                    onPressed: _showOptionsMenu,
                  ),
                ],
              ),
            ),

          // Creator Info & Caption
          if (_showUI)
            Positioned(
              bottom: 10,
              left: 16,
              right: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/creatorProfile'),
                    child: Row(
                      children: const [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: AssetImage('assets/user.png'),
                        ),
                        SizedBox(width: 8),
                        Text('@reel_creator',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "This is an awesome reel! 🎉🔥",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
        ],
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
