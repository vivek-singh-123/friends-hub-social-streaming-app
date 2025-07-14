import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _birthdayController = TextEditingController();
  String? _selectedGender;
  String? _selectedCountry;
  final _facebookController = TextEditingController();
  final _instagramController = TextEditingController();
  final _twitterController = TextEditingController();

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : const AssetImage('assets/default_avatar.png')
                as ImageProvider,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(Icons.camera_alt, color: Colors.grey[800]),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField("Name", _nameController),
            _buildDropdown("Gender", ["Male", "Female", "Other"], _selectedGender,
                    (val) => setState(() => _selectedGender = val)),
            _buildTextField("Birthday (DD/MM/YYYY)", _birthdayController),
            _buildDropdown("Country/Region", ["India", "USA", "UK", "Canada", "Other"],
                _selectedCountry, (val) => setState(() => _selectedCountry = val)),
            _buildTextField("Bio", _bioController, maxLines: 3),

            const Divider(height: 30),
            const Text("Social Links", style: TextStyle(fontWeight: FontWeight.bold)),
            _buildTextField("Facebook Link", _facebookController),
            _buildTextField("Instagram Link", _instagramController),
            _buildTextField("Twitter Link", _twitterController),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save profile info logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile Updated!")),
                );
                Navigator.pop(context);
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? value,
      void Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items
            .map((item) =>
            DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
