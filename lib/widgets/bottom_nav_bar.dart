import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<bool> _isTappedList = List.generate(4, (_) => false);

  void _onTap(int index) {
    setState(() {
      _isTappedList[index] = true;
    });

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _isTappedList[index] = false;
      });
    });

    widget.onTap(index);
  }

  Color _getIconColor(int index) {
    if (index == widget.currentIndex) return Colors.green;
    return widget.currentIndex == 1 ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final isPostScreen = widget.currentIndex == 1;

    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: _onTap,
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
          icon: AnimatedScale(
            scale: _isTappedList[0] ? 1.3 : 1.0,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
            child: Icon(Icons.live_tv, color: _getIconColor(0)),
          ),
          label: "Live",
        ),
        BottomNavigationBarItem(
          icon: AnimatedScale(
            scale: _isTappedList[1] ? 1.3 : 1.0,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
            child: Image.asset(
              'assets/icons/video.png',
              height: 24,
              color: widget.currentIndex == 1
                  ? Colors.green
                  : isPostScreen
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          label: "Video",
        ),
        BottomNavigationBarItem(
          icon: AnimatedScale(
            scale: _isTappedList[2] ? 1.3 : 1.0,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
            child: Icon(Icons.account_balance_wallet, color: _getIconColor(2)),
          ),
          label: "Wallet",
        ),
        BottomNavigationBarItem(
          icon: AnimatedScale(
            scale: _isTappedList[3] ? 1.3 : 1.0,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
            child: Icon(Icons.person, color: _getIconColor(3)),
          ),
          label: "Profile",
        ),
      ],
    );
  }
}
