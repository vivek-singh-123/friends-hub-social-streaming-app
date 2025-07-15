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

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: isPostScreen ? Colors.black : Colors.white,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      // ✅ Add label color logic here
      selectedItemColor: isPostScreen ? Colors.white : Colors.black,
      unselectedItemColor: isPostScreen ? Colors.white60 : Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.live_tv,
            color: currentIndex == 0 ? Colors.green : Colors.black,
          ),
          label: "Live",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: currentIndex == 1 ? Colors.green : Colors.black,
          ),
          label: "Discover",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_box,
            color: currentIndex == 2
                ? Colors.green
                : isPostScreen
                ? Colors.white
                : Colors.black,
          ),
          label: "Post",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_balance_wallet,
            color: currentIndex == 3 ? Colors.green : Colors.black,
          ),
          label: "Wallet",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: currentIndex == 4 ? Colors.green : Colors.black,
          ),
          label: "Profile",
        ),
      ],
    );
  }
}
