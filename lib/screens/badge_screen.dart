import 'package:flutter/material.dart';

class BadgeScreen extends StatelessWidget {
  const BadgeScreen({super.key});

  final List<Map<String, dynamic>> badges = const [
    {'icon': Icons.star, 'title': 'Rising Star', 'description': 'Awarded for consistent daily activity.'},
    {'icon': Icons.live_tv, 'title': 'Live Master', 'description': 'Earned after 100 successful live streams.'},
    {'icon': Icons.favorite, 'title': 'Fan Favorite', 'description': 'Given by fans for your popularity.'},
    {'icon': Icons.lock_open, 'title': 'Unlocked Creator', 'description': 'Unlocked after verifying your profile.'},
    {'icon': Icons.verified, 'title': 'Verified Host', 'description': 'Official verification badge.'},
    {'icon': Icons.emoji_events, 'title': 'Top Earner', 'description': 'Ranked in the top 5% of earners.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Badges')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: badges.length,
        itemBuilder: (context, index) {
          final badge = badges[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: Icon(badge['icon'], size: 32, color: Colors.amber),
              title: Text(badge['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(badge['description']),
              trailing: const Icon(Icons.check_circle, color: Colors.green),
            ),
          );
        },
      ),
    );
  }
}
