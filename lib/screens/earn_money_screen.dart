import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: const Text('Earn Money'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: earnOptions.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final option = earnOptions[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple.shade100,
                child: Icon(option['icon'], color: Colors.deepPurple),
              ),
              title: Text(option['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(option['description']),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${option['title']} clicked!')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
