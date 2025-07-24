import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class AccountSecurityScreen extends StatefulWidget {
  const AccountSecurityScreen({super.key});

  @override
  State<AccountSecurityScreen> createState() => _AccountSecurityScreenState();
}

class _AccountSecurityScreenState extends State<AccountSecurityScreen> {
  bool _twoStepEnabled = false;
  bool _fingerprintEnabled = false;
  bool _faceIdEnabled = false;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5), // Light grey background
      appBar: AppBar(
        title: Text(
          'Account Security',
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600), // White text for orange app bar
        ),
        backgroundColor: Colors.orange.shade700, // Changed to orange
        foregroundColor: Colors.white, // Ensures icons are white
        elevation: 4, // Add some shadow
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('Login Methods'),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  _buildSecuritySwitchTile(
                    '2-Step Verification',
                    'Require a second verification step when logging in.',
                    _twoStepEnabled,
                        (value) => setState(() => _twoStepEnabled = value),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildSecuritySwitchTile(
                    'Enable Fingerprint Login',
                    null, // No subtitle
                    _fingerprintEnabled,
                        (value) => setState(() => _fingerprintEnabled = value),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildSecuritySwitchTile(
                    'Enable Face ID Login',
                    null, // No subtitle
                    _faceIdEnabled,
                        (value) => setState(() => _faceIdEnabled = value),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          _buildSectionTitle('Change Password'),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildPasswordField(
                    'Current Password',
                    _showPassword,
                        (value) => setState(() => _showPassword = value),
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                    'New Password',
                    true, // Obscure text
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                    'Confirm New Password',
                    true, // Obscure text
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity, // Make button full width
                    child: ElevatedButton(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Password changed successfully!', style: GoogleFonts.poppins()),
                          backgroundColor: Colors.green,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Orange button
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 4,
                        textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      child: const Text('Update Password'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          _buildSectionTitle('Other'),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(
                'View Login History',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Login history feature coming soon...', style: GoogleFonts.poppins()),
                    backgroundColor: Colors.blueAccent,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20), // Padding at the bottom
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 8), // Adjusted padding
      child: Text(
        title,
        style: GoogleFonts.poppins(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[700]),
      ),
    );
  }

  Widget _buildSecuritySwitchTile(
      String title, String? subtitle, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
      ),
      subtitle: subtitle != null
          ? Text(
        subtitle,
        style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600]),
      )
          : null,
      value: value,
      onChanged: onChanged,
      activeColor: Colors.orange, // Orange switch
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildTextField(String label, bool obscureText) {
    return TextField(
      obscureText: obscureText,
      style: GoogleFonts.poppins(color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.orange, width: 2), // Orange focus border
        ),
        filled: true,
        fillColor: Colors.grey.shade50, // Light fill color
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildPasswordField(String label, bool showPassword, ValueChanged<bool> onToggleVisibility) {
    return TextField(
      obscureText: !showPassword,
      style: GoogleFonts.poppins(color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.orange, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: IconButton(
          icon: Icon(
            showPassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey[600],
          ),
          onPressed: () => onToggleVisibility(!showPassword),
        ),
      ),
    );
  }
}