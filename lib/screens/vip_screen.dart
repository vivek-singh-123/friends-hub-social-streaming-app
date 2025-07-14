import 'package:flutter/material.dart';

class VipScreen extends StatelessWidget {
  const VipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('VIP', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // top profile + badge
            Row(
              children: const [
                CircleAvatar(radius: 28, backgroundImage: AssetImage('assets/default_avatar.png')),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('sukhram', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('Not VIP yet', style: TextStyle(color: Colors.white70)),
                  ],
                ),
                Spacer(),
                Image(
                  image: AssetImage('assets/vip_wolf.png'), // 🔁 Replace with your VIP image
                  height: 50,
                )
              ],
            ),
            const SizedBox(height: 20),

            // VIP tab selection
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[900],
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text('VIP1', style: TextStyle(color: Colors.white)),
                  Text('VIP2', style: TextStyle(color: Colors.white54)),
                  Text('VIP3', style: TextStyle(color: Colors.white54)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Feature list
            ...[
              _buildVipTile('Daily Coin', 'Exclusive check-in reward, 150~250/day', Icons.monetization_on),
              _buildVipTile('Nameplate', 'Showcase VIP Prestige', Icons.badge),
              _buildVipTile('Avatar Frame', 'Exclusive Avatar Frame', Icons.account_circle),
              _buildVipTile('Vehicle', 'Cool Entrance Effect', Icons.car_rental),
              _buildVipTile('Chat Bubble', 'Shining Chat Messages', Icons.chat_bubble_outline),
              _buildVipTile('Profile Card Skin', 'Unique and Exclusive Decoration', Icons.credit_card),
            ],

            const SizedBox(height: 30),

            // Buy button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFFC107)],
                ),
              ),
              child: const Center(
                child: Text('₹19999 /30days', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildVipTile(String title, String subtitle, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.amber),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
