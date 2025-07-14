import 'package:flutter/material.dart';

class GetRupeesScreen extends StatelessWidget {
  const GetRupeesScreen({super.key});

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
      appBar: AppBar(
        title: const Text('Get Rupees'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Purchase history coming soon!')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Choose Your Coin Pack',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.3,
              ),
              itemCount: coinOffers.length,
              itemBuilder: (context, index) {
                final offer = coinOffers[index];
                return GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('You selected ${offer['coins']} coins for ${offer['price']}'),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.deepPurple, width: 1),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.monetization_on, color: Colors.amber.shade600, size: 32),
                        const SizedBox(height: 8),
                        Text(
                          '${offer['coins']} Coins',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          offer['price'],
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
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
    );
  }
}
