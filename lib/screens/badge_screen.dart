import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

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
      backgroundColor: const Color(0xFFF0F2F5), // Light grey background
      appBar: AppBar(
        title: Text(
          'My Badges',
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600), // White text for orange app bar
        ),
        backgroundColor: Colors.orange.shade700, // Changed to orange
        foregroundColor: Colors.white, // Ensures icons are white
        elevation: 4, // Add some shadow
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16), // Consistent padding
        itemCount: badges.length,
        itemBuilder: (context, index) {
          final badge = badges[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8), // Adjusted vertical margin
            elevation: 2, // Subtle shadow for the card
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Rounded corners for cards
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Adjusted padding inside ListTile
              leading: Icon(
                badge['icon'],
                size: 36, // Slightly larger icon
                color: Colors.amber.shade700, // Darker amber color
              ),
              title: Text(
                badge['title'],
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black87), // Styled title
              ),
              subtitle: Text(
                badge['description'],
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600]), // Styled subtitle
              ),
              trailing: Icon(Icons.check_circle, color: Colors.green.shade700), // Darker green checkmark
            ),
          );
        },
      ),
    );
  }
}