import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String selectedBill = 'Deposit';
  String selectedTimeRange = 'Past 24 hours';
  String selectedAsset = 'All Assets';
  String selectedCategory = 'All Type';

  final List<String> billOptions = ['Deposit'];
  final List<String> timeRangeOptions = [
    'Past 24 hours',
    'Past 7 days',
    'Past 30 days',
    'Past 60 days',
    'Custom'
  ];
  final List<String> assetOptions = ['All Assets'];
  final List<String> categoryOptions = ['All Type', 'Game', 'Post', 'Live', 'Other'];

  final List<Map<String, String>> transactions = [
    {'title': 'Recharge Bonus', 'amount': '+ ₹100'},
    {'title': 'Live Event', 'amount': '- ₹50'},
    {'title': 'Post Boost', 'amount': '- ₹30'},
  ];

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Deposit Issues or Disputes'),
        content: const Text(
          'For deposit issues or disputes, please contact support or refer to our policy section.',
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Got it',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupSelector({
    required String title,
    required List<String> options,
    required String selectedValue,
    required void Function(String) onSelected,
  }) {
    return Expanded(
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: PopupMenuButton<String>(
          onSelected: onSelected,
          color: Colors.black, // dropdown background
          offset: const Offset(0, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          itemBuilder: (context) => options
              .map((option) => PopupMenuItem<String>(
            value: option,
            child: Text(
              option,
              style: const TextStyle(color: Colors.white),
            ),
          ))
              .toList(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedValue,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        const Text('Transactions', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.black),
            onPressed: _showInfoDialog,
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF5F6FA),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔁 Filter Row 1: Bill + Asset
            Row(
              children: [
                _buildPopupSelector(
                  title: "Bill",
                  options: billOptions,
                  selectedValue: selectedBill,
                  onSelected: (val) => setState(() => selectedBill = val),
                ),
                const SizedBox(width: 12),
                _buildPopupSelector(
                  title: "Asset",
                  options: assetOptions,
                  selectedValue: selectedAsset,
                  onSelected: (val) => setState(() => selectedAsset = val),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 🔁 Filter Row 2: Time + Category
            Row(
              children: [
                _buildPopupSelector(
                  title: "Time",
                  options: timeRangeOptions,
                  selectedValue: selectedTimeRange,
                  onSelected: (val) => setState(() => selectedTimeRange = val),
                ),
                const SizedBox(width: 12),
                _buildPopupSelector(
                  title: "Category",
                  options: categoryOptions,
                  selectedValue: selectedCategory,
                  onSelected: (val) => setState(() => selectedCategory = val),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 📋 Transactions List
            Expanded(
              child: transactions.isEmpty
                  ? const Center(
                child: Text(
                  "No transactions found",
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : ListView.separated(
                itemCount: transactions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = transactions[index];
                  final isPositive = item['amount']!.contains('+');
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 4,
                          offset: const Offset(1, 1),
                        )
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor:
                        isPositive ? Colors.green[50] : Colors.red[50],
                        child: Icon(
                          isPositive ? Icons.arrow_downward : Icons.arrow_upward,
                          color: isPositive ? Colors.green : Colors.red,
                        ),
                      ),
                      title: Text(
                        item['title']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Text(
                        item['amount']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isPositive ? Colors.green : Colors.red,
                          fontSize: 15,
                        ),
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
