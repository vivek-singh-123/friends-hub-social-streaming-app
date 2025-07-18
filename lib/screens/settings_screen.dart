import 'package:flutter/material.dart';
import 'package:gosh_app/screens/legal_text_screen.dart'; // Reusable screen
import 'package:google_fonts/google_fonts.dart'; // For consistent typography

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Removed _notificationsEnabled as the option is removed
  bool _hideFavorites = false;
  bool _hideLikes = false;
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5), // Lighter background for contrast
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // Ensures text and icons are black
        iconTheme: const IconThemeData(color: Colors.black), // Explicitly set back button color to black
        elevation: 1,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('Privacy Settings'),
          _buildCard([
            _buildSwitchTile('Hide my favorites', _hideFavorites,
                    (val) => setState(() => _hideFavorites = val)),
            _buildSwitchTile('Hide my likes', _hideLikes,
                    (val) => setState(() => _hideLikes = val)),
          ]),

          const SizedBox(height: 20), // Increased spacing
          _buildCard([
            _buildListTile('Privilege Setting', onTap: () {
              // Added functionality for Privilege Setting
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Privilege settings tapped!', style: GoogleFonts.poppins()),
                  backgroundColor: Colors.blueAccent,
                ),
              );
              // You can navigate to a new screen or show a dialog here
            }),
          ]),

          const SizedBox(height: 20), // Increased spacing
          _buildCard([
            _buildListTile('Clear Cache', onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Cache cleared', style: GoogleFonts.poppins()),
                  backgroundColor: Colors.green,
                ),
              );
            }, leadingIcon: Icons.delete_outline), // Added leading icon
          ]),

          const SizedBox(height: 20), // Increased spacing
          _buildSectionTitle('About Us'),
          _buildCard([
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20), // Increased padding
                child: Column(
                  children: [
                    Icon(Icons.live_tv, size: 70, color: Colors.deepPurple.shade700), // Larger, darker purple
                    const SizedBox(height: 8), // Increased spacing
                    Text(
                      'Friends HUB v1.0.0',
                      style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black87), // Styled text
                    ),
                  ],
                ),
              ),
            ),
          ]),

          const SizedBox(height: 20), // Increased spacing
          _buildCard([
            _buildListTile('Terms and Conditions', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LegalTextScreen(
                    title: 'Terms & Conditions',
                    content: termsContent,
                  ),
                ),
              );
            }),
            _buildListTile('Privacy Policy', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LegalTextScreen(
                    title: 'Privacy Policy',
                    content: privacyContent,
                  ),
                ),
              );
            }),
          ]),

          const SizedBox(height: 20), // Increased spacing
          _buildSectionTitle('Feedback'),
          _buildCard([
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10), // Padding for rating stars
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < _selectedRating ? Icons.star : Icons.star_border,
                      color: Colors.amber.shade700, // Darker amber
                      size: 30, // Larger stars
                    ),
                    onPressed: () => setState(() => _selectedRating = index + 1),
                  );
                }),
              ),
            )
          ]),
          const SizedBox(height: 20), // Space at the bottom
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title, style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87)), // Styled text
      value: value,
      onChanged: onChanged,
      activeColor: Colors.deepPurple, // Consistent color
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), // Adjusted padding
    );
  }

  Widget _buildListTile(String title, {VoidCallback? onTap, IconData? leadingIcon}) {
    return ListTile(
      leading: leadingIcon != null ? Icon(leadingIcon, color: Colors.grey[600], size: 24) : null, // Optional leading icon
      title: Text(title, style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87)), // Styled text
      trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey), // Slightly larger icon
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), // Adjusted padding
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Card(
      color: Colors.white,
      elevation: 4, // More prominent shadow
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // More rounded corners
      child: Column(children: children),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10), // Adjusted padding
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.grey[700]), // Styled text
        ),
      ),
    );
  }
}

