import 'package:flutter/material.dart';
import 'package:gosh_app/core/constant/constant.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedVideo;

  Future<void> _pickVideo(ImageSource source) async {
    final XFile? video = await _picker.pickVideo(source: source);
    if (video != null) {
      setState(() {
        _selectedVideo = video;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Video selected: ${video.name}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Upload Video'),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.cloud_upload, size: 60, color: kPrimaryColor),
                  const SizedBox(height: 10),
                  const Text(
                    'Choose your upload method',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.video_library, color: Colors.white),
                    label: const Text(
                      'Upload from Gallery',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () => _pickVideo(ImageSource.gallery),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.videocam, color: Colors.white),
                    label: const Text(
                      'Record from Camera',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () => _pickVideo(ImageSource.camera),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            if (_selectedVideo != null)
              Text(
                'Selected Video: ${_selectedVideo!.name}',
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
          ],
        ),
      ),
    );
  }
}
