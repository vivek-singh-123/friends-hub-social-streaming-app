import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gosh_app/screens/live_screen.dart'; // Still needed for LivePlayerScreen if a match leads to a live view

// A custom widget to display individual PK Match details
class PKMatchCard extends StatelessWidget {
  final String host1Name;
  final String host1Avatar;
  final String host2Name;
  final String host2Avatar;
  final int score1;
  final int score2;
  final String status; // e.g., "LIVE", "Upcoming", "Ended"
  final String? videoPath; // Optional: if tapping leads to a live stream

  const PKMatchCard({
    super.key,
    required this.host1Name,
    required this.host1Avatar,
    required this.host2Name,
    required this.host2Avatar,
    required this.score1,
    required this.score2,
    required this.status,
    this.videoPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (videoPath != null && status == "LIVE") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LivePlayerScreen(videoPath: videoPath!),
            ),
          );
        } else if (status == "Upcoming") {
          // Show a message or navigate to a waiting screen
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Match with $host1Name vs $host2Name is Upcoming!')),
          );
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Host 1 Info
                Expanded(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(host1Avatar),
                        backgroundColor: Colors.grey.shade200,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        host1Name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // VS / Score
                Column(
                  children: [
                    Text(
                      '$score1 - $score2',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: status == "LIVE" ? Colors.red : Colors.black87,
                      ),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 14,
                        color: status == "LIVE" ? Colors.red : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                // Host 2 Info
                Expanded(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(host2Avatar),
                        backgroundColor: Colors.grey.shade200,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        host2Name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (status == "LIVE") ...[
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: (score1 + score2) / 200.0, // Example progress based on score
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                borderRadius: BorderRadius.circular(10), // Added borderRadius
              ),
              const SizedBox(height: 8),
              Text(
                'Match in Progress',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
            if (status == "Upcoming") ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Tap to Set Reminder',
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
            if (status == "Ended") ...[
              const SizedBox(height: 12),
              Text(
                'Match Ended',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class PKMatchesScreen extends StatelessWidget {
  // Removed 'const' from the constructor
  const PKMatchesScreen({super.key});

  // Dummy data for PK Matches - using existing thumb assets
  final List<Map<String, dynamic>> pkMatchesData = const [
    {
      'host1Name': 'Riya',
      'host1Avatar': 'assets/live_thumbnails/thumb1.jpg', // Using existing assets
      'host2Name': 'Priya',
      'host2Avatar': 'assets/live_thumbnails/thumb2.jpg',
      'score1': 120,
      'score2': 85,
      'status': 'LIVE',
      'videoPath': 'assets/live_videos/live1.mp4',
    },
    {
      'host1Name': 'Amit',
      'host1Avatar': 'assets/live_thumbnails/thumb3.jpg',
      'host2Name': 'Sumit',
      'host2Avatar': 'assets/live_thumbnails/thumb4.jpg',
      'score1': 0,
      'score2': 0,
      'status': 'Upcoming',
      'videoPath': null,
    },
    {
      'host1Name': 'Neha',
      'host1Avatar': 'assets/live_thumbnails/thumb5.jpg',
      'host2Name': 'Karan',
      'host2Avatar': 'assets/live_thumbnails/thumb6.jpg',
      'score1': 210,
      'score2': 190,
      'status': 'LIVE',
      'videoPath': 'assets/live_videos/live2.mp4',
    },
    {
      'host1Name': 'Anjali',
      'host1Avatar': 'assets/live_thumbnails/thumb7.jpg',
      'host2Name': 'Rahul',
      'host2Avatar': 'assets/live_thumbnails/thumb8.jpg',
      'score1': 300,
      'score2': 250,
      'status': 'Ended',
      'videoPath': null,
    },
    {
      'host1Name': 'Vikram',
      'host1Avatar': 'assets/live_thumbnails/thumb1.jpg',
      'host2Name': 'Sonia',
      'host2Avatar': 'assets/live_thumbnails/thumb2.jpg',
      'score1': 0,
      'score2': 0,
      'status': 'Upcoming',
      'videoPath': null,
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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'PK Matches',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: pkMatchesData.length,
        itemBuilder: (context, index) {
          final match = pkMatchesData[index];
          return PKMatchCard(
            host1Name: match['host1Name'],
            host1Avatar: match['host1Avatar'],
            host2Name: match['host2Name'],
            host2Avatar: match['host2Avatar'],
            score1: match['score1'],
            score2: match['score2'],
            status: match['status'],
            videoPath: match['videoPath'],
          );
        },
      ),
    );
  }
}
