import 'package:flutter/material.dart';
import 'package:gosh_app/screens/live_screen.dart';
import 'package:gosh_app/screens/post_screen.dart';
import 'package:gosh_app/screens/discover_screen.dart';
import 'package:gosh_app/screens/profile_screen.dart';
import 'package:gosh_app/screens/wallet_screen.dart';
import '../widgets/bottom_nav_bar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 4; // Default to Profile

  final List<Widget> screens = [
    const LiveScreen(),        // 0
    const DiscoverScreen(),    // 1 - Discover (with search bar)
    const PostScreen(),        // 2 - Post
    WalletScreen(),            // 3
    const ProfileScreen(),     // 4
  ];

  @override
  Widget build(BuildContext context) {
    final bool isPostScreen = _currentIndex == 2;

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: isPostScreen ? Colors.black : Colors.white,
        ),
        child: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }
}
