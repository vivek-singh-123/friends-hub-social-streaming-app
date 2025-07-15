import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class LegalTextScreen extends StatelessWidget {
  final String title;
  final String content;

  const LegalTextScreen({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Html(
            data: content,
            style: {
              "body": Style(
                fontSize: FontSize(14),
                color: Colors.black54,
                lineHeight: LineHeight(1.6),
              ),
              "h1": Style(
                fontSize: FontSize(30),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              "h5": Style(
                fontSize: FontSize(16),
                fontWeight: FontWeight.bold, // ✅ BOLD for h5
                color: Colors.black,
              ),
              "p": Style(
                color: Colors.black,
              ),
              "li": Style(
                color: Colors.black,
              ),
            },
          ),
        ),
      ),
    );
  }
}
