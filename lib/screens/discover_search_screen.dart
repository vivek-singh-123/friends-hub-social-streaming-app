import 'package:flutter/material.dart';

class DiscoverSearchScreen extends StatelessWidget {
  const DiscoverSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final trendingTags = [
      "#Flutter",
      "#LiveNow",
      "#AI",
      "#FriendsHUBTrending",
      "#Explore",
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Discover',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search Input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const TextField(
                style: TextStyle(color: Colors.black), // 🔽 makes typed text black
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search users or videos...',
                  hintStyle: TextStyle(color: Colors.grey), // 🔽 keeps hint gray
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Trending Searches',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // 🔥 Trending Tags
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: trendingTags.map((tag) {
                return Chip(
                  label: Text(
                    tag,
                    style: const TextStyle(color: Colors.black), // ✅ explicitly black
                  ),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                );
              }).toList(),
            ),

            const Spacer(),

            const Center(
              child: Text(
                'Results will appear here',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
