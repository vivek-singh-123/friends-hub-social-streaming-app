import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gosh_app/screens/reset_password_screen.dart';
import 'package:gosh_app/backend/register/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    _setSystemUIStyle();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.orange[800],
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            _buildTopRow(context),
            const SizedBox(height: 10),
            _buildLogoSection(),
            const SizedBox(height: 30),
            _buildFormSection(context),
          ],
        ),
      ),
    );
  }

  // System UI styling
  void _setSystemUIStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  // Top section with Sign Up link
  Widget _buildTopRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Don't have an account?",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/profileSetup'),
            child: const Text(
              "Sign up",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // App logo text section
  Widget _buildLogoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          const Icon(Icons.podcasts, color: Colors.pink, size: 30),
          const SizedBox(width: 8),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Friends',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: 'hub',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Form section with input fields and buttons
  Widget _buildFormSection(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFormDragBar(),
                  _buildFormHeader(),
                  const SizedBox(height: 20),
                  _buildEmailField(),
                  const SizedBox(height: 12),
                  _buildPasswordField(),
                  _buildForgotPasswordLink(context),
                  const SizedBox(height: 6),
                  _buildLoginButton(context),
                  const SizedBox(height: 20),
                  _buildOrDivider(),
                  const SizedBox(height: 20),
                  _buildSocialLoginButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormDragBar() {
    return Center(
      child: Container(
        height: 4,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildFormHeader() {
    return Column(
      children: const [
        SizedBox(height: 20),
        Center(
          child: Text(
            'Login to Your account!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        Center(
          child: Text(
            'Enter your credentials to continue.',
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: emailController,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        prefixIcon: const Icon(Icons.email_outlined, color: Colors.black),
        hintText: 'Email',
        hintStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: passwordController,
      obscureText: _obscurePassword,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        prefixIcon: const Icon(Icons.lock_outline, color: Colors.black),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility,
            color: Colors.black,
          ),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
        hintText: 'Password',
        hintStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildForgotPasswordLink(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, '/resetPassword'),
        child: const Text(
          'Forgot Password? Reset Here',
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () async {
          final email = emailController.text.trim();
          final password = passwordController.text;
          final token = 'dljaklejidnjkd'; // Replace with actual token if needed

          if (email.isEmpty || password.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please enter both email and password')),
            );
            return;
          }

          final result = await AuthService.loginUser(
            Token: token,
            Email: email,
            Password: password,
          );

          if (result == 1) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (result == 0) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('User Not Found'),
                content: const Text('Please sign up to continue.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/profileSetup');
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Something went wrong. Try again later.')),
            );
          }
        },
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Or Login with",
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [_googleLoginButton(), _appleLoginButton()],
    );
  }

  Widget _googleLoginButton() {
    return OutlinedButton.icon(
      onPressed: () async {
        final Uri googleUrl = Uri.parse('https://accounts.google.com/signin');
        if (!await launchUrl(googleUrl, mode: LaunchMode.externalApplication)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not launch \${googleUrl.toString()}'),
            ),
          );
        }
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
      ),
      icon: Image.asset('assets/images/google_logo.png', height: 20, width: 20),
      label: const Text('Google', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _appleLoginButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        final Uri appleUrl = Uri.parse('https://appleid.apple.com/account');
        if (!await launchUrl(appleUrl, mode: LaunchMode.externalApplication)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch \${appleUrl.toString()}')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      icon: const Icon(Icons.apple, color: Colors.white, size: 20),
      label: const Text('Apple', style: TextStyle(color: Colors.white)),
    );
  }
}
