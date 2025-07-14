import 'package:flutter/material.dart';
import '../utils/user_data.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  void _unfollowUser(String name) {
    setState(() {
      followingList.remove(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Following')),
      body: ListView.builder(
        itemCount: followingList.length,
        itemBuilder: (context, index) {
          String name = followingList[index];
          return ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.deepPurple),
            title: Text(name),
            subtitle: const Text("You follow this user"),
            trailing: TextButton(
              onPressed: () => _unfollowUser(name),
              child: const Text("Unfollow", style: TextStyle(color: Colors.purple)),
            ),
          );
        },
      ),
    );
  }
}
