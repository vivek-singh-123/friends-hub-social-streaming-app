import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Added for SystemUiOverlayStyle consistency
import 'package:image_picker/image_picker.dart';
import 'dart:async'; // For Timer
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'package:flutter/foundation.dart'; // Import for debugPrint

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> with SingleTickerProviderStateMixin {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  String selectedGender = "Male";
  DateTime? selectedDOB;
  File? _imageFile;

  // GlobalKey for the Form to validate all fields
  final _formKey = GlobalKey<FormState>();

  OverlayEntry? _overlayEntry; // To manage the overlay message
  Timer? _overlayTimer; // To control the duration of the overlay message

  // Animation controllers for the slide-down effect
  AnimationController? _animationController; // Made nullable
  Animation<Offset>? _slideAnimation; // Made nullable

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController( // Initialized here
      vsync: this,
      duration: const Duration(milliseconds: 300), // Animation duration
    );
    _slideAnimation = Tween<Offset>( // Initialized here
      begin: const Offset(0, -1), // Start from above the screen
      end: Offset.zero, // Slide to its original position
    ).animate(CurvedAnimation(
      parent: _animationController!, // Use ! because it's initialized above
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    _overlayTimer?.cancel(); // Cancel timer if active
    _overlayEntry?.remove(); // Remove overlay if active
    _animationController?.dispose(); // Dispose only if not null
    super.dispose();
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take a photo"),
              onTap: () async {
                Navigator.pop(context);
                final picked = await ImagePicker().pickImage(source: ImageSource.camera);
                if (picked != null) setState(() => _imageFile = File(picked.path));
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Choose from gallery"),
              onTap: () async {
                Navigator.pop(context);
                final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (picked != null) setState(() => _imageFile = File(picked.path));
              },
            ),
          ],
        ),
      ),
    );
  }

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

  // Function to show a temporary message overlay at the top with animation
  void _showTopOverlayMessage(String message, Color backgroundColor) {
    // Remove any existing overlay before showing a new one
    _overlayEntry?.remove();
    _overlayTimer?.cancel();
    _animationController?.reset(); // Reset animation controller only if not null

    if (_animationController == null || _slideAnimation == null) {
      // Handle case where animation controllers are not initialized (e.g., very early hot reload)
      // Fallback to a SnackBar or simply return.
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
        top: 0, // Position at the very top to overlap AppBar
        left: 0,
        right: 0,
        child: SlideTransition( // Slide animation
          position: _slideAnimation!, // Use ! because we checked for null
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 12, // Padding for status bar
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
    _animationController!.forward(); // Start animation only if not null

    _overlayTimer = Timer(const Duration(seconds: 2), () { // Display for 2 seconds
      _animationController?.reverse().then((_) { // Reverse animation before removing, check for null
        _overlayEntry?.remove();
        _overlayEntry = null;
      });
    });
  }


  // Function to handle the "Continue" button press with validation
  void _handleContinue() async {
    // Clear any existing overlay message
    _overlayEntry?.remove();
    _overlayEntry = null;
    _overlayTimer?.cancel();
    _animationController?.reset(); // Reset animation controller only if not null

    // Validate all fields in the form
    if (_formKey.currentState!.validate()) {
      // Also check for Date of Birth, as it's not a TextFormField
      if (selectedDOB == null) {
        _showTopOverlayMessage("Please select your Date of Birth.", Colors.red);
        return; // Stop if DOB is not selected
      }

      final prefs = await SharedPreferences.getInstance();

      // Save the image path to SharedPreferences if an image is selected
      if (_imageFile != null) {
        await prefs.setString('profile_image_path', _imageFile!.path);
        debugPrint('ProfileSetupScreen: Image path saved: ${_imageFile!.path}');
      } else {
        debugPrint('ProfileSetupScreen: No image selected to save.');
      }

      // Save the user's name to SharedPreferences
      await prefs.setString('user_name', nameController.text); // <<< ADDED THIS LINE
      debugPrint('ProfileSetupScreen: User name saved: ${nameController.text}'); // Debug print

      // If all validations pass, navigate to the home screen
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // If validation fails, show a general error message at the top
      _showTopOverlayMessage("Please fill in all required fields correctly.", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent, // Make status bar transparent for app bar color
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
      body: Form( // Wrapped the content with a Form widget
        key: _formKey, // Assign the GlobalKey to the Form
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                    child: _imageFile == null
                        ? const Icon(Icons.camera_alt, size: 30, color: Colors.grey)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 30),

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
                  // Basic email format validation
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
                  // Basic phone number length validation (adjust as needed)
                  if (value.length < 7 || value.length > 15) {
                    return 'Enter a valid phone number';
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
                  onPressed: _handleContinue, // Call the new validation function
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

  // Modified _buildInputField to use TextFormField and accept a validator
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
    String? Function(String?)? validator, // Added validator parameter
  }) {
    return TextFormField( // Changed from TextField to TextFormField
      controller: controller,
      keyboardType: inputType,
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
        // Add focused and error borders for better UX
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
      ),
      validator: validator, // Assign the passed validator
    );
  }

  // Modified _buildGenderDropdown to use DropdownButtonFormField and accept a validator
  Widget _buildGenderDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>( // Changed from DropdownButtonFormField to DropdownButtonFormField
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
        validator: (value) { // Added validator for gender
          if (value == null || value.isEmpty) {
            return 'Please select your gender';
          }
          return null;
        },
      ),
    );
  }

  // Modified _buildDOBPicker to include GestureDetector for validation check
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
            Expanded( // Added Expanded to prevent text overflow
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
