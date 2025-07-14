import 'package:flutter/material.dart';

// Splash/Login/Profile Setup
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_setup_screen.dart';

// Home & Profile
import 'screens/home_screen.dart';
import 'screens/creator_profile_screen.dart';
import 'screens/wallet_screen.dart';

// Profile Subpages
import 'screens/earn_money_screen.dart';
import 'screens/get_rupees_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/task_screen.dart';
import 'screens/badge_screen.dart';
import 'screens/account_security_screen.dart';
import 'screens/settings_screen.dart';

// Top Profile Stats Screens
import 'screens/followers_screen.dart';
import 'screens/following_screen.dart';
import 'screens/sent_screen.dart';

void main() {
  runApp(const GoshLiveApp());
}

class GoshLiveApp extends StatelessWidget {
  const GoshLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GOSH APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        // ✅ Core Routes
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/profileSetup': (context) => const ProfileSetupScreen(),
        '/home': (context) => const HomeScreen(),
        '/wallet': (context) => WalletScreen(),
        '/creatorProfile': (context) => const CreatorProfileScreen(),

        // ✅ Profile Section Routes
        '/earn': (context) => const EarnMoneyScreen(),
        '/getRupees': (context) => const GetRupeesScreen(),
        '/messages': (context) => const MessagesScreen(),
        '/task': (context) => const TaskScreen(),
        '/badge': (context) => const BadgeScreen(),
        '/accountSecurity': (context) => const AccountSecurityScreen(),
        '/settings': (context) => const SettingsScreen(),

        // ✅ Top Stats Routes
        '/followers': (context) => const FollowersScreen(),
        '/following': (context) => const FollowingScreen(),
        '/sent': (context) => const SentScreen(),
      },
    );
  }
}
