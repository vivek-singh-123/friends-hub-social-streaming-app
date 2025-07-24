import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class EarnMoneyScreen extends StatelessWidget {
  const EarnMoneyScreen({super.key});

  final List<Map<String, dynamic>> earnOptions = const [
    {
      'title': 'Refer & Earn',
      'description': 'Invite friends and earn ₹20 per sign-up!',
      'icon': Icons.share
    },
    {
      'title': 'Go Live',
      'description': 'Earn coins every minute while live streaming.',
      'icon': Icons.videocam
    },
    {
      'title': 'Daily Check-in',
      'description': 'Get rewards by checking in every day.',
      'icon': Icons.calendar_today
    },
    {
      'title': 'Complete Tasks',
      'description': 'Finish daily tasks to get bonus coins.',
      'icon': Icons.check_circle
    },
    {
      'title': 'Invite Creators',
      'description': 'Bring new creators and earn bonus money.',
      'icon': Icons.group_add
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5), // Light grey background
      appBar: AppBar(
        title: Text(
          'Earn Money',
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600), // White text for orange app bar
        ),
        backgroundColor: Colors.orange.shade700, // Changed to orange
        foregroundColor: Colors.white, // Ensures icons are white
        elevation: 4, // Add some shadow
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: earnOptions.length,
        padding: const EdgeInsets.all(16), // Consistent padding
        itemBuilder: (context, index) {
          final option = earnOptions[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8), // Adjusted vertical margin
            elevation: 2, // Subtle shadow for the card
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Rounded corners for cards
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Adjusted padding inside ListTile
              leading: CircleAvatar(
                backgroundColor: Colors.orange.shade100, // Orange themed background
                radius: 24, // Slightly larger avatar
                child: Icon(option['icon'], color: Colors.orange.shade700, size: 28), // Orange themed icon
              ),
              title: Text(
                option['title'],
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black87), // Styled title
              ),
              subtitle: Text(
                option['description'],
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600]), // Styled subtitle
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey), // Consistent icon style
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${option['title']} clicked!', style: GoogleFonts.poppins()),
                    backgroundColor: Colors.green, // Success feedback color
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}