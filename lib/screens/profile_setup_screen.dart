import 'dart:io'; // Still needed for File, but could be removed if no other file operations
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart'; // This import can be removed entirely
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> with SingleTickerProviderStateMixin {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String selectedGender = "Male";
  DateTime? selectedDOB;
  // Removed File? _imageFile;

  final _formKey = GlobalKey<FormState>();

  OverlayEntry? _overlayEntry;
  Timer? _overlayTimer;

  AnimationController? _animationController;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _overlayTimer?.cancel();
    _overlayEntry?.remove();
    _animationController?.dispose();
    super.dispose();
  }

  // Removed _pickImage() method

  Future<void> _selectDOB() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDOB ?? DateTime(2000, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => selectedDOB = picked);
    }
  }

  void _showTopOverlayMessage(String message, Color backgroundColor) {
    _overlayEntry?.remove();
    _overlayTimer?.cancel();
    _animationController?.reset();

    if (_animationController == null || _slideAnimation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SlideTransition(
          position: _slideAnimation!,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 12,
                bottom: 12,
                left: 20,
                right: 20,
              ),
              color: backgroundColor,
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _animationController!.forward();

    _overlayTimer = Timer(const Duration(seconds: 2), () {
      _animationController?.reverse().then((_) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      });
    });
  }

  void _handleContinue() async {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _overlayTimer?.cancel();
    _animationController?.reset();

    if (_formKey.currentState!.validate()) {
      if (selectedDOB == null) {
        _showTopOverlayMessage("Please select your Date of Birth.", Colors.red);
        return;
      }
      if (passwordController.text.isEmpty) {
        _showTopOverlayMessage("Please enter a password.", Colors.red);
        return;
      }
      if (passwordController.text.length < 6) {
        _showTopOverlayMessage("Password must be at least 6 characters long.", Colors.red);
        return;
      }
      if (passwordController.text != confirmPasswordController.text) {
        _showTopOverlayMessage("Password and Confirm Password do not match.", Colors.red);
        return;
      }

      final prefs = await SharedPreferences.getInstance();

      // Removed image path saving logic
      // if (_imageFile != null) {
      //   await prefs.setString('profile_image_path', _imageFile!.path);
      //   debugPrint('ProfileSetupScreen: Image path saved: ${_imageFile!.path}');
      // } else {
      //   debugPrint('ProfileSetupScreen: No image selected to save.');
      // }

      await prefs.setString('user_name', nameController.text);
      debugPrint('ProfileSetupScreen: User name saved: ${nameController.text}');

      await prefs.setString('user_password', passwordController.text);
      debugPrint('ProfileSetupScreen: Password saved (for demonstration): ${passwordController.text}');


      Navigator.pushReplacementNamed(context, '/home');
    } else {
      _showTopOverlayMessage("Please fill in all required fields correctly.", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text("Create Account", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Removed GestureDetector and CircleAvatar for image selection
              // GestureDetector(
              //   onTap: _pickImage,
              //   child: Card(
              //     elevation: 4,
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              //     child: CircleAvatar(
              //       radius: 60,
              //       backgroundColor: Colors.grey[200],
              //       backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
              //       child: _imageFile == null
              //           ? const Icon(Icons.camera_alt, size: 30, color: Colors.grey)
              //           : null,
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 30), // Removed this SizedBox or adjust if needed

              _buildInputField(
                controller: nameController,
                label: "Name",
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              _buildGenderDropdown(),
              const SizedBox(height: 16),

              _buildDOBPicker(),
              const SizedBox(height: 16),

              _buildInputField(
                controller: emailController,
                label: "Email",
                icon: Icons.email,
                inputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email cannot be empty';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              _buildInputField(
                controller: phoneController,
                label: "Phone Number",
                icon: Icons.phone,
                inputType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number cannot be empty';
                  }
                  if (value.length < 7 || value.length > 15) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              _buildInputField(
                controller: passwordController,
                label: "Choose Password",
                icon: Icons.lock,
                isPassword: true,
                isObscureText: !_isPasswordVisible,
                onToggleVisibility: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password cannot be empty';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              _buildInputField(
                controller: confirmPasswordController,
                label: "Confirm Password",
                icon: Icons.lock_reset,
                isPassword: true,
                isObscureText: !_isConfirmPasswordVisible,
                onToggleVisibility: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm password cannot be empty';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: const Color(0xFFFF6F00),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _handleContinue,
                  child: const Text("Continue", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
    bool isPassword = false,
    bool isObscureText = false,
    VoidCallback? onToggleVisibility,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: isObscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFFF6F00), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            isObscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: onToggleVisibility,
        )
            : null,
      ),
      validator: validator,
    );
  }

  Widget _buildGenderDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedGender,
        icon: const Icon(Icons.arrow_drop_down),
        decoration: const InputDecoration(
          border: InputBorder.none,
          labelText: "Gender",
        ),
        items: ["Male", "Female", "Other"]
            .map((g) => DropdownMenuItem(value: g, child: Text(g)))
            .toList(),
        onChanged: (val) => setState(() => selectedGender = val!),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select your gender';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDOBPicker() {
    return GestureDetector(
      onTap: _selectDOB,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined, color: Colors.grey),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                selectedDOB != null
                    ? "${selectedDOB!.day}/${selectedDOB!.month}/${selectedDOB!.year}"
                    : "Select Date of Birth",
                style: TextStyle(
                  color: selectedDOB != null ? Colors.black : Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}