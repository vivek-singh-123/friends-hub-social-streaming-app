import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

class LegalTextScreen extends StatelessWidget {
  final String title;
  final String content;

  const LegalTextScreen({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF0F2F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Html(
              data: content,
              style: {
                "body": Style(
                  fontSize: FontSize(14),
                  color: Colors.black54,
                  lineHeight: LineHeight(1.6),
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                ),
                "h1": Style(
                  fontSize: FontSize(24.0),
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  color: Colors.black,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  margin: Margins.only(top: 10.0, bottom: 15.0),
                ),
                "h5": Style(
                  fontSize: FontSize(16),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  margin: Margins.only(top: 12.0, bottom: 6.0),
                ),
                "p": Style(
                  color: Colors.black87,
                  lineHeight: LineHeight(1.7),
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  margin: Margins.only(bottom: 10.0),
                ),
                "li": Style(
                  color: Colors.black87,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  margin: Margins.only(bottom: 5.0),
                ),
                "br": Style(
                  height: Height(10.0),
                ),
              },
            ),
          ),
        ),
      ),
    );
  }
}
