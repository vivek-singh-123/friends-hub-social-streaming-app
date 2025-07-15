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
  int _currentIndex = 0; // ✅ Default to Live screen

  final List<Widget> _screens = [
    const LiveScreen(),        // 0 - Live
    const DiscoverScreen(),    // 1 - Discover
    const PostScreen(),        // 2 - Post
    WalletScreen(),            // 3 - Wallet
    const ProfileScreen(),     // 4 - Profile
  ];

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final bool isPostScreen = _currentIndex == 2;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: isPostScreen ? Colors.black : Colors.white,
        ),
        child: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
        ),
      ),
    );
  }
}
