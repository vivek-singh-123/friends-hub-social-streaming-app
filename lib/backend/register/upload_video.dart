import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class UploadService {
  static const String _uploadUrl =
      'https://friends.anklegaming.live/APIs/APIs.asmx/UploadVidoes';
  static Future<bool> uploadVideo({
    required String token,
    required File videoFile,
    required String type,
  }) async {
    try {
      final uri = Uri.parse(_uploadUrl);

      final request = http.MultipartRequest('POST', uri)
        ..fields['token'] = token
        ..fields['Type'] = type
        ..files.add(
          await http.MultipartFile.fromPath(
            'videos',
            videoFile.path,
            filename: basename(videoFile.path),
          ),
        );

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print('✅ Upload successful');
        print(responseBody);
        return true;
      } else {
        print('❌ Upload failed with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('❌ Upload exception: $e');
      return false;
    }
  }
}
