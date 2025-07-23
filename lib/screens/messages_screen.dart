import 'package:flutter/material.dart';
import 'dart:async';

class MessagesScreen extends StatefulWidget {
  final ValueNotifier<int> totalUnreadCountNotifier;

  // Make _unreadCounts static and NOT final so it can be modified.
  // It's a private static member, modified only via static methods.
  static Map<String, int> _staticUnreadCounts = {
    'Riya': 2,
    'Dev': 0,
    'Ankit': 5,
    'Priya': 1,
    'Nishant': 0,
    'Sneha': 0,
    'Rahul': 0,
  };

  // Method to get the current total unread count from the static map
  static int getStaticTotalUnreadCount() {
    return _staticUnreadCounts.values.fold(0, (sum, count) => sum + count);
  }

  // NEW: Public static getter to provide the list of sender names (keys)
  static List<String> getSenderNames() {
    return _staticUnreadCounts.keys.toList();
  }

  // Static method to update a sender's unread count (e.g., clear to 0)
  static void updateUnreadCountForSender(String sender, int count) {
    _staticUnreadCounts[sender] = count;
  }

  // Static method to increment a sender's unread count
  static void incrementUnreadCountForSender(String sender) {
    _staticUnreadCounts[sender] = (_staticUnreadCounts[sender] ?? 0) + 1;
  }

  const MessagesScreen({super.key, required this.totalUnreadCountNotifier});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  // This list will now be mutable and can be updated
  // It's still instance-specific for the messages themselves
  List<Map<String, String>> messages = [
    {'sender': 'Riya', 'lastMessage': 'Hey! What\'s up?', 'time': '10:24 AM', 'avatarColor': '0xFF9C27B0'},
    {'sender': 'Dev', 'lastMessage': 'Let\'s go live at 5?', 'time': '9:10 AM', 'avatarColor': '0xFF4CAF50'},
    {'sender': 'Ankit', 'lastMessage': 'Cool stream yesterday!', 'time': 'Yesterday', 'avatarColor': '0xFF2196F3'},
    {'sender': 'Priya', 'lastMessage': 'You there?', 'time': '2 days ago', 'avatarColor': '0xFFE91E63'},
    {'sender': 'Nishant', 'lastMessage': 'Great collab!', 'time': '2 days ago', 'avatarColor': '0xFFFFC107'},
    {'sender': 'Sneha', 'lastMessage': 'Can we reschedule?', 'time': '3 days ago', 'avatarColor': '0xFF795548'},
    {'sender': 'Rahul', 'lastMessage': 'Meeting at 10 AM', 'time': 'Last Week', 'avatarColor': '0xFF607D8B'},
  ];

  @override
  void initState() {
    super.initState();
    // The initial update and periodic updates are now handled by HomeScreen's initState.
    // We only need to ensure the notifier is updated when a chat is opened from this screen.
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateTotalUnreadCountInNotifier() {
    final int newTotal = MessagesScreen.getStaticTotalUnreadCount();
    if (widget.totalUnreadCountNotifier.value != newTotal) {
      widget.totalUnreadCountNotifier.value = newTotal;
    }
  }

  void _openChat(String sender) {
    setState(() {
      // Use the static method to update the unread count
      MessagesScreen.updateUnreadCountForSender(sender, 0);
      _updateTotalUnreadCountInNotifier(); // Update notifier after clearing badge
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening chat with $sender...')),
    );
  }

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
            // Use the static map to get the unread count
            final int unreadCount = MessagesScreen._staticUnreadCounts[msg['sender']] ?? 0;

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12.0),
                onTap: () => _openChat(msg['sender']!),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            msg['time']!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (unreadCount > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                unreadCount > 99 ? '99+' : unreadCount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
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
