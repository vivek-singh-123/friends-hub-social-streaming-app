import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ✅ Needed for SystemChrome
import 'package:gosh_app/screens/edit_profile_screen.dart';
import 'package:gosh_app/screens/vip_screen.dart';
import 'package:gosh_app/screens/full_profile_screen.dart'; // ✅ NEW Import
import 'package:gosh_app/screens/reset_password_screen.dart'; // Adjust 'gosh_app' if your project name is different

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

// ✅ NEW: Agency & Add Host Screens
import 'screens/agency_screen.dart';
import 'screens/add_host_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Set status bar style
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Fully transparent status bar
    statusBarIconBrightness: Brightness.light, // White icons for dark background
    statusBarBrightness: Brightness.dark, // For iOS: dark background, light icons
  ));

  runApp(const GoshLiveApp());
}

class GoshLiveApp extends StatelessWidget {
  const GoshLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GOSH APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Color(0xFFFFF3E0), // light orange background
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          selectedIconTheme: IconThemeData(size: 28),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
        ),
        textTheme: ThemeData.light().textTheme.apply(
          bodyColor: Colors.black87,
          displayColor: Colors.black87,
        ),
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
        '/resetPassword': (context) => const ResetPasswordScreen(),
        // ✅ Profile Section Routes
        '/earn': (context) => const EarnMoneyScreen(),
        '/getRupees': (context) => const GetRupeesScreen(),
        '/messages': (context) => const MessagesScreen(),
        '/task': (context) => const TaskScreen(),
        '/badge': (context) => const BadgeScreen(),
        '/accountSecurity': (context) => const AccountSecurityScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/vip': (context) => const VipScreen(),

        // ✅ Top Stats Routes
        '/followers': (context) => const FollowersScreen(),
        '/following': (context) => const FollowingScreen(),
        '/sent': (context) => const SentScreen(),

        // ✅ Edit & Full Profile
        '/editProfile': (context) => const EditProfileScreen(),
        '/fullProfile': (context) => const FullProfileScreen(),

        // ✅ NEW Screens
        '/agency': (context) => const AgencyScreen(),
        '/addHost': (context) => const AddHostScreen(),
      },
    );
  }
}