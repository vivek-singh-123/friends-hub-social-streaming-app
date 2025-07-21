import 'package:flutter/material.dart';

// ✅ Moved messages list outside the class
final List<Map<String, String>> messages = [
  {'sender': 'Riya', 'lastMessage': 'Hey! What\'s up?', 'time': '10:24 AM', 'avatarColor': '0xFF9C27B0'},
  {'sender': 'Dev', 'lastMessage': 'Let\'s go live at 5?', 'time': '9:10 AM', 'avatarColor': '0xFF4CAF50'},
  {'sender': 'Ankit', 'lastMessage': 'Cool stream yesterday!', 'time': 'Yesterday', 'avatarColor': '0xFF2196F3'},
  {'sender': 'Priya', 'lastMessage': 'You there?', 'time': '2 days ago', 'avatarColor': '0xFFE91E63'},
  {'sender': 'Nishant', 'lastMessage': 'Great collab!', 'time': '2 days ago', 'avatarColor': '0xFFFFC107'},
  {'sender': 'Sneha', 'lastMessage': 'Can we reschedule?', 'time': '3 days ago', 'avatarColor': '0xFF795548'},
  {'sender': 'Rahul', 'lastMessage': 'Meeting at 10 AM', 'time': 'Last Week', 'avatarColor': '0xFF607D8B'},
];

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search coming soon!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_comment, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('New message feature coming soon!')),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[100],
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final msg = messages[index];
            final Color avatarBgColor = Color(int.parse(msg['avatarColor']!.replaceFirst('0x', ''), radix: 16));

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12.0),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Opening chat with ${msg['sender']}...')),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: avatarBgColor,
                        child: Text(
                          msg['sender']![0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              msg['sender']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              msg['lastMessage']!,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        msg['time']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
