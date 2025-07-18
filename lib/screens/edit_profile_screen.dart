import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'package:gosh_app/core/constant/constant.dart'; // For kPrimaryColor (assuming it's deepPurple or similar for this screen)

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _birthdayController = TextEditingController(); // Consider using a DatePicker for this
  String? _selectedGender;
  String? _selectedCountry;
  final _facebookController = TextEditingController();
  final _instagramController = TextEditingController();
  final _twitterController = TextEditingController();

  // Initialize SharedPreferences and load data
  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    // Load image path
    final imagePath = prefs.getString('profile_image_path');
    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        _image = File(imagePath);
      });
    }

    // Load other profile data (example)
    // You would need to save these in ProfileSetupScreen as well
    _nameController.text = prefs.getString('user_name') ?? '';
    _bioController.text = prefs.getString('user_bio') ?? '';
    _birthdayController.text = prefs.getString('user_birthday') ?? '';
    _selectedGender = prefs.getString('user_gender') ?? "Male"; // Default if not found
    _selectedCountry = prefs.getString('user_country') ?? "India"; // Default if not found
    _facebookController.text = prefs.getString('user_facebook') ?? '';
    _instagramController.text = prefs.getString('user_instagram') ?? '';
    _twitterController.text = prefs.getString('user_twitter') ?? '';

    setState(() {}); // Update UI after loading data
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
      // Save the newly picked image path to preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_path', picked.path);
    }
  }

  // Example for integrating a DatePicker for Birthday
  /*
  Future<void> _selectBirthday(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.deepPurple, // Or kPrimaryColor
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.deepPurple,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _birthdayController.text = "${picked.day}/${picked.month}/${picked.year}";
        // Optionally save to SharedPreferences here too
      });
    }
  }
  */

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _birthdayController.dispose();
    _facebookController.dispose();
    _instagramController.dispose();
    _twitterController.dispose();
    super.dispose();
  }

  // Function to save all profile changes
  Future<void> _saveChanges() async {
    final prefs = await SharedPreferences.getInstance();

    // Save all text field data
    await prefs.setString('user_name', _nameController.text);
    await prefs.setString('user_bio', _bioController.text);
    await prefs.setString('user_birthday', _birthdayController.text);
    await prefs.setString('user_gender', _selectedGender ?? "Male");
    await prefs.setString('user_country', _selectedCountry ?? "India");
    await prefs.setString('user_facebook', _facebookController.text);
    await prefs.setString('user_instagram', _instagramController.text);
    await prefs.setString('user_twitter', _twitterController.text);

    // Image path is already saved in _pickImage()

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile Updated Successfully!"),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context); // Go back to ProfileScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // 🔹 Profile Image
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 65, // Slightly larger
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : const AssetImage('assets/default_avatar.png')
                      as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(8), // Larger tap area
                          decoration: const BoxDecoration(
                            color: Colors.deepPurple, // Or kPrimaryColor
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit,
                              size: 18, color: Colors.white), // Larger icon
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              buildSectionTitle("Basic Info"),
              _buildTextField("Name", _nameController, icon: Icons.person_outline),
              _buildDropdown("Gender", ["Male", "Female", "Other"],
                  _selectedGender, (val) => setState(() => _selectedGender = val), icon: Icons.people_outline),
              // If you use a DatePicker, you might change _buildTextField to a custom widget for birthday
              _buildTextField("Birthday (DD/MM/YYYY)", _birthdayController, icon: Icons.calendar_today_outlined),
              _buildDropdown("Country", ["India", "USA", "UK", "Canada", "Other"],
                  _selectedCountry, (val) => setState(() => _selectedCountry = val), icon: Icons.flag_outlined),
              _buildTextField("Bio", _bioController, maxLines: 3, icon: Icons.info_outline),

              const SizedBox(height: 20),
              buildSectionTitle("Social Links"),
              _buildTextField("Facebook Link", _facebookController, icon: Icons.facebook),
              _buildTextField("Instagram Link", _instagramController, icon: Icons.camera_alt_outlined), // Using camera_alt for Instagram for demo
              _buildTextField("Twitter Link", _twitterController, icon: Icons.dataset_outlined), // Using dataset for Twitter for demo

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveChanges, // Call the new save function
                  icon: const Icon(Icons.save),
                  label: const Text("Save Changes"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // Or kPrimaryColor
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16), // Slightly larger
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // More rounded
                    ),
                    elevation: 8, // More prominent shadow
                    textStyle: GoogleFonts.poppins(
                        fontSize: 17, fontWeight: FontWeight.w700), // Bolder text
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87), // Slightly larger, bolder
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // Enhanced _buildTextField with Card wrapper and optional icon
  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card( // Wrap in Card for consistent styling
        elevation: 1, // Subtle shadow
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: TextFormField( // Use TextFormField for consistency
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.poppins(color: Colors.black87),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
            filled: true,
            fillColor: Colors.white, // Card provides background, but keep filled true
            prefixIcon: icon != null ? Icon(icon, color: Colors.grey[600]) : null, // Optional icon
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder( // No border, let card handle it
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder( // No border
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder( // Highlight when focused
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.deepPurple, width: 2), // Or kPrimaryColor
            ),
          ),
        ),
      ),
    );
  }

  // Enhanced _buildDropdown with Card wrapper and optional icon
  Widget _buildDropdown(String label, List<String> items, String? value,
      void Function(String?) onChanged, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card( // Wrap in Card for consistent styling
        elevation: 1, // Subtle shadow
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: DropdownButtonFormField<String>(
          value: value,
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item, style: GoogleFonts.poppins())))
              .toList(),
          onChanged: onChanged,
          style: GoogleFonts.poppins(color: Colors.black87),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
            filled: true,
            fillColor: Colors.white, // Card provides background
            prefixIcon: icon != null ? Icon(icon, color: Colors.grey[600]) : null, // Optional icon
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder( // No border
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder( // No border
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder( // Highlight when focused
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.deepPurple, width: 2), // Or kPrimaryColor
            ),
          ),
        ),
      ),
    );
  }
}
