import 'package:flutter/material.dart';

// Your screen imports (ensure these paths are correct)
import 'live_screen.dart';
import 'post_screen.dart'; // Corresponds to "Shorts"
import 'upload_screen.dart'; // Corresponds to the "Upload" / middle button
import 'messages_screen.dart';
import 'profile_screen.dart';

// Import your custom BottomNavBar (ensure this path is correct relative to main.dart)
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
  int _currentIndex = 0; // State to track the currently selected tab index

  // Screens in the order they appear in the BottomNavBar
  final List<Widget> _screens = [
    const LiveScreen(),      // Index 0: Live
    const PostScreen(),      // Index 1: Shorts
    const UploadScreen(),    // Index 2: Video Upload (now a regular tab)
    const MessagesScreen(),  // Index 3: Message
    const ProfileScreen(),   // Index 4: Me
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _screens.length, vsync: this);
    _tabController.index = _currentIndex; // Initialize TabController's index

    _tabController.addListener(() {
      if (_tabController.index != _currentIndex) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
      // No special print for index 2 needed here, as it's now a regular tab.
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Note: vibrantPink is now only used in BottomNavBar for selection colors
    // const Color vibrantPink = Color(0xFFEA016B);

    return Scaffold(
      backgroundColor: Colors.white,
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(), // Prevents horizontal swiping
        children: _screens,
      ),
      // --- FloatingActionButton is REMOVED ---
      // floatingActionButton: FloatingActionButton( ... ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // --- END REMOVAL ---
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _tabController.animateTo(index); // Animate to the selected tab
          });
        },
      ),
    );
  }
}