import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'live_screen.dart';
import 'post_screen.dart';
import 'upload_screen.dart';
import 'wallet_screen.dart';
import 'profile_screen.dart';
import 'package:gosh_app/core/constant/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> _screens = [
    LiveScreen(),
    PostScreen(),
    UploadScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _screens.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Live",
        labels: const ["Live", "Shorts", "Upload", "Wallet", "Profile"],
        icons: const [
          Icons.live_tv,
          Icons.video_library, // ❌ Can't use asset icon here
          Icons.add_circle_outline,
          Icons.account_balance_wallet,
          Icons.person,
        ],
        tabIconColor: Colors.grey,
        tabSelectedColor: kPrimaryColor,
        tabBarColor: Colors.white,
        textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        tabSize: 50,
        tabBarHeight: 55,
        onTabItemSelected: (index) {
          setState(() {
            _tabController.index = index;
          });
        },
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
    );
  }
}
