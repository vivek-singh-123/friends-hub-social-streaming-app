import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    const LiveScreen(),        // 0 - Live (light background)
    const DiscoverScreen(),    // 1 - Discover (dark)
    const PostScreen(),        // 2 - Post (dark)
    WalletScreen(),            // 3 - Wallet (dark)
    const ProfileScreen(),     // 4 - Profile (dark)
  ];

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }

  /// ✅ Dynamically set status bar style based on selected tab
  SystemUiOverlayStyle _getStatusBarStyle() {
    // Light background on LiveScreen -> dark icons
    if (_currentIndex == 0) {
      return const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark, // Black icons for white background
        statusBarBrightness: Brightness.light,    // For iOS
      );
    } else {
      // Dark backgrounds for other tabs -> white icons
      return const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light, // White icons
        statusBarBrightness: Brightness.dark,      // For iOS
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isPostScreen = _currentIndex == 2;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _getStatusBarStyle(),
      child: Scaffold(
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
      ),
    );
  }
}