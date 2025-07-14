import 'package:flutter/material.dart';
import '../utils/user_data.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  void _removeUser(String name) {
    setState(() {
      followersList.remove(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Followers')),
      body: ListView.builder(
        itemCount: followersList.length,
        itemBuilder: (context, index) {
          String name = followersList[index];
          return ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.deepPurple),
            title: Text(name),
            subtitle: const Text("Follows you"),
            trailing: TextButton(
              onPressed: () => _removeUser(name),
              child: const Text("Remove", style: TextStyle(color: Colors.purple)),
            ),
          );
        },
      ),
    );
  }
}
