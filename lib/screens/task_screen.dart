import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

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
      // Optional: Show a SnackBar feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _tasks[index]['done'] ? 'Task completed!' : 'Task undone!',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: _tasks[index]['done'] ? Colors.green : Colors.orange,
          duration: const Duration(seconds: 1),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5), // Light grey background
      appBar: AppBar(
        title: Text(
          'Daily Tasks',
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600), // White text for orange app bar
        ),
        backgroundColor: Colors.orange.shade700, // Changed to orange
        foregroundColor: Colors.white, // Ensures icons are white
        elevation: 4, // Add some shadow
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16), // Consistent padding
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8), // Adjusted vertical margin
            elevation: 2, // Subtle shadow for the card
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Rounded corners for cards
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Adjusted padding inside ListTile
              leading: Icon(
                task['done'] ? Icons.check_circle_rounded : Icons.radio_button_unchecked, // Slightly better icon
                size: 28, // Consistent icon size
                color: task['done'] ? Colors.green.shade700 : Colors.orange.shade700, // Themed colors
              ),
              title: Text(
                task['title'],
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  decoration: task['done'] ? TextDecoration.lineThrough : null,
                  color: task['done'] ? Colors.grey.shade600 : Colors.black87, // Color based on done state
                ),
              ),
              trailing: TextButton(
                onPressed: () => _toggleTask(index),
                style: TextButton.styleFrom(
                  foregroundColor: task['done'] ? Colors.grey.shade600 : Colors.orange.shade700, // Themed colors
                  textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                child: Text(task['done'] ? 'Undo' : 'Complete'),
              ),
            ),
          );
        },
      ),
    );
  }
}