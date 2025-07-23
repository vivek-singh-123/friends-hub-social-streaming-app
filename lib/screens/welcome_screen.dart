import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/gestures.dart';
// Import the dedicated TermsAndPrivacyScreen
import 'package:gosh_app/screens/terms_and_privacy_screen.dart'; // Assuming this path

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [],
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg', // Ensure this asset path is correct in pubspec.yaml
              fit: BoxFit.cover,
            ),
          ),
          // Overlay for darkening the background image and making text readable
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo
                    Image.asset(
                      'assets/logo.png',
                      width: 200,
                      height: 160,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Jashn Har Din, Party Har Waqt!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Log in with Google Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                          debugPrint('Navigating to Login Screen from Google button');
                        },
                        icon: const Icon(FontAwesomeIcons.google, color: Colors.red),
                        label: const Text(
                          'Log in with Google',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.grey.shade200;
                              }
                              return Colors.white;
                            },
                          ),
                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Log in with Facebook Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                          debugPrint('Navigating to Login Screen from Facebook button');
                        },
                        icon: const Icon(FontAwesomeIcons.facebook, color: Colors.white),
                        label: const Text(
                          'Log in with Facebook',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.blue[900];
                              }
                              return Colors.blue[700];
                            },
                          ),
                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Log in with Truecaller Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                          debugPrint('Navigating to Login Screen from Truecaller button');
                        },
                        icon: const Icon(FontAwesomeIcons.phoneFlip, color: Colors.blue),
                        label: const Text(
                          'Log in with Truecaller',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.lightBlue[700];
                              }
                              return Colors.lightBlue[400];
                            },
                          ),
                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Terms & Privacy Policy
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'By logging in, you confirm you\'re over 18 years old and agree to our ',
                        style: const TextStyle(color: Colors.white70, fontSize: 13),
                        children: [
                          TextSpan(
                            text: 'Terms & Privacy Policy',
                            style: const TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigate to the dedicated TermsAndPrivacyScreen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const TermsAndPrivacyScreen()),
                                );
                                debugPrint('Navigating to dedicated Terms & Privacy Policy screen');
                              },
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
