import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';

import 'live_screen.dart';
import 'post_screen.dart';
import 'wallet_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: MotionTabBar(
        tabBarColor: Colors.white,
        tabIconColor: Colors.grey,
        tabSelectedColor: Colors.purple,
        textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        initialSelectedTab: "Live",
        labels: const ["Live", "Video", "Wallet", "Profile"],
        icons: const [Icons.live_tv, Icons.video_library, Icons.account_balance_wallet, Icons.person],
        tabSize: 50,
        tabBarHeight: 55,
        onTabItemSelected: (int index) {
          setState(() {
            _tabController.index = index;
          });
        },
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LiveScreen(),     // 1: Live
          PostScreen(),     // 2: Video
          WalletScreen(),   // 3: Wallet
          ProfileScreen(),  // 4: Profile
        ],
      ),
    );
  }
}
