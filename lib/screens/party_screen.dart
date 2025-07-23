import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gosh_app/screens/live_screen.dart'; // Still needed for LivePlayerScreen if joining a party leads to a live view

// A custom widget to display individual Party Room details
class PartyRoomCard extends StatelessWidget {
  final String roomName;
  final String hostName;
  final String hostAvatar;
  final List<String> participantAvatars; // Avatars of a few participants
  final String participantCount;
  final bool isLive;
  final String? liveVideoPath; // Optional: if joining leads to a live stream

  const PartyRoomCard({
    super.key,
    required this.roomName,
    required this.hostName,
    required this.hostAvatar,
    required this.participantAvatars,
    required this.participantCount,
    required this.isLive,
    this.liveVideoPath,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the width needed for the overlapping avatars
    // Each avatar is radius 15, so diameter is 30. Overlap by 10.
    // (Number of avatars * diameter) - (Number of overlaps * overlap amount)
    final double avatarsWidth = (participantAvatars.length * 30.0) -
        (participantAvatars.isNotEmpty ? (participantAvatars.length - 1) * 10.0 : 0.0);

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
            SnackBar(content: Text('Match with $roomName is Upcoming/Ended!')),
          );
          // You could navigate to a specific party room details screen here
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
              color: Colors.deepOrange.withOpacity(0.1), // Party themed shadow
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isLive ? Colors.redAccent : Colors.transparent, // Highlight live parties
            width: isLive ? 2 : 0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  roomName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                ),
                if (isLive)
                  Container(
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
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(hostAvatar),
                  backgroundColor: Colors.grey.shade200,
                  onBackgroundImageError: (exception, stackTrace) {
                    // Fallback if host avatar image fails to load
                    debugPrint('Error loading host avatar: $exception');
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  'Hosted by $hostName',
                  style: TextStyle(color: Colors.grey[700], fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // Wrap the Stack in a SizedBox to give it finite width
                SizedBox(
                  width: avatarsWidth, // Use the calculated width
                  height: 30, // Fixed height for the avatars (2 * radius)
                  child: Stack(
                    children: List.generate(
                      participantAvatars.length,
                          (index) {
                        final avatarPath = participantAvatars[index];
                        return Positioned(
                          left: (index * 20).toDouble(), // Overlap avatars
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage: avatarPath.isNotEmpty
                                ? AssetImage(avatarPath)
                                : null,
                            backgroundColor: Colors.grey.shade300,
                            onBackgroundImageError: (exception, stackTrace) {
                              debugPrint('Error loading participant avatar: $exception');
                            },
                            child: avatarPath.isEmpty
                                ? const Icon(Icons.person, size: 20, color: Colors.white)
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Fixed spacing after avatars
                Text(
                  '$participantCount Participants',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (isLive && liveVideoPath != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LivePlayerScreen(videoPath: liveVideoPath!),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Attempting to join $roomName...')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLive ? Colors.deepOrange : Colors.grey, // Active if live
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  elevation: 5,
                ),
                child: Text(isLive ? 'Join Party' : 'Party Ended / Offline'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PartyScreen extends StatelessWidget {
  const PartyScreen({super.key});

  // Dummy data for Party Rooms
  final List<Map<String, dynamic>> partyRoomsData = const [
    {
      'roomName': 'Weekend Rave',
      'hostName': 'DJ Spark',
      'hostAvatar': 'assets/live_thumbnails/thumb1.jpg', // Use existing thumbnails
      'participantAvatars': [
        'assets/live_thumbnails/thumb2.jpg',
        'assets/live_thumbnails/thumb3.jpg',
        'assets/live_thumbnails/thumb4.jpg',
      ],
      'participantCount': '5.3K',
      'isLive': true,
      'liveVideoPath': 'assets/live_videos/live1.mp4',
    },
    {
      'roomName': 'Chillout Lounge',
      'hostName': 'Vibe Master',
      'hostAvatar': 'assets/live_thumbnails/thumb5.jpg',
      'participantAvatars': [
        'assets/live_thumbnails/thumb6.jpg',
        'assets/live_thumbnails/thumb7.jpg',
      ],
      'participantCount': '1.8K',
      'isLive': true,
      'liveVideoPath': 'assets/live_videos/live2.mp4',
    },
    {
      'roomName': 'Bollywood Night',
      'hostName': 'Host Queen',
      'hostAvatar': 'assets/live_thumbnails/thumb8.jpg',
      'participantAvatars': [
        'assets/live_thumbnails/thumb1.jpg',
        'assets/live_thumbnails/thumb2.jpg',
        'assets/live_thumbnails/thumb3.jpg',
      ],
      'participantCount': '8.1K',
      'isLive': false, // Party ended or upcoming
      'liveVideoPath': null,
    },
    {
      'roomName': 'Karaoke Fun',
      'hostName': 'Sing Along',
      'hostAvatar': 'assets/live_thumbnails/thumb4.jpg',
      'participantAvatars': [
        'assets/live_thumbnails/thumb5.jpg',
        'assets/live_thumbnails/thumb6.jpg',
      ],
      'participantCount': '3.2K',
      'isLive': true,
      'liveVideoPath': 'assets/live_videos/live4.mp4',
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
      backgroundColor: Colors.purple.shade50, // A distinct party-like background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Party Rooms', // Distinct title
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: partyRoomsData.length,
        itemBuilder: (context, index) {
          final party = partyRoomsData[index];
          return PartyRoomCard(
            roomName: party['roomName'],
            hostName: party['hostName'],
            hostAvatar: party['hostAvatar'],
            participantAvatars: List<String>.from(party['participantAvatars']), // Cast to List<String>
            participantCount: party['participantCount'],
            isLive: party['isLive'],
            liveVideoPath: party['liveVideoPath'],
          );
        },
      ),
    );
  }
}
