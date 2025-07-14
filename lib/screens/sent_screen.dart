import 'package:flutter/material.dart';
import '../utils/user_data.dart';

class SentScreen extends StatefulWidget {
  const SentScreen({super.key});

  @override
  State<SentScreen> createState() => _SentScreenState();
}

class _SentScreenState extends State<SentScreen> {
  void _cancelRequest(String name) {
    setState(() {
      sentList.remove(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sent Requests')),
      body: ListView.builder(
        itemCount: sentList.length,
        itemBuilder: (context, index) {
          String name = sentList[index];
          return ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.deepPurple),
            title: Text(name),
            subtitle: const Text("Follow request sent"),
            trailing: TextButton(
              onPressed: () => _cancelRequest(name),
              child: const Text("Cancel", style: TextStyle(color: Colors.purple)),
            ),
          );
        },
      ),
    );
  }
}
