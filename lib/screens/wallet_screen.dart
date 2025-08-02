import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'transactions_screen.dart'; // Import the transactions screen

class WalletScreen extends StatelessWidget {
  final int coinBalance = 0;

  final List<Map<String, dynamic>> coinOffers = const [
    {'coins': 100, 'price': '₹10'},
    {'coins': 500, 'price': '₹45'},
    {'coins': 1000, 'price': '₹85'},
    {'coins': 2500, 'price': '₹200'},
    {'coins': 5000, 'price': '₹390'},
    {'coins': 10000, 'price': '₹750'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: Text(
          'Wallet',
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.orange.shade700,
        foregroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Navigate to the TransactionsScreen
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TransactionsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Choose Your Coin Pack',
            style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.3,
              ),
              itemCount: coinOffers.length,
              itemBuilder: (context, index) {
                final offer = coinOffers[index];
                return GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'You selected ${offer['coins']} coins for ${offer['price']}',
                            style: GoogleFonts.poppins()),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.orange.shade300, width: 1),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.monetization_on, color: Colors.amber.shade700, size: 38),
                          const SizedBox(height: 8),
                          Text(
                            '${offer['coins']} Coins',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            offer['price'],
                            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}