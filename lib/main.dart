import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ✅ Needed for SystemChrome
import 'package:gosh_app/screens/edit_profile_screen.dart';
import 'package:gosh_app/screens/vip_screen.dart';
import 'package:gosh_app/screens/full_profile_screen.dart'; // ✅ NEW Import
import 'package:gosh_app/screens/reset_password_screen.dart'; // Adjust 'gosh_app' if your project name is different
import 'package:gosh_app/screens/welcome_screen.dart';

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
// import 'screens/messages_screen.dart'; // No longer needed as a direct route
import 'screens/task_screen.dart';
import 'screens/badge_screen.dart';
import 'screens/account_security_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/terms_and_privacy_screen.dart'; // Make sure this is imported if it's a separate screen

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
        scaffoldBackgroundColor: const Color(0xFFFFF3E0), // light orange background
        appBarTheme: const AppBarTheme(
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
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          selectedIconTheme: IconThemeData(size: 28),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
        ),
        textTheme: ThemeData.light().textTheme.apply(
          bodyColor: Colors.black87,
          displayColor: Colors.black87,
        ),
        useMaterial3: true,
      ),
      // ✅ FIXED: only keep one initialRoute
      initialRoute: '/',
      routes: {
        // ✅ Core Routes
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/profileSetup': (context) => const ProfileSetupScreen(),
        '/home': (context) => const HomeScreen(),
        '/wallet': (context) => WalletScreen(), // Removed 'const' keyword
        '/creatorProfile': (context) => CreatorProfileScreen(), // Removed 'const' keyword
        '/resetPassword': (context) => ResetPasswordScreen(), // Removed 'const' keyword
        // ✅ Profile Section Routes
        '/earn': (context) => EarnMoneyScreen(), // Removed 'const' keyword
        '/getRupees': (context) => GetRupeesScreen(), // Removed 'const' keyword
        '/task': (context) => TaskScreen(), // Removed 'const' keyword
        '/badge': (context) => BadgeScreen(), // Removed 'const' keyword
        '/accountSecurity': (context) => AccountSecurityScreen(), // Removed 'const' keyword
        '/settings': (context) => SettingsScreen(), // Removed 'const' keyword
        '/vip': (context) => VipScreen(), // Removed 'const' keyword
        '/termsAndPrivacy': (context) => const TermsAndPrivacyScreen(), // This one can remain const if it's a StatelessWidget with only const fields

        // ✅ Top Stats Routes
        '/followers': (context) => FollowersScreen(), // Removed 'const' keyword
        '/following': (context) => FollowingScreen(), // Removed 'const' keyword
        '/sent': (context) => SentScreen(), // Removed 'const' keyword

        // ✅ Edit & Full Profile
        '/editProfile': (context) => EditProfileScreen(), // Removed 'const' keyword
        //'/fullProfile': (context) => FullProfileScreen(), // Removed 'const' keyword

        // ✅ NEW Screens
        '/agency': (context) => AgencyScreen(), // Removed 'const' keyword
        '/addHost': (context) => AddHostScreen(), // Removed 'const' keyword
      },
    );
  }
}
