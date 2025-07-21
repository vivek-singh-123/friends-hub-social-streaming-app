import 'package:flutter/material.dart';
import 'package:gosh_app/core/constant/constant.dart'; // Ensure this path is correct

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
  // For the tap animation (scale effect)
  List<bool> _isTappedList = List.generate(5, (_) => false);

  // Icon asset paths and labels - Order matches _screens in HomeScreen
  final List<String> _iconAssetPaths = const [
    'assets/icons/live.png',    // Index 0: Live
    'assets/icons/shorts.png',   // Index 1: Shorts
    'assets/icons/upload.png',    // Index 2: CHANGED TO UPLOAD.PNG
    'assets/icons/message.png',  // Index 3: Message
    'assets/icons/me.png',       // Index 4: Me
  ];

  final List<String> _labels = const [
    'Live',
    'Shorts',
    'Upload', // Now it has a label like others
    'Message',
    'Me',
  ];

  void _onTapHandler(int index) {
    setState(() {
      _isTappedList[index] = true; // Start scale animation
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _isTappedList[index] = false; // Reverse scale animation
      });
    });

    widget.onTap(index); // Call the parent's onTap to change screens
  }

  Color _getLabelColor(int index) {
    // Revert to pink color for selected state, black for unselected
    return widget.currentIndex == index ? const Color(0xFFFF6A00) : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    const Color navBarBackgroundColor = Colors.white; // Fixed white background
    // Revert to the vibrant pink color from your original design
    const Color vibrantPink = Color(0xFFFF6A00);
    final Color unselectedGrey = Colors.black; // Consistent unselected grey

    return BottomAppBar(
      color: navBarBackgroundColor,
      surfaceTintColor: navBarBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(5, (index) {
          Widget iconWidget;
          bool isSelected = widget.currentIndex == index;

          // --- Custom Icon Handling for each tab ---
          if (index == 0) { // Live Icon ('assets/icons/live.png')
            iconWidget = Container(
              padding: const EdgeInsets.all(2), // Padding around the icon for border
              decoration: isSelected
                  ? BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: vibrantPink, width: 1.5), // Pink border when selected
              )
                  : null, // No border when unselected
              child: Image.asset(
                _iconAssetPaths[index], // Load live.png
                height: 24,
                width: 24,
                color: isSelected ? vibrantPink : unselectedGrey, // Tint live icon based on selection
              ),
            );
          } else { // For Shorts, Upload, Message, Me icons (indices 1, 2, 3, 4)
            iconWidget = Image.asset(
              _iconAssetPaths[index], // Load shorts.png, upload.png, message.png, or me.png
              height: 24,
              width: 24,
              color: isSelected ? vibrantPink : unselectedGrey, // Tint icon based on selection
            );

            // Add the badge for the Message icon (index 3)
            if (index == 3) {
              iconWidget = Stack(
                clipBehavior: Clip.none, // Allow badge to overflow
                children: [
                  iconWidget, // The base message icon
                  Positioned(
                    right: -8, // Adjust position for the badge
                    top: -4, // Adjust position for the badge
                    child: Container(
                      padding: const EdgeInsets.all(1.5), // Reduced padding for badge
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18, // Smaller minWidth for badge
                        minHeight: 18, // Smaller minHeight for badge
                      ),
                      child: const Text(
                        '99+',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9, // Smaller font size for badge
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            }
          }
          // --- End Custom Icon Handling ---

          return Expanded(
            child: GestureDetector(
              onTap: () => _onTapHandler(index),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Essential for min height
                children: [
                  AnimatedScale( // Keep the AnimatedScale for tap feedback
                    scale: _isTappedList[index] ? 1.1 : 1.0, // Slight scale on tap
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutBack,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Reduced vertical padding
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent, // Always transparent for no bubble background
                      ),
                      child: iconWidget, // The specific icon widget
                    ),
                  ),
                  const SizedBox(height: 1), // Minimal space between icon and text
                  Text(
                    _labels[index],
                    style: TextStyle(
                      fontSize: 10, // Slightly smaller font size for labels
                      color: _getLabelColor(index),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}