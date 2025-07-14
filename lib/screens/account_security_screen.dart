import 'package:flutter/material.dart';

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
      appBar: AppBar(title: const Text('Account Security')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Login Methods', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SwitchListTile(
            title: const Text('2-Step Verification'),
            subtitle: const Text('Require a second verification step when logging in.'),
            value: _twoStepEnabled,
            onChanged: (value) => setState(() => _twoStepEnabled = value),
          ),
          SwitchListTile(
            title: const Text('Enable Fingerprint Login'),
            value: _fingerprintEnabled,
            onChanged: (value) => setState(() => _fingerprintEnabled = value),
          ),
          SwitchListTile(
            title: const Text('Enable Face ID Login'),
            value: _faceIdEnabled,
            onChanged: (value) => setState(() => _faceIdEnabled = value),
          ),

          const Divider(),
          const Text('Change Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TextField(
            obscureText: !_showPassword,
            decoration: InputDecoration(
              labelText: 'Current Password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => _showPassword = !_showPassword),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'New Password',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm New Password',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password changed successfully.')),
            ),
            child: const Text('Update Password'),
          ),

          const Divider(),
          ListTile(
            title: const Text('View Login History'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login history feature coming soon...')),
              );
            },
          ),
        ],
      ),
    );
  }
}
