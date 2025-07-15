import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPostScreen = currentIndex == 2;

    // Dynamic color logic
    Color getIconColor(int index) {
      if (index == currentIndex) return Colors.green;
      return isPostScreen ? Colors.white : Colors.black;
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: isPostScreen ? Colors.black : Colors.white,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedItemColor: isPostScreen ? Colors.white : Colors.black,
      unselectedItemColor: isPostScreen ? Colors.white60 : Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.live_tv,
            color: getIconColor(0),
          ),
          label: "Live",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: getIconColor(1),
          ),
          label: "Discover",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/video.png',
            height: 24,
            color: currentIndex == 2
                ? Colors.green
                : isPostScreen
                ? Colors.white
                : Colors.black,
          ),
          label: "Video",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_balance_wallet,
            color: getIconColor(3),
          ),
          label: "Wallet",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: getIconColor(4),
          ),
          label: "Profile",
        ),
      ],
    );
  }
}
