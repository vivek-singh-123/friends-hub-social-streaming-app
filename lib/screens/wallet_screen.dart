import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  final int coinBalance = 2500; // Example balance

  final List<Map<String, dynamic>> coinOptions = [
    {'coins': 700, 'price': 100},
    {'coins': 7000, 'price': 1000},
    {'coins': 21000, 'price': 3000},
    {'coins': 42000, 'price': 6000},
    {'coins': 70000, 'price': 10000},
    {'coins': 105000, 'price': 15000},
  ];

  WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Wallet'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🪙 Coin Balance
            Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.orange, size: 28),
                const SizedBox(width: 8),
                Text(
                  '$coinBalance Coins',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            const Text(
              "Select Amount",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // 💰 Coin Options
            Expanded(
              child: GridView.builder(
                itemCount: coinOptions.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final item = coinOptions[index];
                  return GestureDetector(
                    onTap: () {
                      // TODO: Add purchase action here
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${item['coins']} Coins',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '₹${item['price']}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
