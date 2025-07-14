import 'package:flutter/material.dart';
import 'user_data.dart';

class UserListScreen extends StatefulWidget {
  final String title;
  final List<String> users;

  const UserListScreen({
    super.key,
    required this.title,
    required this.users,
  });

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late List<String> displayedUsers;

  @override
  void initState() {
    super.initState();
    displayedUsers = List.from(widget.users);
  }

  void _removeUser(int index) {
    final removedUser = displayedUsers[index];
    setState(() {
      displayedUsers.removeAt(index);
    });

    // Static list update
    switch (widget.title.toLowerCase()) {
      case 'followers':
        followersList.remove(removedUser);
        break;
      case 'following':
        followingList.remove(removedUser);
        break;
      case 'sent':
        sentList.remove(removedUser);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
      ),
      body: displayedUsers.isEmpty
          ? const Center(child: Text("No users to show"))
          : ListView.builder(
        itemCount: displayedUsers.length,
        itemBuilder: (context, index) {
          final name = displayedUsers[index];
          return ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/default_avatar.png'),
            ),
            title: Text(name),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle, color: Colors.red),
              onPressed: () => _removeUser(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.check),
        label: const Text('Done'),
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.pop(context, displayedUsers);
        },
      ),
    );
  }
}
