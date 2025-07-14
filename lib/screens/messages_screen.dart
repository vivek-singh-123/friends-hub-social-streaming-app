import 'package:flutter/material.dart';

// ✅ Move the messages list outside the class
final List<Map<String, String>> messages = [
  {'sender': 'Riya', 'lastMessage': 'Hey! What\'s up?', 'time': '10:24 AM'},
  {'sender': 'Dev', 'lastMessage': 'Let\'s go live at 5?', 'time': '9:10 AM'},
  {'sender': 'Ankit', 'lastMessage': 'Cool stream yesterday!', 'time': 'Yesterday'},
  {'sender': 'Priya', 'lastMessage': 'You there?', 'time': '2 days ago'},
  {'sender': 'Nishant', 'lastMessage': 'Great collab!', 'time': '2 days ago'},
];

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_comment),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('New message feature coming soon!')),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final msg = messages[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Text(msg['sender']![0], style: const TextStyle(color: Colors.white)),
            ),
            title: Text(msg['sender']!),
            subtitle: Text(msg['lastMessage']!),
            trailing: Text(msg['time']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opening chat with ${msg['sender']}...')),
              );
            },
          );
        },
      ),
    );
  }
}
