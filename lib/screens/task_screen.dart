import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Complete Profile Setup', 'done': false},
    {'title': 'Go Live for 10 Minutes', 'done': false},
    {'title': 'Invite 3 Friends', 'done': true},
    {'title': 'Earn 100 Rupees', 'done': false},
    {'title': 'Send a Gift', 'done': true},
    {'title': 'Watch 5 Streams', 'done': false},
  ];

  void _toggleTask(int index) {
    setState(() {
      _tasks[index]['done'] = !_tasks[index]['done'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Tasks')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return Card(
            child: ListTile(
              leading: Icon(
                task['done'] ? Icons.check_circle : Icons.radio_button_unchecked,
                color: task['done'] ? Colors.green : Colors.grey,
              ),
              title: Text(
                task['title'],
                style: TextStyle(
                  decoration: task['done'] ? TextDecoration.lineThrough : null,
                  color: task['done'] ? Colors.grey : Colors.white,
                ),
              ),
              trailing: TextButton(
                onPressed: () => _toggleTask(index),
                child: Text(task['done'] ? 'Undo' : 'Complete'),
              ),
            ),
          );
        },
      ),
    );
  }
}
