import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gosh_app/core/constant/constant.dart';
import 'package:gosh_app/backend/register/upload_video.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedVideo;
  bool _isUploading = false;

  // Replace with your actual token
  final String token = 'dljaklejidnjkd';

  Future<void> _pickVideo(ImageSource source) async {
    final XFile? video = await _picker.pickVideo(source: source);
    if (video != null) {
      setState(() {
        _selectedVideo = video;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('🎬 Video selected: ${video.name}')),
      );
    }
  }

  Future<void> _uploadVideo() async {
    if (_selectedVideo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a video first.')),
      );
      return;
    }

    setState(() => _isUploading = true);

    // Dynamically get the file extension/type
    final String videoType =
    _selectedVideo!.path.split('.').last.toLowerCase();

    final success = await UploadService.uploadVideo(
      token: token,
      videoFile: File(_selectedVideo!.path),
      type: videoType,
    );

    setState(() => _isUploading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? '✅ Video uploaded successfully' : '❌ Upload failed',
        ),
      ),
    );
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
                '📁 Selected Video: ${_selectedVideo!.name}',
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            const SizedBox(height: 20),
            if (_selectedVideo != null)
              ElevatedButton.icon(
                icon: _isUploading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : const Icon(Icons.upload_file, color: Colors.white),
                label: Text(
                  _isUploading ? 'Uploading...' : 'Upload Video',
                  style: const TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: _isUploading ? null : _uploadVideo,
              ),
          ],
        ),
      ),
    );
  }
}
