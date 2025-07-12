import 'package:flutter/material.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Streams'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,         // 2 columns
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 9 / 16,  // Portrait video layout
        ),
        itemCount: 12, // Temporary static 12 live cards
        itemBuilder: (context, index) {
          return LiveVideoCard(index: index);
        },
      ),
    );
  }
}

class LiveVideoCard extends StatelessWidget {
  final int index;
  const LiveVideoCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: AssetImage('assets/live_placeholder.jpg'), // Put dummy image in assets
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Row(
            children: [
              const Icon(Icons.remove_red_eye, size: 16, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                '${(index + 1) * 100} watching',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          right: 10,
          child: Row(
            children: [
              const CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage('assets/user.png'), // Dummy profile image
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Streamer ${index + 1}',
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