// Full Terms & Conditions (Shortened)
const String termsContent = '''
                                        <h1>Terms & Conditions</h1>
</br>
Welcome to Friends HUB!
</br>
We've drafted these Terms of Service (the "Terms") so that you'll know the rules that govern our relationship with you. These Terms form a legally binding contract between you and Gosh Streaming PTY LTD. Please read them carefully.
</br>
By using the Services, you agree to the Terms. If you do not agree with them, then do not use the Services.
</br>
<h5>1. Who Can Use the Services</h5>
No one under 18 is allowed to create an account or use the Services. By using the Services, you state that you can form a binding contract with Gosh and will comply with these Terms and all applicable laws.
</br>
<h5>2. Rights We Grant You</h5>
Gosh grants you a personal, worldwide, royalty-free, non-assignable, nonexclusive, revocable, and non-sublicensable license to access and use the Services for their sole purpose. You may not copy, modify, distribute, sell, or lease any part of our Services without written permission.
</br>
<h5>3. Rights You Grant Us</h5>
You retain ownership rights in content you create, upload, post, send, receive, and store. You grant Gosh a worldwide, royalty-free, sublicensable, and transferable license to use that content for operating, developing, providing, promoting, and improving the Services.
</br>
<h5>4. The Content of Others</h5>
Much content on our Services is produced by users and third parties. While Gosh may review and remove violating content, we do not guarantee all content conforms to our Terms and are not responsible for content provided by others.
</br>
<h5>5. Privacy</h5>
Your privacy matters. Our Privacy Policy explains how we handle your information. By using our Services, you agree that Gosh can collect, use, and transfer your information consistent with that policy.
</br>
<h5>6. Respecting Other People's Rights</h5>
You may not upload, send, or store content that violates others' rights (publicity, privacy, copyright, trademark), bullies, harasses, intimidates, defames, spams, or is inappropriate/illegal. You must also respect Gosh's rights and not use our Services for unauthorized commercial purposes.
</br>
<h5>7. Respecting Copyright</h5>
Only upload content you have the lawful right to use and that does not infringe intellectual property rights. Gosh complies with the Digital Millennium Copyright Act and will remove infringing material and may terminate accounts of repeat infringers.
</br>
<h5>8. Safety</h5>
We strive for a safe environment, but cannot guarantee it. You agree not to use Services for illegal purposes, to interfere with others, misuse accounts, post harmful content, or compromise security.
</br>
<h5>9. Your Account</h5>
You are responsible for your account's security. Do not create multiple accounts, share passwords, or use unauthorized third-party applications. Contact Gosh Support for account access concerns.
</br>
<h5>10. Data Charges and Mobile Phones</h5>
You are responsible for any mobile charges incurred from using our Services.
</br>
<h5>11. Third-Party Services</h5>
Third-party services available through our platform are governed by their respective terms. Gosh is not responsible for those terms or actions.
</br>
<h5>12. Modifying the Services and Termination</h5>
We may add/remove features, suspend/stop Services, or terminate Terms at any time without notice.
</br>
<h5>13. Indemnity</h5>
You agree to indemnify Gosh against complaints, claims, damages, and expenses arising from your use of Services, content, or breach of Terms.
</br>
<h5>14. Disclaimers</h5>
Services are provided "as is" and "as available" without warranties. Gosh does not guarantee security, error-free operation, or accuracy of content.
</br>
<h5>15. Limitation of Liability</h5>
To the maximum extent permitted by law, Gosh will not be liable for indirect, incidental, special, consequential, punitive, or multiple damages, or loss of profits, data, or goodwill.
</br>
<h5>16. Arbitration</h5>
Disputes will be settled by amicable negotiation, then submitted to Australia International Arbitration Centre for arbitration.
</br>
<h5>17. Choice of Law</h5>
These Terms are governed by the laws of Australia.
</br>
<h5>18. Severability</h5>
If any provision is unenforceable, it will be severed without affecting other provisions.
</br>
<h5>19. Additional Terms for Specific Services</h5>
Additional terms for specific Services become part of your agreement if you use those Services.
</br>
<h5>20. Final Terms</h5>
These Terms constitute the entire agreement. We reserve all rights not expressly granted.
<h5>Contact Us</h5>
Friends HUB welcomes comments, questions, concerns, or suggestions. Please send feedback to us by visiting [https://gosh0.com](https://gosh0.com)<br>
Friends HUB is operated by Friends HUB Streaming PTY LTD. ''';

// Full Privacy Policy (Shortened)
const String privacyContent = '''
                       <h1>Privacy Policy</h1>
<h5>1. INTRODUCTION</h5>
This is the Privacy Policy of Gosh Streaming PTY LTD and Gosh and its various & next versions (collectively "Gosh", "us", "we", or "our"). It is incorporated into our Terms of Use. Your use of the Service signifies that you agree with this Privacy Policy.
</br>
<h5>2. INFORMATION WE COLLECT</h5>
We collect personal data based on your interactions, services used, and choices. This includes information you provide directly (name, email, gender), information collected automatically, and data from third-party sources.
</br>
When users sign in with Google, Gosh collects their nickname and avatar from Google for default use, which users can change. This data is kept confidential.
</br>
Face data: Used for special effects or emojis in streaming/pictures, processed offline, and not used for other purposes without explicit consent. Not used for marketing/advertising, nor shared with third parties. Real-Person Profile Picture Authentication collects profile picture and facial-recognition video for verification only; video is not retained on our servers.
</br>
User Content: Includes comments, texts, messages, pictures, videos, and audio. Gosh retains and processes this data to comply with content regulations.
''';
