import 'package:flutter/material.dart';
import 'dart:async'; // Import for Timer

// Your screen imports
import 'live_screen.dart';
import 'post_screen.dart';
import 'upload_screen.dart';
import 'messages_screen.dart'; // Import the updated MessagesScreen
import 'profile_screen.dart';

// Import your custom BottomNavBar
import 'package:gosh_app/widgets/bottom_nav_bar.dart';

// Assuming kPrimaryColor or vibrantPink might be defined here, though not directly used in HomeScreen now
import 'package:gosh_app/core/constant/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  // Create and own the ValueNotifier for the total unread message count
  // Initialize it with the static total unread count from MessagesScreen
  final ValueNotifier<int> _totalUnreadMessagesNotifier = ValueNotifier<int>(MessagesScreen.getStaticTotalUnreadCount());

  // Timer for simulating new messages, now in HomeScreen
  Timer? _messageSimulationTimer;

  // Screens in the order they appear in the BottomNavBar
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this); // 5 tabs
    _tabController.index = _currentIndex;

    _screens = [
      const LiveScreen(),
      const PostScreen(),
      const UploadScreen(),
      // Pass the ValueNotifier to MessagesScreen
      MessagesScreen(totalUnreadCountNotifier: _totalUnreadMessagesNotifier),
      const ProfileScreen(),
    ];

    _tabController.addListener(() {
      if (_tabController.index != _currentIndex) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });

    // Start the message simulation timer here
    _messageSimulationTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _simulateNewMessageInHome();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _totalUnreadMessagesNotifier.dispose(); // Dispose the notifier when HomeScreen is disposed
    _messageSimulationTimer?.cancel(); // Cancel the timer when HomeScreen is disposed
    super.dispose();
  }

  // This method simulates new messages and updates the notifier
  void _simulateNewMessageInHome() {
    // Get the list of senders using the public static getter
    final List<String> senders = MessagesScreen.getSenderNames(); // ✅ Changed to use public getter
    if (senders.isEmpty) return; // Avoid error if no senders

    final randomSenderIndex = DateTime.now().millisecondsSinceEpoch % senders.length;
    final sender = senders[randomSenderIndex];

    // Use the static method to increment the count
    MessagesScreen.incrementUnreadCountForSender(sender);

    // Update the ValueNotifier to trigger rebuild of BottomNavBar
    _totalUnreadMessagesNotifier.value = MessagesScreen.getStaticTotalUnreadCount();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(), // Prevents horizontal swiping
        children: _screens,
      ),
      // Use ValueListenableBuilder to listen to changes in the notifier
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _totalUnreadMessagesNotifier,
        builder: (context, totalUnreadMessages, child) {
          return BottomNavBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _tabController.animateTo(index);
              });
            },
            messagesUnreadCount: totalUnreadMessages, // Pass the dynamic count to BottomNavBar
          );
        },
      ),
    );
  }
}
