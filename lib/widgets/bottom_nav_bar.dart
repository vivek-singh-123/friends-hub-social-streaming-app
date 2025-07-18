import 'package:flutter/material.dart';
import 'package:gosh_app/core/constant/constant.dart';

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
  List<bool> _isTappedList = List.generate(5, (_) => false);

  void _onTap(int index) {
    setState(() {
      _isTappedList[index] = true;
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _isTappedList[index] = false;
      });
    });

    widget.onTap(index);
  }

  Color _getIconColor(int index) {
    if (index == widget.currentIndex) return Colors.white;
    return Colors.white60;
  }

  Color _getBackgroundColor() {
    return widget.currentIndex == 1 ? Colors.black : Colors.white;
  }

  Color _getLabelColor(int index) {
    return widget.currentIndex == index ? Colors.white : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final isPostScreen = widget.currentIndex == 1;

    return Container(
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (index) {
            IconData? iconData;
            Widget iconWidget;

            switch (index) {
              case 0:
                iconData = Icons.live_tv;
                iconWidget = Icon(iconData, color: _getIconColor(index));
                break;
              case 1:
                iconWidget = Image.asset(
                  'assets/icons/video.png',
                  height: 24,
                  color: widget.currentIndex == 1
                      ? kPrimaryColor
                      : isPostScreen
                      ? Colors.white
                      : Colors.black,
                );
                break;
              case 2:
                iconData = Icons.cloud_upload;
                iconWidget = Icon(iconData, color: _getIconColor(index));
                break;
              case 3:
                iconData = Icons.account_balance_wallet;
                iconWidget = Icon(iconData, color: _getIconColor(index));
                break;
              case 4:
                iconData = Icons.person;
                iconWidget = Icon(iconData, color: _getIconColor(index));
                break;
              default:
                iconWidget = Icon(Icons.circle);
            }

            final labels = ['Live', 'Shorts', 'Upload', 'Wallet', 'Profile'];

            return GestureDetector(
              onTap: () => _onTap(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedScale(
                    scale: _isTappedList[index] ? 1.3 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutBack,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.currentIndex == index
                            ? kPrimaryColor
                            : Colors.transparent,
                      ),
                      child: iconWidget,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    labels[index],
                    style: TextStyle(
                      fontSize: 12,
                      color: _getLabelColor(index),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}